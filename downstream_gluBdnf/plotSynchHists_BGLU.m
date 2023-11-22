%%
clc; clear all; close all;
load('bgluSynchData_forRM.mat', 'bgluRawSynchData');

%%
cond0g_0b_div14 = [bgluRawSynchData.SF147.cond0g_0b.div14.SF14.rawCleaned;
bgluRawSynchData.SF147.cond0g_0b.div14.SF47.rawCleaned;
bgluRawSynchData.SF147.cond0g_0b.div14.SF71.rawCleaned];
cond0g_0b_div15 = [bgluRawSynchData.SF147.cond0g_0b.div15.SF14.rawCleaned;
bgluRawSynchData.SF147.cond0g_0b.div15.SF47.rawCleaned;
bgluRawSynchData.SF147.cond0g_0b.div15.SF71.rawCleaned];
cond0g_0b_div17 = [bgluRawSynchData.SF147.cond0g_0b.div17.SF14.rawCleaned;
bgluRawSynchData.SF147.cond0g_0b.div17.SF47.rawCleaned;
bgluRawSynchData.SF147.cond0g_0b.div17.SF71.rawCleaned];

cond0g_50b_div14 = [bgluRawSynchData.SF147.cond0g_50b.div14.SF14.rawCleaned;
bgluRawSynchData.SF147.cond0g_50b.div14.SF47.rawCleaned;
bgluRawSynchData.SF147.cond0g_50b.div14.SF71.rawCleaned];
cond0g_50b_div15 = [bgluRawSynchData.SF147.cond0g_50b.div15.SF14.rawCleaned;
bgluRawSynchData.SF147.cond0g_50b.div15.SF47.rawCleaned;
bgluRawSynchData.SF147.cond0g_50b.div15.SF71.rawCleaned];
cond0g_50b_div17 = [bgluRawSynchData.SF147.cond0g_50b.div17.SF14.rawCleaned;
bgluRawSynchData.SF147.cond0g_50b.div17.SF47.rawCleaned;
bgluRawSynchData.SF147.cond0g_50b.div17.SF71.rawCleaned];

cond30g_0b_div14 = [bgluRawSynchData.SF147.cond30g_0b.div14.SF14.rawCleaned;
bgluRawSynchData.SF147.cond30g_0b.div14.SF47.rawCleaned;
bgluRawSynchData.SF147.cond30g_0b.div14.SF71.rawCleaned];
cond30g_0b_div15 = [bgluRawSynchData.SF147.cond30g_0b.div15.SF14.rawCleaned;
bgluRawSynchData.SF147.cond30g_0b.div15.SF47.rawCleaned;
bgluRawSynchData.SF147.cond30g_0b.div15.SF71.rawCleaned];
cond30g_0b_div17 = [bgluRawSynchData.SF147.cond30g_0b.div17.SF14.rawCleaned;
bgluRawSynchData.SF147.cond30g_0b.div17.SF47.rawCleaned;
bgluRawSynchData.SF147.cond30g_0b.div17.SF71.rawCleaned];

cond30g_50b_div14 = [bgluRawSynchData.SF147.cond30g_50b.div14.SF14.rawCleaned;
bgluRawSynchData.SF147.cond30g_50b.div14.SF47.rawCleaned;
bgluRawSynchData.SF147.cond30g_50b.div14.SF71.rawCleaned];
cond30g_50b_div15 = [bgluRawSynchData.SF147.cond30g_50b.div15.SF14.rawCleaned;
bgluRawSynchData.SF147.cond30g_50b.div15.SF47.rawCleaned;
bgluRawSynchData.SF147.cond30g_50b.div15.SF71.rawCleaned];
cond30g_50b_div17 = [bgluRawSynchData.SF147.cond30g_50b.div17.SF14.rawCleaned;
bgluRawSynchData.SF147.cond30g_50b.div17.SF47.rawCleaned;
bgluRawSynchData.SF147.cond30g_50b.div17.SF71.rawCleaned];

%%
edges = [0:0.1:1.0];
figure; subplot(1,4,1); 
histogram(cond0g_0b_div14, edges,'normalization','probability'); hold on;
histogram(cond0g_0b_div15, edges,'normalization','probability');
histogram(cond0g_0b_div17, edges,'normalization','probability'); ylim([0 1]);
title('0g 0b'); set(gca,'fontsize',12,'fontweight','bold','tickdir','out','box','off');
xticks([0:0.1:1.0]); xticklabels({'0','','0.2','','0.4','','0.6','','0.8','','1.0'});
subplot(1,4,2);
histogram(cond0g_50b_div14, edges,'normalization','probability'); hold on;
histogram(cond0g_50b_div15, edges,'normalization','probability');
histogram(cond0g_50b_div17, edges,'normalization','probability'); ylim([0 1]);
title('0g 50b'); set(gca,'fontsize',12,'fontweight','bold','tickdir','out','box','off');
xticks([0:0.1:1.0]); xticklabels({'0','','0.2','','0.4','','0.6','','0.8','','1.0'});
subplot(1,4,3);
histogram(cond30g_0b_div14, edges,'normalization','probability'); hold on;
histogram(cond30g_0b_div15, edges,'normalization','probability');
histogram(cond30g_0b_div17, edges,'normalization','probability'); ylim([0 1]);
title('30g 0b'); set(gca,'fontsize',12,'fontweight','bold','tickdir','out','box','off');
xticks([0:0.1:1.0]); xticklabels({'0','','0.2','','0.4','','0.6','','0.8','','1.0'});
subplot(1,4,4);
histogram(cond30g_50b_div14, edges,'normalization','probability'); hold on;
histogram(cond30g_50b_div15, edges,'normalization','probability');
histogram(cond30g_50b_div17, edges,'normalization','probability'); ylim([0 1]);
title('30g 50b'); set(gca,'fontsize',12,'fontweight','bold','tickdir','out','box','off');
xticks([0:0.1:1.0]); xticklabels({'0','','0.2','','0.4','','0.6','','0.8','','1.0'});
