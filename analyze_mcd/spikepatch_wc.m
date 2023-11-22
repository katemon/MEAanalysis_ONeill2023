function [spikevolts, spikeiters, spikeelecs] = spikepatch_wc(spikevolts)

y = spikevolts; % the voltages surrounding a spike. need to find max/min.

[rowy,coly] = size(y);

spikemax = zeros(size(y));

spikevolts = [];
spikeiters = [];
spikeelecs = [];

for ii=1:rowy
    spikeR = ii;
    [~, spikeC] = find(y(ii,:)~=0);
    spikesub = spikeC(2:end)-spikeC(1:end-1);
    %     spikesub = [spikesub, 0]; %put 0 at end so you know it's the end
    %     [~, spikeOnes] = find(spikesub==1);
    thisspike = [];
    thisloc = [];
    
    for jj=1:length(spikesub)
        
        if (spikesub(jj)==1)
            thisspike = [thisspike, y(spikeR, spikeC(jj))];
            thisloc = [thisloc, spikeC(jj)];
            
            if (jj==length(spikesub))
                thisspike = [thisspike, y(spikeR, spikeC(jj+1))]; %need to get the last one because length(spikesub) is 1 less than lenth(spikeC)
                thisloc = [thisloc, spikeC(jj+1)];
                [~, Cformax] = max(abs(thisspike));
                %                 spikeCol = spikeC(jj)-length(thisspike)+Cformax;
                spikemax(spikeR, thisloc(Cformax)) = thisspike(Cformax);
                spikevolts = [spikevolts; thisspike(Cformax)];
                spikeiters = [spikeiters; thisloc(Cformax)];
                spikeelecs = [spikeelecs; ii];
                thisspike = [];
                thisloc = [];
                
            else
                if (spikesub(jj+1)==1)
                    %then just advance
                elseif (spikesub(jj+1)~=1)
                    %then it's the end of that spike train, get last one
                    thisspike = [thisspike, y(spikeR, spikeC(jj+1))];
                    thisloc = [thisloc, spikeC(jj+1)];
                    [~, Cformax] = max(abs(thisspike));
                    %                     spikeCol = spikeC(jj+1)-length(thisspike)+Cformax;
                    spikemax(spikeR, thisloc(Cformax)) = thisspike(Cformax);
                    spikevolts = [spikevolts; thisspike(Cformax)];
                    spikeiters = [spikeiters; thisloc(Cformax)];
                    spikeelecs = [spikeelecs; ii];
                    thisspike = [];
                    thisloc = [];
                end %if spikesub
                
            end %if jj
            
        end %if spikesub
        
    end %for jj
    
end %for ii

% %keep all variables in workspace
%  AllMyVars = who;
%   for i = 1:length(AllMyVars)
%     assignin('base', AllMyVars{i}, eval(AllMyVars{i}));
%   end

end %function