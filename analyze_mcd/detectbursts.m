function [Nburstlets, ISI_c, overallISI, IBI_c, overallIBI, sortedBwidth_iter, sortedBwidth_time, ...
    sortedBbegin_iter, sortedBend_iter, sortedBelec, sorted_Itersinburst, sorted_Voltsinburst, ...
    sorted_Timesinburst, sorted_Nspikesinburst, sorted_Bbegin_allE, sorted_Bend_allE, ...
    EFireArray, EFireMatrix, Fc, EBurstMatrix, EBurstArray, globalBursts_beginI, globalBursts_endI, ...
	globalBursts_Elecs, globalBursts_NumBInGB, globalBursts_width_iter, globalBursts_AvgWidth_iter, ...
	globalBursts_AvgWidth_sec, globalBursts_AvgNumBInGB, NumGlobalBursts, globalIBI_iter, ...
	globalIBI_iterAvg, globalIBI_secAvg, synchfire, numfire] ....
    = detectbursts(SpikeVoltage, SpikeTime, SpikeElectrode, SpikeIter, fs, Ntot, Ttot, numChannels)


%new burst definition
%this includes everything in the old burstnumKMF and electrodecorrelationKMF
%m-files

% Ttot = 300; %in sec
% Ntot = 6000000; %in its

T100 = 0.100; %100 ms in sec
N100 = (Ntot/Ttot).*T100; %100 ms in its

T200 = 0.200; %200 ms in sec
N200 = (Ntot/Ttot).*T200; %200 ms in its

EFireArray = zeros(1,numChannels);
%calculate the total number of spikes each electrode fires
for ii=1:numChannels
    ESpikes = find(SpikeElectrode==ii);
    EFireArray(ii) = size(ESpikes,1);
end %for ii

% 2021-09-16 update: since the sMEA is not an 8x8, making this variable is
% a lot trickier.
elecLocs = [ 1,1; 1,2; 1,7; 1,8; 2,1; 2,2; 2,7; 2,8; 3,3; 3,4; 3,5; 3,6; ...
    4,1; 4,2; 4,3; 4,4; 4,5; 4,6; 5,3; 5,4; 5,5; 5,6; 6,1; 6,2; 6,7; ...
    6,8; 7,1; 7,2; 7,7; 7,8 ];
EFireMatrix=zeros(7,8);
for ii=1:numChannels
    EFireMatrix(elecLocs(ii,:)) = EFireArray(ii);
end %for ii

% PASS BACK TO MAIN %
Fc = EFireArray./Ttot; %firing rate for each electrode in time, #spikes/sec
overallspikediff1 = SpikeTime(1:end-1);
overallspikediff2 = SpikeTime(2:end);
overallISI = overallspikediff2 - overallspikediff1; %inter-spike interval in time; FOR HISTOGRAM
% PASS BACK TO MAIN %

