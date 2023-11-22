%% Plot histogram for spiking and bursting and get 75th percentile of each



function [p75_spike, p75_burst, count_spike, vals_spike, freq_spike, ...
    count_burst, vals_burst, freq_burst, SpikesPerE, std_Spikes, SpikesPerE_1std, ...
    SpikesPerE_2std, BurstsPerE, std_Bursts, BurstsPerE_1std, BurstsPerE_2std] ...
    = get75th(EFireArray, EBurstArray, EFireMatrix, EBurstMatrix, ...
    TotalSpikesNum, NumBurstlets, numChannels)

% calculate # spikes and bursts per electrode from the matrices

SpikesPerE = [mean(mean(EFireMatrix(1:size(EFireMatrix,1),1:size(EFireMatrix,2)),1),2), TotalSpikesNum/numChannels];
std_Spikes = std(std(EFireMatrix(1:size(EFireMatrix,1),1:size(EFireMatrix,2)),0,1),0,2);
SpikesPerE_1std = [(SpikesPerE(:) + std_Spikes)'; (SpikesPerE(:) - std_Spikes)'];
SpikesPerE_2std = [(SpikesPerE(:) + 2*std_Spikes)'; (SpikesPerE(:) - 2*std_Spikes)'];
BurstsPerE = [mean(mean(EBurstMatrix(1:size(EBurstMatrix,1),1:size(EBurstMatrix,2)),1),2), NumBurstlets/numChannels];
std_Bursts = std(std(EBurstMatrix(1:size(EBurstMatrix,1),1:size(EBurstMatrix,2)),0,1),0,2);
BurstsPerE_1std = [(BurstsPerE(:) + std_Bursts)'; (BurstsPerE(:) - std_Bursts)'];
BurstsPerE_2std = [(BurstsPerE(:) + 2*std_Bursts)'; (BurstsPerE(:) - 2*std_Bursts)'];

% plot this

figure;

subplot(1,2,1);
bar(SpikesPerE(2:3)); hold on;
errorbar([1:2],SpikesPerE(2:3),std_Spikes*[1,1],'k.','LineStyle','none');
set(gca,'XTickLabel',{num2str(SpikesPerE(2)), num2str(SpikesPerE(3))});
title(['avg spikes per E, std=', num2str(std_Spikes)])

subplot(1,2,2);
bar(BurstsPerE(2:3)); hold on;
errorbar([1:2],BurstsPerE(2:3),std_Bursts*[1,1],'k.','LineStyle','none');
set(gca,'XTickLabel',{num2str(BurstsPerE(2)), num2str(BurstsPerE(3))});
title(['avg bursts per E, std=', num2str(std_Bursts)])

% remove 0s from arrays and sort

EFireArray2 = EFireArray;
EBurstArray2 = EBurstArray;

EFireArray2(EFireArray2==0)=[];
EBurstArray2(EBurstArray2==0)=[];

EFireArray3 = sort(EFireArray2);
EBurstArray3 = sort(EBurstArray2);


% plot using histogram

figure;

subplot(2,1,1);
n_spike = 250;
if TotalSpikesNum~=0
    % h1 = hist(EFireArray3,500);
    [count_spike, vals_spike] = hist(EFireArray3,n_spike);
    freq_spike = count_spike/n_spike;
    % plot(h1);
    bar(vals_spike,count_spike);
    p75_spike = EFireArray3(round(0.75*length(EFireArray3)));
    title(['spiking histogram, p75 = ', num2str(p75_spike)]);
else
    p75_spike = 0;
    count_spike = 0;
    vals_spike = 0;
    freq_spike = 0;
end %if TotalSpikesNum

subplot(2,1,2); title('bursting histogram');
n_burst = 125;
if NumBurstlets~=0
    % h2 = hist(EBurstArray3,250);
    [count_burst, vals_burst] = hist(EBurstArray3,n_burst);
    freq_burst = count_burst/n_burst;
    % plot(h2);
    bar(vals_burst,count_burst);
    p75_burst = EBurstArray3(round(0.75*length(EBurstArray3)));
    title(['bursting histogram, p75 = ', num2str(p75_burst)]);
else
    p75_burst = 0;
    count_burst = 0;
    vals_burst = 0;
    freq_burst = 0;
end %if NumBurstlets

end %function