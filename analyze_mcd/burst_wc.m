function [patch_Vrange, patch_Irange, numtoelim, spikevoltage, spikeiter, spikeelectrode] ...
    = burst_wc(thesespikes,fileloc,chunknum,filtereddata,chunksize,spikevoltage,spikeiter,spikeelectrode)

%rename inputs
filtchunk = filtereddata;
chunkN = chunknum;
rawfileloc = fileloc;
chunkspikes = thesespikes;

totaltime = 300*1000; %total recording time in msec

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

[rzero,~] = find(spikeiter==0);
if ~isempty(rzero)
    chunkspikes = chunkspikes - length(rzero);
    spikeiter(rzero) = [];
    spikeelectrode(rzero) = [];
    spikevoltage(rzero) = [];
end %if ~isempty

patch_Vrange = zeros(chunkspikes,64);
patch_Irange = zeros(chunkspikes,64);
numtoelim = 0; %if spikes are too early or too late, will need to eliminate some data later
for jj=1:chunkspikes
    jj %for troubleshooting only
    TheSpikeIter = spikeiter(jj); %in iterations
    BeginSpkRange = TheSpikeIter-19;
    EndSpkRange = TheSpikeIter+44;
    patch_Irange(jj,:) = [BeginSpkRange:1:EndSpkRange]; %in iterations, respective to that chunk
    
    if BeginSpkRange<=0
        if chunkN==1 %can't do it because necessary time range would be before recording starts
            patch_Irange(jj,:) = 0;
            patch_Vrange(jj,:) = 0;
            numtoelim = numtoelim + 1;
            
        else
            disp('neg') %trial only *************************
            NumNegT = 0-BeginSpkRange+1; %if BeginSpkRange=0, only 1 negative time
            TheNegT = patch_Irange(jj,1:NumNegT);
            RealNegT = (chunkN-1)*chunksize*20+TheNegT; %in iterations of whole recording, not iterations of that chunk
            
            if RealNegT(1)-24<=0
                patch_Irange(jj,:) = 0;
                patch_Vrange(jj,:) = 0;
                numtoelim = numtoelim + 1;
            else
                %added 24 time points so that you can filter
                RealTime = [RealNegT(1)-24, RealNegT(end)+1]/20; %convert to actual time of whole recording, in msec
                NegChunk = getraw_uv(rawfileloc,RealTime); %when you put in time, it gives you iterations. cannot put in iterations.
                NegChunk_filt1 = filtfilt(b,a,NegChunk); % bp filter
                NegChunk_filt2 = filtfilt(b2,a2,NegChunk_filt1); % notch filter
                
                patch_Vrange(jj,:) = [NegChunk_filt2(spikeelectrode(jj),25:end), filtchunk(spikeelectrode(jj),1:EndSpkRange)];
                
                % ******************* %
                % NOW CHECK ALIGNMENT %
                [wc_spikevolts_new, wc_spikeiters_new, ifelim] = checkalignment_wc(patch_Vrange(jj,:), patch_Irange(jj,:), ...
                    filtchunk(spikeelectrode(jj),:), spikeelectrode(jj), chunkN, chunksize, totaltime, rawfileloc);
                numtoelim = numtoelim + ifelim;
                patch_Vrange(jj,:) = wc_spikevolts_new;
                patch_Irange(jj,:) = wc_spikeiters_new;
                % ******************* %
                
            end %if RealExT
            
        end %if chunkN
        
    elseif EndSpkRange>(20*chunksize) %20k sampling freq*10sec chunk is 200,000
        if (chunkN==totaltime/chunksize) %can't do it because necessary time range would be after recording ends
            patch_Irange(jj,:) = 0;
            patch_Vrange(jj,:) = 0;
            numtoelim = numtoelim + 1;
            
        else
            disp('pos') %trial only *********************
            NumExT = EndSpkRange-(20*chunksize); %if EndSpkRange=(20*chunksize)+1, only 1 extra time
            TheExT = patch_Irange(jj,end-NumExT+1:end);
            RealExT = (chunkN-1)*chunksize*20+TheExT; %in iterations of whole recording, not iterations of that chunk
            %added 24 time points so that you can filter
            if RealExT(1)-24<=0
                patch_Irange(jj,:) = 0;
                patch_Vrange(jj,:) = 0;
                numtoelim = numtoelim + 1;
            else
                RealTime = [RealExT(1)-24, RealExT(end)+1]/20; %convert to actual time of whole recording, in msec
                ExChunk = getraw_uv(rawfileloc,RealTime); %when you put in time, it gives you iterations
                ExChunk_filt1 = filtfilt(b,a,ExChunk); % bp filter
                ExChunk_filt2 = filtfilt(b2,a2,ExChunk_filt1); % notch filter
                
                patch_Vrange(jj,:) = [filtchunk(spikeelectrode(jj),BeginSpkRange:end), ExChunk_filt2(spikeelectrode(jj),25:end)];
                
                % ******************* %
                % NOW CHECK ALIGNMENT %
                [wc_spikevolts_new, wc_spikeiters_new, ifelim] = checkalignment_wc(patch_Vrange(jj,:), patch_Irange(jj,:), ...
                    filtchunk(spikeelectrode(jj),:), spikeelectrode(jj), chunkN, chunksize, totaltime, rawfileloc);
                numtoelim = numtoelim + ifelim;
                patch_Vrange(jj,:) = wc_spikevolts_new;
                patch_Irange(jj,:) = wc_spikeiters_new;
                % ******************* %
                
            end %if RealExT
        end %if chunkN
        
    else %normal situation
        patch_Vrange(jj,:) = filtchunk(spikeelectrode(jj),patch_Irange(jj,:));
        
        % ******************* %
        % NOW CHECK ALIGNMENT %
        [wc_spikevolts_new, wc_spikeiters_new, ifelim] = checkalignment_wc(patch_Vrange(jj,:), patch_Irange(jj,:), ...
                    filtchunk(spikeelectrode(jj),:), spikeelectrode(jj), chunkN, chunksize, totaltime, rawfileloc);
        numtoelim = numtoelim + ifelim;
        patch_Vrange(jj,:) = wc_spikevolts_new;
        patch_Irange(jj,:) = wc_spikeiters_new;
        % ******************* %
    end %if BeginSpkRange
    
end %for jj

end %function