fc = EFireArray./Ntot; %firing rate for each electrode in its
tc = 1./fc;
tc(tc==Inf) = 0;
Tc = zeros(size(fc));
Tc200 = zeros(size(fc)); %**********************
ISI_c = zeros(numChannels,max(EFireArray)-1);
Nburstlets = 0; % total number of burstlets
Eburstlets = zeros(numChannels,1); %burstlets on electrode
burstletwidth_iter = [];
burstletwidth_time = [];
Bbegin_iter = [];
Bend_iter = [];
Bbegin_allE = [];
Bend_allE = [];
Belec = [];
Nspikesinburst = [];
Itersinburst = cell(5,1); %iters in burst, randomly chose 5, just wanted to make it a column
Voltsinburst = cell(5,1); %volts in burst, randomly chose 5, just wanted to make it a column
Timesinburst = cell(5,1); %times in burst, randomly chose 5, just wanted to make it a column
% Find burstlets that occur on individual electrodes
for ii=1:numChannels %each electrode
    Bbegin = [];
    Bend = [];
    inburstlet = []; %reset before each electrode
    Tc(ii) = min((0.25.*tc(ii)), N100);
    Tc200(ii) = min((tc(ii)./3), N200); %% ****************
    [espikes_r, ~] = find(SpikeElectrode==ii); %find where that electrode spikes
    if isempty(espikes_r) %no spikes on that electrode
        ISI_c(ii,:) = 0;
    else %if ~isempty
        espikes_iter = SpikeIter(espikes_r); %get iterations of spikes
        espikes_time = SpikeTime(espikes_r); %get iterations of spikes
        espikes_volt = SpikeVoltage(espikes_r); %get iterations of spikes
        % calculate ISI between each spike on that electrode IN ITERS
        ISI_c(ii,1:length(espikes_iter)-1) = (espikes_iter(2:end) - espikes_iter(1:end-1))';
        % for every time isinburstlet = 1, there are 2 spikes
        inburstlet = ISI_c(ii,:)<=Tc(ii); %length will be TotalSpikesNum-1
        noburstlet = find(inburstlet==0); %indices where there isn't a burst
        thediff = noburstlet(2:end) - noburstlet(1:end-1); %subtract to find how many intervals are between not a burst
        burstloc = find(thediff>=4); %indices where >=4 spikes close together,
        %need at least 3 ones together (for example at columns 11, 12, and 13, so then 14-10=4)
        if ~isempty(burstloc)
            bindex_i = (noburstlet(burstloc)+1)'; %index in inburstlet where burst begins, if there is a string of 0s that ends at column 26, then the burst starts at column 27
            Bbegin = [Bbegin; bindex_i]; %column vector, only keep track per electrode
            Bbegin_allE = [Bbegin_allE; Bbegin]; %column vector, keep track for all electrodes
            Bbegin_iter = [Bbegin_iter; espikes_iter(bindex_i)]; %need to convert to iterations
            nspikestogether = thediff(burstloc)';
            Nspikesinburst = [Nspikesinburst; nspikestogether];
            bindex_f = bindex_i+(nspikestogether-1);
            
            % Check that bindex_f is correct
            checkburstend = [inburstlet(bindex_f-1)', inburstlet(bindex_f)']; %a 1 or 0
            [nota1_r,~] = find(checkburstend(:,1)~=1);
            [nota0_r,~] = find(checkburstend(:,2)~=0);
            if (~isempty(nota1_r) || ~isempty(nota0_r))
                disp('error with bindex_f')
                disp(['nota1_r = ', nota1_r])
                disp(['nota0_r = ', nota0_r])
                %fix bindex_f if need to
            end %if ~isempty
            
            Bend = [Bend; bindex_f]; %column vector, only keep track per electrode
            Bend_allE = [Bend_allE; Bend]; %column vector, keep track of all
            Bend_iter = [Bend_iter; espikes_iter(bindex_f)]; %need to convert to iterations
            Belec = [Belec; ones(size(bindex_f)).*ii]; %keep track of which electrode
            %             thewidth = SpikeTime(espikes_r(bindex_f)) - SpikeTime(espikes_r(bindex_i)); %in time
            thewidth_iter = Bend_iter - Bbegin_iter;
            thewidth_time = thewidth_iter./fs;
            burstletwidth_iter = [burstletwidth_iter; thewidth_iter]; %records all burstlet widths in iter
            burstletwidth_time = [burstletwidth_time; thewidth_time]; %records all burstlet widths in time
            
            for jj=1:length(bindex_i)
                %keep track of iters and volts and times
                Itersinburst{Nburstlets+jj} = espikes_iter(bindex_i(jj):bindex_f(jj));
                Voltsinburst{Nburstlets+jj} = espikes_volt(bindex_i(jj):bindex_f(jj));
                Timesinburst{Nburstlets+jj} = espikes_time(bindex_i(jj):bindex_f(jj));
            end %for jj
        end %if ~isempty
    end %if isempty
    Nburstlets = Nburstlets + length(Bbegin); %count total number of burstlets, could be length(Bend) too
end %for ii

