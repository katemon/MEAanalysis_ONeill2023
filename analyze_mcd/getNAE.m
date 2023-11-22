function [store_NAEspike, store_NAEburst, store_NAEspike_Enum, store_NAEburst_Enum, ...
    NAEspike_Enum, NAEburst_Enum, NAEspike, NAEburst] ...
    = getNAE(p75_spike, p75_burst, EFireArray, EBurstArray, store_NAEspike, ...
    store_NAEburst, store_NAEspike_Enum, store_NAEburst_Enum)

% ********************************************************************** %
% only for first iteration 
% store_NAEspike = [];
% store_NAEburst = [];
% store_NAEspike_Enum = cell(1,1);
% store_NAEburst_Enum = cell(1,1);
% ********************************************************************** %

% get number of active electrodes (NAE) from Arrays
% do this for spiking and bursting

% need store_p75spike and store_p75burst
% OR load specific file and get p75_spike and p75_burst
% also need EFireArray and EBurstArray

[~, c_spike] = find(EFireArray>=p75_spike); %tilde because don't need rows
NAEspike_Enum = c_spike; %which ones in the array
NAEspike = length(c_spike);%the actual number of active electrodes

[~, c_burst] = find(EBurstArray>=p75_burst);
if p75_burst==0
    NAEburst_Enum = [];
    NAEburst = 0;
else
    NAEburst_Enum = c_burst;
    NAEburst = length(c_burst);
end %if p75_burst

store_NAEspike = [store_NAEspike; NAEspike];
store_NAEburst = [store_NAEburst; NAEburst];
store_NAEspike_Enum{end+1} = NAEspike_Enum;
store_NAEburst_Enum{end+1} = NAEburst_Enum;

end %function 