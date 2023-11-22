function [spiketrain] = adaptivefindspikesKMF(currentchunk, AdThresh)
%Spike counting

y = currentchunk; %the filtered chunk
%find size of y
[rowy, coly] = size(y);
%create a matrix of all zeros the same size as filtered data
spikes = zeros(rowy, coly);

% Find all data points where voltage is <-SpikeThresh and >+SpikeThresh in uV
% if true, put a 1. if not true, put a 0.
for ii=1:rowy
    for jj=1:coly
        if (y(ii,jj)<-AdThresh(ii))
            spikes(ii,jj) = 1;
        elseif (y(ii,jj)>AdThresh(ii)) %uncomment for positive spike detection
            spikes(ii,jj) = 1;         %uncomment for positive spike detection
        else
            spikes(ii,jj) = 0;
        end %if y
    end %for jj
end %for ii

% So now we have the total # of spikes for this chunk, and we know where 
% data passes the threshold, but we need the exact values (the voltages)
% This gives us the spike train.
spikevolts = zeros(rowy, coly);
for ii=1:rowy
    for jj=1:coly
        if (spikes(ii,jj)==1)
            spikevolts(ii,jj) = y(ii,jj);
        end %if spikes
    end %for jj
end %for ii

spiketrain = spikevolts; %voltages of spike trains
% numspikesout = SpikeSum; %number of spikes in chunk

% %keep all variables in workspace
%  AllMyVars = who;
%   for i = 1:length(AllMyVars)
%     assignin('base', AllMyVars{i}, eval(AllMyVars{i}));
%   end
  
end %function