% Now include anything +- 200 ms or 1/3fc of the burst
%change time and change width to update
if Nburstlets>1
    for ii=1:Nburstlets
        disp(ii);% ************************ FOR TRIAL ONLY *************************
        [spikesE_r, ~] = find(SpikeElectrode == Belec(ii));
        spikesI = SpikeIter(spikesE_r);
        spikesV = SpikeVoltage(spikesE_r);
        spikesT = SpikeTime(spikesE_r);
        
        keepsearchingbefore = 1;
        while keepsearchingbefore==1
            ISIloc_beforeburst = Bbegin_allE(ii)-1;
            if (ISIloc_beforeburst==0) %if it's the first spike in a burst, can't go backward
                keepsearchingbefore = 0;
                disp(keepsearchingbefore) % ************************ FOR TRIAL ONLY *************************
            else
                ISI_beforeburst = ISI_c(Belec(ii),ISIloc_beforeburst); %the ISI that is before the burst
                if (ISI_beforeburst<=Tc200(Belec(ii)) && (ISI_beforeburst>Tc(Belec(ii))))
                    disp('qualifies before') % ************************ FOR TRIAL ONLY *************************
                    %if it qualifies... change burst params and check more
                    Bbegin_allE(ii) = ISIloc_beforeburst; %the location within spikesI, i.e. row 26
                    Bbegin_iter(ii) = spikesI(ISIloc_beforeburst); %change the actual iteration to be the previous spike
                    burstletwidth_iter(ii) = Bend_iter(ii) - Bbegin_iter(ii); %recalculate the width
                    Nspikesinburst(ii) = length(Bbegin_allE(ii):Bend_allE(ii));
                    
                    Itersinburst{ii} = spikesI(Bbegin_allE(ii):Bend_allE(ii));
                    Voltsinburst{ii} = spikesV(Bbegin_allE(ii):Bend_allE(ii));
                    Timesinburst{ii} = spikesT(Bbegin_allE(ii):Bend_allE(ii));
                    
                else %does not qualify, break loop
                    keepsearchingbefore = 0;
                    disp(keepsearchingbefore) % ************************ FOR TRIAL ONLY *************************
                    
                end %if ISI_beforeburst
            end %if ISIloc_beforeburst
        end %while
        
        keepsearchingafter = 1;
        while keepsearchingafter==1
            ISIloc_afterburst = Bend_allE(ii);
            
            if (ISIloc_afterburst>(max(EFireArray)-1)) %if you're at the end, don't look any more
                keepsearchingafter = 0;
                disp(keepsearchingafter) % ************************ FOR TRIAL ONLY *************************
            else
                ISI_afterburst = ISI_c(Belec(ii),ISIloc_afterburst); %the ISI that is after the burst
                
                if (ISI_afterburst<=Tc200(Belec(ii)) && (ISI_afterburst>Tc(Belec(ii))))
                    disp('qualifies after') % ************************ FOR TRIAL ONLY *************************
                    %if it qualifies... change burst params and check more
                    Bend_allE(ii) = ISIloc_afterburst+1; %the location within spikesI, will be 1 after the ISI location (e.g. ISI 94 includes spikes 94 and 95)
                    Bend_iter(ii) = spikesI(ISIloc_afterburst+1); %change the actual iteration to be the previous spike
                    burstletwidth_iter(ii) = Bend_iter(ii) - Bbegin_iter(ii); %recalculate the width
                    Nspikesinburst(ii) = length(Bbegin_allE(ii):Bend_allE(ii));
                    
                    Itersinburst{ii} = spikesI(Bbegin_allE(ii):Bend_allE(ii));
                    Voltsinburst{ii} = spikesV(Bbegin_allE(ii):Bend_allE(ii));
                    Timesinburst{ii} = spikesT(Bbegin_allE(ii):Bend_allE(ii));
                    
                else %does not qualify, break loop
                    keepsearchingafter = 0;
                    disp(keepsearchingafter) % ************************ FOR TRIAL ONLY *************************
                    
                end %if ISI_aftereburst
            end %if ISIloc_afterburst
        end %while
        
    end %for ii
    
