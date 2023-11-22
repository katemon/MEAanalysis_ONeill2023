function [deadspikes, new_spikeiter, new_spikeelec, new_spikevolts, new_patchVrange, new_patchIrange] = ...
    deadtime_wc(spikeiter, spikeelec, spikevolts, patchVrange, patchIrange,numChannels)

% deadtime_msec = 2.0; %in msec, 2 msec matches the approx. 40 iterations after the spike time
deadtime_iter = 40;
% fs_msec = 20; %sampling frequency of 20 kHz is 20k samples/sec = 20 samples/msec

deadspikes = 0;
new_spikeiter = spikeiter;
new_spikeelec = spikeelec;
new_spikevolts = spikevolts;
new_patchVrange = patchVrange;
new_patchIrange = patchIrange;
for ii=1:numChannels
    %get current electrode iters and volts
    [spikeE_r,~] = find(new_spikeelec==ii);
    spikeI_thisE = new_spikeiter(spikeE_r);
    spikeV_thisE = new_spikevolts(spikeE_r);
    
    spikeiter_diff = spikeI_thisE(2:end) - spikeI_thisE(1:end-1);
    RtoElim = [];
    for jj=1:length(spikeiter_diff)
        if (spikeiter_diff(jj)<deadtime_iter)
            therow1 = jj;
            therow2 = jj+1;
            % want to keep the spike with the largest absolute voltage.
            % throw out the other one.
            getthemin = [abs(spikeV_thisE(therow1)), abs(spikeV_thisE(therow2))];
            [~,therow] = min(getthemin);
            toelim = jj+therow-1; %if first element, then it's jj.
            RtoElim = [RtoElim; toelim];
        end %if spiketime_diff
    end %for jj
    
    if isempty(RtoElim)
        deadspikes = deadspikes + 0;
    else
        deadspikes = deadspikes + length(RtoElim);
        new_spikeiter(spikeE_r(RtoElim)) = [];
        new_spikeelec(spikeE_r(RtoElim)) = [];
        new_spikevolts(spikeE_r(RtoElim)) = [];
        new_patchVrange(spikeE_r(RtoElim),:) = [];
        new_patchIrange(spikeE_r(RtoElim),:) = [];
    end %if isempty()
    
end %for ii

end %function