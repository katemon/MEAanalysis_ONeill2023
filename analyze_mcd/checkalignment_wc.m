function [wc_spikevolts, wc_spikeiters, NtoElim] = checkalignment_wc(check_spikevolts, check_spikeiters, ...
    myfiltchunk, thiselectrode, chunkN, chunksize, totaltime, rawfileloc)

NtoElim = 0;

fileInfo = datastrm(rawfileloc); % update 2021-05-21

%filter parameters
fs = 20000;
N = 4; %filter order
Wn = [100, 3000]./(fs/2); %bandpass filter (allow data between 20Hz and 2000Hz)
%also try between 100Hz and 300Hz
[b,a]=butter(N,Wn); %butterworth bandpass filter 4th order
%notch filter to get rid of 60 Hz
wo = 60/(fs/2);
bw = wo/35;
[b2,a2] = iirnotch(wo,bw);

% figure out if local max/min is aligned at 20
% if not, check from iteration 10 to 35 for the local maximum/minimum
%if do absolute value, it *should* take care of both pos and neg spks
[~,check_c] = max(abs(check_spikevolts));
if check_c~=20 %do shift
    
    if (check_c>=10 && check_c<=35)
        ShiftAmt = check_c - 20; %shift by this amount
        
        if ShiftAmt>0 %shift to left, check_c is to right of (later than) 20th iter
                checkend = check_spikeiters(end) + ShiftAmt;
                
            if ((chunkN==totaltime/chunksize) && (checkend>(20*chunksize))) %can't do it because necessary time range would be after recording ends
                wc_spikeiters = check_spikeiters.*0;
                wc_spikevolts = check_spikevolts.*0;
                NtoElim = NtoElim + 1;
            else
                check_spikevolts(1:end-ShiftAmt) = check_spikevolts(ShiftAmt+1:end);
                check_spikevolts(end-ShiftAmt+1:end) = Inf; %assign end to Inf
                check_spikeiters(1:end-ShiftAmt) = check_spikeiters(ShiftAmt+1:end);
                check_spikeiters(end-ShiftAmt+1:end) = check_spikeiters(end-ShiftAmt+1:end) + ShiftAmt;
                
                %NOW GET MISSING DATA
                EndSpkRange = check_spikeiters(end);
                %if past end of filtchunk, need to get more data
                if (EndSpkRange>(20*chunksize))
                    NumExT = ShiftAmt; %if EndSpkRange=(20*chunksize)+1, only 1 extra time
                    TheExT = check_spikeiters(end-NumExT+1:end);
                    RealExT = (chunkN-1)*chunksize*20+TheExT; %in iterations of whole recording, not iterations of that chunk
                    %added 24 time points so that you can filter
                    if RealExT(1)-24<=0
                        wc_spikeiters = check_spikeiters.*0;
                        wc_spikevolts = check_spikevolts.*0;
                        NtoElim = NtoElim + 1;
                    else
                        RealTime = [RealExT(1)-24, RealExT(end)+1]/20; %convert to actual time of whole recording, in msec
                        
                        exChunkInfo = nextdata(fileInfo,'startend',RealTime,'streamname','Electrode Raw Data'); % update 2021-05-21
                        ExChunk = exChunkInfo.data; % update 2021-05-21 %when you put in time, it gives you iterations. cannot put in iterations.
                        ExChunk_filt1 = filtfilt(b,a,ExChunk); % bp filter
                        ExChunk_filt2 = filtfilt(b2,a2,ExChunk_filt1); % notch filter
                        
                        check_spikevolts(end-ShiftAmt+1:end) = ExChunk_filt2(thiselectrode,25:end);
                        wc_spikevolts = check_spikevolts;
                        wc_spikeiters = check_spikeiters;
                    end %if RealExt
                    
                else
                    check_spikevolts(end-ShiftAmt+1:end) = myfiltchunk(check_spikeiters(end-ShiftAmt+1:end));
                    wc_spikevolts = check_spikevolts;
                    wc_spikeiters = check_spikeiters;
                end %if EndSpkRange
                
            end %if chunkN
            
        elseif ShiftAmt<0 %shift to right, check_c is to left of (earlier than) 20th iter
            checkbeg = check_spikeiters(1) - ShiftAmt;
            
            if ((chunkN==1) && (checkbeg<=0)) %can't do it because necessary time range would be before recording starts
                wc_spikeiters = check_spikeiters.*0;
                wc_spikevolts = check_spikevolts.*0;
                NtoElim = NtoElim + 1;
            else
                check_spikevolts(-ShiftAmt+1:end) = check_spikevolts(1:end+ShiftAmt); %end+ShiftAmt<end because ShiftAmt is neg
                check_spikevolts(1:-ShiftAmt) = Inf; %assign beginning to Inf
                check_spikeiters(-ShiftAmt+1:end) = check_spikeiters(1:end+ShiftAmt); %end+ShiftAmt<end because ShiftAmt is neg
                check_spikeiters(1:-ShiftAmt) = check_spikeiters(1:-ShiftAmt) + ShiftAmt;
                
                %NOW GET MISSING DATA
                BeginSpkRange = check_spikeiters(1);
                %if before beginning of filtchunk, need to get more data
                if BeginSpkRange<=0
                    NumNegT = abs(ShiftAmt); %if patchIrange already has neg numbers, need to do it this way
                    TheNegT = check_spikeiters(1:NumNegT);
                    RealNegT = (chunkN-1)*chunksize*20+TheNegT; %in iterations of whole recording, not iterations of that chunk
                    
                    if RealNegT(1)-24<=0
                        wc_spikeiters = check_spikeiters.*0;
                        wc_spikevolts = check_spikevolts.*0;
                        NtoElim = NtoElim + 1;
                    else
                        RealTime = [RealNegT(1)-24, RealNegT(end)+1]/20; %convert to actual time of whole recording, in msec
                        
                        negChunkInfo = nextdata(fileInfo,'startend',RealTime,'streamname','Electrode Raw Data'); % update 2021-05-21
                        NegChunk = negChunkInfo.data; % update 2021-05-21 %when you put in time, it gives you iterations. cannot put in iterations.
                        NegChunk_filt1 = filtfilt(b,a,NegChunk); % bp filter
                        NegChunk_filt2 = filtfilt(b2,a2,NegChunk_filt1); % notch filter
                        
                        check_spikevolts(1:-ShiftAmt) = NegChunk_filt2(thiselectrode,25:end);
                        wc_spikevolts = check_spikevolts;
                        wc_spikeiters = check_spikeiters;
                    end %if RealExt
                else
                    check_spikevolts(1:-ShiftAmt) = myfiltchunk(check_spikeiters(1:-ShiftAmt));
                    wc_spikevolts = check_spikevolts;
                    wc_spikeiters = check_spikeiters;
                end %if BeginSpkRange
                
            end %if chunkN
        end %if ShiftAmt
        
    else %if not within acceptable range
        wc_spikeiters = check_spikeiters.*0;
        wc_spikevolts = check_spikevolts.*0;
        NtoElim = NtoElim + 1;
        
    end %if check_c> && <...
    
else %if check_c = 20
    wc_spikevolts = check_spikevolts;
    wc_spikeiters = check_spikeiters;
end %if check_c


% vector10 = [10.*ones(size(checker,1),1), zeros(size(checker,1),1)];
% checker_within10 = abs(checker - vector10);
% % if 10 iterations in either direction, then okay
% if not, then throw it out

end %function