end %if Nburstlets

% It's possible that after looking for spikes w/in 200msec of the main core
% burst that now some bursts on the same electrode overlap. Check for this.
for ii=1:numChannels
    [burstE_r,~] = find(Belec==ii);
    Bbegin_iter_thisE = Bbegin_iter(burstE_r); %get where burst begins just for that electrode
    Bend_iter_thisE = Bend_iter(burstE_r); %get where burst ends just for that electrode
    Bbegin_allE_thisE = Bbegin_allE(burstE_r); %get where burst begins just for that electrode
    Bend_allE_thisE = Bend_allE(burstE_r);
    
    A = [Bbegin_iter_thisE Bend_iter_thisE];
    Eoverlap = [];
    for jj=1:size(A,1)
        Check4overlap = A(jj,1);
        % Check for if any bursts on the same electrode overlap OR one ends
        % at the same iteration that another begins
        [RoverE,~] = find(((Check4overlap>A(:,1))&(Check4overlap<A(:,2))) | (Check4overlap==A(:,2)));
        if ~isempty(RoverE)
            disp('overlapping burst!')
            disp(jj)
            for kk=1:length(RoverE)
                % Eoverlap tells you the index of the 1st row (beginning of burst) and the
                % index of the 2nd row (end of burst) where there is an overlap
                Eoverlap = [Eoverlap; jj RoverE(kk)];
            end %for kk
        end %if ~isempty
    end %for jj
    
    % If Bbegin = [11; 13] and Bend = [13; 16], then Eoverlap will return
    % the rows for 13 in Bend (row 1) and in Bbegin (row 2). Then the
    % beginning of the burst would be 11 (1st col of 1st row in Eoverlap),
    % and the end of the burst would be 16 (2nd col of 2nd row in Eoverlap).
    % ALSO, rename Bbegin_thisE, etc, first and then insert this into the
    % true Bbegin variables using burstE_r.
    for jj=1:size(Eoverlap,1)
        %Don't need to change Bbegin_thisE(Eoverlap(aa,2)), keep beginning the same
        %Need to change Bend_thisE
        Bend_iter_thisE(Eoverlap(jj,2)) = Bend_iter_thisE(Eoverlap(jj,1));
        Bend_allE_thisE(Eoverlap(jj,2)) = Bend_allE_thisE(Eoverlap(jj,1));
        
        % Instead of eliminating extraneous Bbegin_iter, etc, as you are going
        % along, put in 0s and then eliminate later. Makes it easier to keep
        % track because if there are multiple overlapping bursts, then the
        % indices will get messed up.
        Bbegin_iter_thisE(Eoverlap(jj,1)) = 0;
        Bbegin_allE_thisE(Eoverlap(jj,1)) = 0;
        Bend_iter_thisE(Eoverlap(jj,1)) = 0;
        Bend_allE_thisE(Eoverlap(jj,1)) = 0;
        
        % Recalculate these, elim the 0s later according to Bbegin_iter, etc.
        % Instead of figuring out how to access it from spikesI, just take
        % from what's already there.
        temp_Itersinburst = [Itersinburst{burstE_r(1)+Eoverlap(jj,2)-1}', Itersinburst{burstE_r(1)+Eoverlap(jj,2)}'];
        temp_Voltsinburst = [Voltsinburst{burstE_r(1)+Eoverlap(jj,2)-1}', Voltsinburst{burstE_r(1)+Eoverlap(jj,2)}'];
        temp_Timesinburst = [Timesinburst{burstE_r(1)+Eoverlap(jj,2)-1}', Timesinburst{burstE_r(1)+Eoverlap(jj,2)}'];
        
        for kk=1:length(temp_Itersinburst)
            if kk>length(temp_Itersinburst)
                break %changing size of temp_Itersinburst, so need to take that into account
            else
                [~,findsame_c] = find(temp_Itersinburst==temp_Itersinburst(kk));
                findsame_c(1) = [];
                for mm=1:length(findsame_c)
                    temp_Itersinburst(findsame_c(mm)) = [];
                    temp_Voltsinburst(findsame_c(mm)) = [];
                    temp_Timesinburst(findsame_c(mm)) = [];
                end %for mm
            end %if kk
        end %for kk
        
        Itersinburst{burstE_r(1)+Eoverlap(jj,2)-1} = temp_Itersinburst';
        Voltsinburst{burstE_r(1)+Eoverlap(jj,2)-1} = temp_Voltsinburst';
        Timesinburst{burstE_r(1)+Eoverlap(jj,2)-1} = temp_Timesinburst';
        
        Itersinburst{burstE_r(1)+Eoverlap(jj,2)} = 0;
        Voltsinburst{burstE_r(1)+Eoverlap(jj,2)} = 0;
        Timesinburst{burstE_r(1)+Eoverlap(jj,2)} = 0;
        
        Nspikesinburst(burstE_r(1)+Eoverlap(jj,2)-1) = length(Itersinburst{burstE_r(1)+Eoverlap(jj,2)-1});
    end %for jj
    
    Bbegin_iter(burstE_r) = Bbegin_iter_thisE;
    Bend_iter(burstE_r) = Bend_iter_thisE;
    Bbegin_allE(burstE_r) = Bbegin_allE_thisE;
    Bend_allE(burstE_r) = Bend_allE_thisE;
    
