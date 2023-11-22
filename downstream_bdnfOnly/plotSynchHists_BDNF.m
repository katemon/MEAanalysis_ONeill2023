%%
clc; clear all; close all;
load('bdnfSynchData_forRM.mat', 'bdnfRawSynchData')

%%
cond0B_div07 = [bdnfRawSynchData.SF147.cond0B.div07.SF14.rawCleaned;
bdnfRawSynchData.SF147.cond0B.div07.SF47.rawCleaned;
bdnfRawSynchData.SF147.cond0B.div07.SF71.rawCleaned];
cond0B_div10 = [bdnfRawSynchData.SF147.cond0B.div10.SF14.rawCleaned;
bdnfRawSynchData.SF147.cond0B.div10.SF47.rawCleaned;
bdnfRawSynchData.SF147.cond0B.div10.SF71.rawCleaned];
cond0B_div17 = [bdnfRawSynchData.SF147.cond0B.div17.SF14.rawCleaned;
bdnfRawSynchData.SF147.cond0B.div17.SF47.rawCleaned;
bdnfRawSynchData.SF147.cond0B.div17.SF71.rawCleaned];

cond25B_div07 = [bdnfRawSynchData.SF147.cond25B.div07.SF14.rawCleaned;
bdnfRawSynchData.SF147.cond25B.div07.SF47.rawCleaned;
bdnfRawSynchData.SF147.cond25B.div07.SF71.rawCleaned];
cond25B_div10 = [bdnfRawSynchData.SF147.cond25B.div10.SF14.rawCleaned;
bdnfRawSynchData.SF147.cond25B.div10.SF47.rawCleaned;
bdnfRawSynchData.SF147.cond25B.div10.SF71.rawCleaned];
cond25B_div17 = [bdnfRawSynchData.SF147.cond25B.div17.SF14.rawCleaned;
bdnfRawSynchData.SF147.cond25B.div17.SF47.rawCleaned;
bdnfRawSynchData.SF147.cond25B.div17.SF71.rawCleaned];

cond50B_div07 = [bdnfRawSynchData.SF147.cond50B.div07.SF14.rawCleaned;
bdnfRawSynchData.SF147.cond50B.div07.SF47.rawCleaned;
bdnfRawSynchData.SF147.cond50B.div07.SF71.rawCleaned];
cond50B_div10 = [bdnfRawSynchData.SF147.cond50B.div10.SF14.rawCleaned;
bdnfRawSynchData.SF147.cond50B.div10.SF47.rawCleaned;
bdnfRawSynchData.SF147.cond50B.div10.SF71.rawCleaned];
cond50B_div17 = [bdnfRawSynchData.SF147.cond50B.div17.SF14.rawCleaned;
bdnfRawSynchData.SF147.cond50B.div17.SF47.rawCleaned;
bdnfRawSynchData.SF147.cond50B.div17.SF71.rawCleaned];

%%
edges = [0:0.1:1.0];
figure; subplot(1,3,1); 
histogram(cond0B_div07, edges,'normalization','probability'); hold on;
histogram(cond0B_div10, edges,'normalization','probability');
histogram(cond0B_div17, edges,'normalization','probability'); ylim([0 1]);
title('0B'); set(gca,'fontsize',12,'fontweight','bold','tickdir','out','box','off');
xticks([0:0.1:1.0]); xticklabels({'0','','0.2','','0.4','','0.6','','0.8','','1.0'});
subplot(1,3,2);
histogram(cond25B_div07, edges,'normalization','probability'); hold on;
histogram(cond25B_div10, edges,'normalization','probability');
histogram(cond25B_div17, edges,'normalization','probability'); ylim([0 1]);
title('25B'); set(gca,'fontsize',12,'fontweight','bold','tickdir','out','box','off');
xticks([0:0.1:1.0]); xticklabels({'0','','0.2','','0.4','','0.6','','0.8','','1.0'});
subplot(1,3,3);
histogram(cond50B_div07, edges,'normalization','probability'); hold on;
histogram(cond50B_div10, edges,'normalization','probability');
histogram(cond50B_div17, edges,'normalization','probability'); ylim([0 1]);
title('50B'); set(gca,'fontsize',12,'fontweight','bold','tickdir','out','box','off');
xticks([0:0.1:1.0]); xticklabels({'0','','0.2','','0.4','','0.6','','0.8','','1.0'});