end %for ii

%Now eliminate any zeros
[findzeros_r, ~] = find(Bbegin_iter==0);
Nburstlets = Nburstlets - length(findzeros_r); %correct for Nburstlets

Bbegin_iter(findzeros_r) = [];
Bend_iter(findzeros_r) = [];
Bbegin_allE(findzeros_r) = [];
Bend_allE(findzeros_r) = [];
Belec(findzeros_r) = [];

Itersinburst(findzeros_r,:) = [];
Voltsinburst(findzeros_r,:) = [];
Timesinburst(findzeros_r,:) = [];
Nspikesinburst(findzeros_r) = [];

% while ~isempty(findzeros_r)
%     Bbegin_iter = Bbegin_iter([1:findzeros_r(1)-1,findzeros_r(1)+1:end]);
%     Bend_iter = Bend_iter([1:findzeros_r(1)-1,findzeros_r(1)+1:end]);
%     Bbegin_allE = Bbegin_allE([1:findzeros_r(1)-1,findzeros_r(1)+1:end]);
%     Bend_allE = Bend_allE([1:findzeros_r(1)-1,findzeros_r(1)+1:end]);
%     Belec = Belec([1:findzeros_r(1)-1,findzeros_r(1)+1:end]);
%
%     Itersinburst = Itersinburst{[1:findzeros_r(1)-1,findzeros_r(1)+1:end]};
%     Voltsinburst = Voltsinburst{[1:findzeros_r(1)-1,findzeros_r(1)+1:end]};
%     Timesinburst = Timesinburst{[1:findzeros_r(1)-1,findzeros_r(1)+1:end]};
%     Nspikesinburst = Nspikesinburst([1:findzeros_r(1)-1,findzeros_r(1)+1:end]);
%
%     [findzeros_r, ~] = find(Bbegin_iter==0);
% end %while

% Get number of burstlets per electrode and IBI per electrode
IBI_c = zeros(numChannels,length(Bbegin_iter));
for ii=1:numChannels
    [burstnum_r,~] = find(Belec==ii);
    Eburstlets(ii) = length(burstnum_r);
    if (length(burstnum_r)>1)
        Bend_iter_thisE = Bend_iter(burstnum_r); %get where burst ends just for that electrode
        IBI_c(ii,1:length(burstnum_r)-1) = (Bend_iter_thisE(2:end) - Bend_iter_thisE(1:end-1))';
    else %only 1 burst
        IBI_c(ii,:) = 0;
    end %if ~isempty
end %for ii

EBurstArray = Eburstlets';
truncatetothis = max(EBurstArray)-1;
if truncatetothis==0
    IBI_c = [];
else
    IBI_c = IBI_c(:,1:truncatetothis); %truncate so not so many 0s
end %if truncatetothis

% if any changes to burstletwidth_iter, they will all be reflected here
burstletwidth_iter = Bend_iter - Bbegin_iter;
burstletwidth_time = burstletwidth_iter./fs; %this is in sec

%convert EBurstArray to EBurstMatrix
EBurstMatrix=zeros(7,8);
for ii=1:numChannels
    EBurstMatrix(elecLocs(ii,:)) = EBurstArray(ii);
end %for ii

% Sort bursts according to iteration start time
[Border Bidx] = sort(Bbegin_iter, 1, 'ascend');
sortedBbegin_iter = Bbegin_iter(Bidx);
sortedBend_iter = Bend_iter(Bidx);
sortedBelec = Belec(Bidx);
sortedBwidth_iter = burstletwidth_iter(Bidx);
sortedBwidth_time = burstletwidth_time(Bidx);
sorted_Itersinburst = Itersinburst(Bidx);
sorted_Timesinburst = Timesinburst(Bidx);
sorted_Voltsinburst = Voltsinburst(Bidx);
sorted_Nspikesinburst = Nspikesinburst(Bidx);
sorted_Bbegin_allE = Bbegin_allE(Bidx);
sorted_Bend_allE = Bend_allE(Bidx);

% Get overall IBI
overallburstdiff1 = sortedBend_iter(1:end-1);
overallburstdiff2 = sortedBend_iter(2:end);
overallIBI = (overallburstdiff2 - overallburstdiff1)./fs; %inter-burst interval in time; FOR HISTOGRAM

% Now see if bursts from different electrodes overlap with any others
A = [sortedBbegin_iter sortedBend_iter];
TheOverlap = [];
for ii=1:size(A,1)
    Check4overlap = A(ii,1);
    [Rover,Cover] = find((Check4overlap>A(:,1))&(Check4overlap<A(:,2)));
    for jj=1:length(Rover)
        TheOverlap = [TheOverlap; ii Rover(jj)];
    end %for ii
end %for ii

% % % ANALYSIS TO DETERMINE # GLOBAL BURSTS % % %
[globalBursts_beginI, globalBursts_endI, globalBursts_Elecs, globalBursts_NumBInGB, ...
    globalBursts_width_iter, globalBursts_AvgWidth_iter, globalBursts_AvgWidth_sec, globalBursts_AvgNumBInGB, ...
    NumGlobalBursts, globalIBI_iter, globalIBI_iterAvg, globalIBI_secAvg] ...
    = detectGlobalBursts(Nburstlets, sortedBbegin_iter, sortedBend_iter, sortedBelec, fs);
% % % ANALYSIS TO DETERMINE # GLOBAL BURSTS % % %

numfire = zeros(numChannels); %changed from = zeros(65), was for plotting purposes
for ii=1:size(TheOverlap,1)
    elecA = sortedBelec(TheOverlap(ii,1));
    elecB = sortedBelec(TheOverlap(ii,2));
    numfire(elecA, elecB) = numfire(elecA, elecB) + 1;
    numfire(elecB, elecA) = numfire(elecB, elecA) + 1;
end %for ii

% Now calculate synchrony of firing
synchfire = zeros(numChannels); %changed from = zeros(65), was for plotting purposes
for ii=1:numChannels
    for jj=1:numChannels
        %calculate raw connection
        %the total # times the pair fires together divided by the MAX
        %number of times they could have fired together
        %so if they fired together 95 times, but the most one of them
        %fired was 100 times, then rawcon = 95/100
        if ( (EBurstArray(ii)==0) || (EBurstArray(jj)==0) )
            synchfire(ii,jj) = 0;
        else
            % *** THIS IS SYNCHRONY OF FIRING IN PAPER ***
            synchfire(ii,jj) = numfire(ii,jj)/max(EBurstArray(ii), EBurstArray(jj));
            % *** THIS IS SYNCHRONY OF FIRING IN PAPER ***
        end %if EBurstArray
    end %for jj
end %for ii

end %function
