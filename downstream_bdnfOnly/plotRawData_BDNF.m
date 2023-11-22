%% plotRawData_BDNF

clc; clear all; close all;

theDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF dose response\revision_0B25B50Bonly_newPlots\data\';%D:\kate_dropbox\Dropbox
figDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF dose response\revision_0B25B50Bonly_newPlots\data\figs_estStats\';%D:\kate_dropbox\Dropbox

for aa=1:3
    
    if aa==1
        load([theDir,'bdnfDataforRM_byELEC_FF100msec'],'elecData');
        
        varNames = {'spikeRateArray','burstletRateArray','avgBWidth',...
            'elecInGB','ffArray'};
        
        spkThr = 0.2; % spike thresh is 150 spikes per recording
        brstThr = 0.02; % 1 burstlet every 50 sec
        gbThr = 0.01; % global burst
        
    elseif aa==2
        load([theDir, 'bdnfSynchData_forRM.mat'],'bdnfRawSynchData');
        
        varNames = {'SF147'};
        theSubVars.cat1 = {'SF14','SF47','SF71'};
        
    elseif aa==3
        load([figDir,'bdnfNetwOrgData.mat'],'orgData');
        varNames = {'Eloc'};

        elocThr = 0.005;
        
    end %if aa
    
    % % % * * * * * * * * * * % % %
    ready2save = 0; % * * * * * * %
    % % % * * * * * * * * * * % % %
    
    scattSz = 10;
    jittAmt = 0.5;
    sz = 0.5;
    xLocs1 = [0.5 1.5 2.5 4.5 5.5 6.5 8.5 9.5 10.5];
    
    theConds = {'cond0B', 'cond25B', 'cond50B'};
    
    markerSize = 8;
    
    if aa==1
        theseVarNames = varNames;
    elseif aa==2
        theseVarNames = theSubVars.cat1;
    elseif aa==3
        theseVarNames = varNames;
    end %if aa
    for ii=1:length(theseVarNames)
        
        thisVar = theseVarNames{ii};
        
        
        if aa==1
            div07_0B = [];
            div10_0B = [];
            div17_0B = [];
            for jj=1:size(elecData.cond0B.div10,2)
                div07_0B = [div07_0B; elecData.cond0B.div07(jj).(thisVar).rawCleaned];
                div10_0B = [div10_0B; elecData.cond0B.div10(jj).(thisVar).rawCleaned];
                div17_0B = [div17_0B; elecData.cond0B.div17(jj).(thisVar).rawCleaned];
            end %for jj
            % make # global bursts into global burst rate (Hz)
            if strcmp(varNames{ii},'elecInGB')
                div07_0B = div07_0B./300;
                div10_0B = div10_0B./300;
                div17_0B = div17_0B./300;
            end %if strcmp
            div07_0B_old = div07_0B;
            if strcmp(thisVar,'spikeRateArray')
                [r07_0B,~] = find(div07_0B_old<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r07_0B,~] = find(div07_0B_old<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r07_0B,~] = find(div07_0B_old<gbThr);
            else
                [r07_0B,~] = find(div07_0B_old==0);
            end %if ii
            div07_0B(r07_0B) = [];
            div10_0B(r07_0B) = [];
            div17_0B(r07_0B) = [];
            
            div07_0B_old = div07_0B;
            div07_0B(isnan(div07_0B_old)) = [];
            div10_0B(isnan(div07_0B_old)) = [];
            div17_0B(isnan(div07_0B_old)) = [];
            div10_0B_old = div10_0B;
            div07_0B(isnan(div10_0B_old)) = [];
            div10_0B(isnan(div10_0B_old)) = [];
            div17_0B(isnan(div10_0B_old)) = [];
            div17_0B_old = div17_0B;
            div07_0B(isnan(div17_0B_old)) = [];
            div10_0B(isnan(div17_0B_old)) = [];
            div17_0B(isnan(div17_0B_old)) = [];
            
            div10_0B_other = div10_0B;
            div17_0B_other = div17_0B;
            if strcmp(thisVar,'spikeRateArray')
                [r10_0B,~] = find(div10_0B<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r10_0B,~] = find(div10_0B<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r10_0B,~] = find(div10_0B<gbThr);
            else
                [r10_0B,~] = find(div10_0B==0);
            end %if ii
            div10_0B_other(r10_0B) = [];
            div17_0B_other(r10_0B) = [];
            
            
            div07_25B = [];
            div10_25B = [];
            div17_25B = [];
            for jj=1:size(elecData.cond25B.div10,2)
                div07_25B = [div07_25B; elecData.cond25B.div07(jj).(thisVar).rawCleaned];
                div10_25B = [div10_25B; elecData.cond25B.div10(jj).(thisVar).rawCleaned];
                div17_25B = [div17_25B; elecData.cond25B.div17(jj).(thisVar).rawCleaned];
            end %for jj
            % make # global bursts into global burst rate (Hz)
            if strcmp(varNames{ii},'elecInGB')
                div07_25B = div07_25B./300;
                div10_25B = div10_25B./300;
                div17_25B = div17_25B./300;
            end %if strcmp
            div07_25B_old = div07_25B;
            if strcmp(thisVar,'spikeRateArray')
                [r07_25B,~] = find(div07_25B_old<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r07_25B,~] = find(div07_25B_old<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r07_25B,~] = find(div07_25B_old<gbThr);
            else
                [r07_25B,~] = find(div07_25B_old==0);
            end %if ii
            div07_25B(r07_25B) = [];
            div10_25B(r07_25B) = [];
            div17_25B(r07_25B) = [];
            
            div07_25B_old = div07_25B;
            div07_25B(isnan(div07_25B_old)) = [];
            div10_25B(isnan(div07_25B_old)) = [];
            div17_25B(isnan(div07_25B_old)) = [];
            div10_25B_old = div10_25B;
            div07_25B(isnan(div10_25B_old)) = [];
            div10_25B(isnan(div10_25B_old)) = [];
            div17_25B(isnan(div10_25B_old)) = [];
            div17_25B_old = div17_25B;
            div07_25B(isnan(div17_25B_old)) = [];
            div10_25B(isnan(div17_25B_old)) = [];
            div17_25B(isnan(div17_25B_old)) = [];
            
            div10_25B_other = div10_25B;
            div17_25B_other = div17_25B;
            if strcmp(thisVar,'spikeRateArray')
                [r10_25B,~] = find(div10_25B<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r10_25B,~] = find(div10_25B<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r10_25B,~] = find(div10_25B<gbThr);
            else
                [r10_25B,~] = find(div10_25B==0);
            end %if ii
            div10_25B_other(r10_25B) = [];
            div17_25B_other(r10_25B) = [];
            
            
            div07_50B = [];
            div10_50B = [];
            div17_50B = [];
            for jj=1:size(elecData.cond50B.div10,2)
                div07_50B = [div07_50B; elecData.cond50B.div07(jj).(thisVar).rawCleaned];
                div10_50B = [div10_50B; elecData.cond50B.div10(jj).(thisVar).rawCleaned];
                div17_50B = [div17_50B; elecData.cond50B.div17(jj).(thisVar).rawCleaned];
            end %for jj
            % make # global bursts into global burst rate (Hz)
            if strcmp(varNames{ii},'elecInGB')
                div07_50B = div07_50B./300;
                div10_50B = div10_50B./300;
                div17_50B = div17_50B./300;
            end %if strcmp
            div07_50B_old = div07_50B;
            if strcmp(thisVar,'spikeRateArray')
                [r07_50B,~] = find(div07_50B_old<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r07_50B,~] = find(div07_50B_old<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r07_50B,~] = find(div07_50B_old<gbThr);
            else
                [r07_50B,~] = find(div07_50B_old==0);
            end %if ii
            div07_50B(r07_50B) = [];
            div10_50B(r07_50B) = [];
            div17_50B(r07_50B) = [];
            
            div07_50B_old = div07_50B;
            div07_50B(isnan(div07_50B_old)) = [];
            div10_50B(isnan(div07_50B_old)) = [];
            div17_50B(isnan(div07_50B_old)) = [];
            div10_50B_old = div10_50B;
            div07_50B(isnan(div10_50B_old)) = [];
            div10_50B(isnan(div10_50B_old)) = [];
            div17_50B(isnan(div10_50B_old)) = [];
            div17_50B_old = div17_50B;
            div07_50B(isnan(div17_50B_old)) = [];
            div10_50B(isnan(div17_50B_old)) = [];
            div17_50B(isnan(div17_50B_old)) = [];
            
            div10_50B_other = div10_50B;
            div17_50B_other = div17_50B;
            if strcmp(thisVar,'spikeRateArray')
                [r10_50B,~] = find(div10_50B<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r10_50B,~] = find(div10_50B<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r10_50B,~] = find(div10_50B<gbThr);
            else
                [r10_50B,~] = find(div10_50B==0);
            end %if ii
            div10_50B_other(r10_50B) = [];
            div17_50B_other(r10_50B) = [];

        elseif aa==2
            
            div07_0B = bdnfRawSynchData.SF147.cond0B.div07.(thisVar).rawCleaned;
            div10_0B = bdnfRawSynchData.SF147.cond0B.div10.(thisVar).rawCleaned;
            div17_0B = bdnfRawSynchData.SF147.cond0B.div17.(thisVar).rawCleaned;
            
            div07_0B_old = div07_0B;
            div07_0B(isnan(div07_0B_old)) = [];
            div10_0B(isnan(div07_0B_old)) = [];
            div17_0B(isnan(div07_0B_old)) = [];
            div10_0B_old = div10_0B;
            div07_0B(isnan(div10_0B_old)) = [];
            div10_0B(isnan(div10_0B_old)) = [];
            div17_0B(isnan(div10_0B_old)) = [];
            div17_0B_old = div17_0B;
            div07_0B(isnan(div17_0B_old)) = [];
            div10_0B(isnan(div17_0B_old)) = [];
            div17_0B(isnan(div17_0B_old)) = [];
            
            % for div10-div17 comparison ONLY
            div10_0B_other = div10_0B;
            div17_0B_other = div17_0B;
            [r10_0B,~] = find(div10_0B==0);
            div10_0B_other(r10_0B) = [];
            div17_0B_other(r10_0B) = [];
            
            
            div07_25B = bdnfRawSynchData.SF147.cond25B.div07.(thisVar).rawCleaned;
            div10_25B = bdnfRawSynchData.SF147.cond25B.div10.(thisVar).rawCleaned;
            div17_25B = bdnfRawSynchData.SF147.cond25B.div17.(thisVar).rawCleaned;
            
            div07_25B_old = div07_25B;
            div07_25B(isnan(div07_25B_old)) = [];
            div10_25B(isnan(div07_25B_old)) = [];
            div17_25B(isnan(div07_25B_old)) = [];
            div10_25B_old = div10_25B;
            div07_25B(isnan(div10_25B_old)) = [];
            div10_25B(isnan(div10_25B_old)) = [];
            div17_25B(isnan(div10_25B_old)) = [];
            div17_25B_old = div17_25B;
            div07_25B(isnan(div17_25B_old)) = [];
            div10_25B(isnan(div17_25B_old)) = [];
            div17_25B(isnan(div17_25B_old)) = [];
            
            % for div10-div17 comparison ONLY
            div10_25B_other = div10_25B;
            div17_25B_other = div17_25B;
            [r10_25B,~] = find(div10_25B==0);
            div10_25B_other(r10_25B) = [];
            div17_25B_other(r10_25B) = [];
            
            
            div07_50B = bdnfRawSynchData.SF147.cond50B.div07.(thisVar).rawCleaned;
            div10_50B = bdnfRawSynchData.SF147.cond50B.div10.(thisVar).rawCleaned;
            div17_50B = bdnfRawSynchData.SF147.cond50B.div17.(thisVar).rawCleaned;
            
            div07_50B_old = div07_50B;
            div07_50B(isnan(div07_50B_old)) = [];
            div10_50B(isnan(div07_50B_old)) = [];
            div17_50B(isnan(div07_50B_old)) = [];
            div10_50B_old = div10_50B;
            div07_50B(isnan(div10_50B_old)) = [];
            div10_50B(isnan(div10_50B_old)) = [];
            div17_50B(isnan(div10_50B_old)) = [];
            div17_50B_old = div17_50B;
            div07_50B(isnan(div17_50B_old)) = [];
            div10_50B(isnan(div17_50B_old)) = [];
            div17_50B(isnan(div17_50B_old)) = [];
            
            % for div10-div17 comparison ONLY
            div10_50B_other = div10_50B;
            div17_50B_other = div17_50B;
            [r10_50B,~] = find(div10_50B==0);
            div10_50B_other(r10_50B) = [];
            div17_50B_other(r10_50B) = [];
            
            
        elseif aa==3
            
            data1a = [];
            data2a = [];
            data3a = [];
            for jj=1:length(orgData.(thisVar).div07)
                if ~isempty(orgData.(thisVar).div07(jj).cond0B)
                    data1a = [data1a; orgData.(thisVar).div07(jj).cond0B];
                    data2a = [data2a; orgData.(thisVar).div10(jj).cond0B];
                    data3a = [data3a; orgData.(thisVar).div17(jj).cond0B];
                end %if ~isempty
            end %for ii
            div07_0B = data1a;
            div10_0B = data2a;
            div17_0B = data3a;
            
            div07_0B_old = div07_0B;
            [r07_0B,~] = find(div07_0B_old<elocThr);%find(div07_0B_old==0);
            div07_0B(r07_0B) = [];
            div10_0B(r07_0B) = [];
            div17_0B(r07_0B) = [];
            
            div07_0B_old = div07_0B;
            div07_0B(isnan(div07_0B_old)) = [];
            div10_0B(isnan(div07_0B_old)) = [];
            div17_0B(isnan(div07_0B_old)) = [];
            div10_0B_old = div10_0B;
            div07_0B(isnan(div10_0B_old)) = [];
            div10_0B(isnan(div10_0B_old)) = [];
            div17_0B(isnan(div10_0B_old)) = [];
            div17_0B_old = div17_0B;
            div07_0B(isnan(div17_0B_old)) = [];
            div10_0B(isnan(div17_0B_old)) = [];
            div17_0B(isnan(div17_0B_old)) = [];
            
            % for div10-div17 comparison ONLY for Eloc
            div10_0B_other = div10_0B;
            div17_0B_other = div17_0B;
            [r10_0B,~] = find(div10_0B<=elocThr);%find(div10_0B==0);
            div10_0B_other(r10_0B) = [];
            div17_0B_other(r10_0B) = [];
            
            
            data1b = [];
            data2b = [];
            data3b = [];
            for jj=1:length(orgData.(thisVar).div07)
                if ~isempty(orgData.(thisVar).div07(jj).cond25B)
                    data1b = [data1b; orgData.(thisVar).div07(jj).cond25B];
                    data2b = [data2b; orgData.(thisVar).div10(jj).cond25B];
                    data3b = [data3b; orgData.(thisVar).div17(jj).cond25B];
                end %if ~isempty
            end %for ii
            div07_25B = data1b;
            div10_25B = data2b;
            div17_25B = data3b;
            
            div07_25B_old = div07_25B;
            [r07_25B,~] = find(div07_25B_old<=elocThr);%find(div07_25B_old==0);
            div07_25B(r07_25B) = [];
            div10_25B(r07_25B) = [];
            div17_25B(r07_25B) = [];
            
            div07_25B_old = div07_25B;
            div07_25B(isnan(div07_25B_old)) = [];
            div10_25B(isnan(div07_25B_old)) = [];
            div17_25B(isnan(div07_25B_old)) = [];
            div10_25B_old = div10_25B;
            div07_25B(isnan(div10_25B_old)) = [];
            div10_25B(isnan(div10_25B_old)) = [];
            div17_25B(isnan(div10_25B_old)) = [];
            div17_25B_old = div17_25B;
            div07_25B(isnan(div17_25B_old)) = [];
            div10_25B(isnan(div17_25B_old)) = [];
            div17_25B(isnan(div17_25B_old)) = [];
            
            % for div10-div17 comparison ONLY for Eloc
            div10_25B_other = div10_25B;
            div17_25B_other = div17_25B;
            [r10_25B,~] = find(div10_25B<=elocThr);%find(div10_25B==0);
            div10_25B_other(r10_25B) = [];
            div17_25B_other(r10_25B) = [];
            
            
            data1c = [];
            data2c = [];
            data3c = [];
            for jj=1:length(orgData.(thisVar).div07)
                if ~isempty(orgData.(thisVar).div07(jj).cond50B)
                    data1c = [data1c; orgData.(thisVar).div07(jj).cond50B];
                    data2c = [data2c; orgData.(thisVar).div10(jj).cond50B];
                    data3c = [data3c; orgData.(thisVar).div17(jj).cond50B];
                end %if ~isempty
            end %for ii
            div07_50B = data1c;
            div10_50B = data2c;
            div17_50B = data3c;
            
            div07_50B_old = div07_50B;
            [r07_50B,~] = find(div07_50B_old<=elocThr);%find(div07_50B_old==0);
            div07_50B(r07_50B) = [];
            div10_50B(r07_50B) = [];
            div17_50B(r07_50B) = [];

            div07_50B_old = div07_50B;
            div07_50B(isnan(div07_50B_old)) = [];
            div10_50B(isnan(div07_50B_old)) = [];
            div17_50B(isnan(div07_50B_old)) = [];
            div10_50B_old = div10_50B;
            div07_50B(isnan(div10_50B_old)) = [];
            div10_50B(isnan(div10_50B_old)) = [];
            div17_50B(isnan(div10_50B_old)) = [];
            div17_50B_old = div17_50B;
            div07_50B(isnan(div17_50B_old)) = [];
            div10_50B(isnan(div17_50B_old)) = [];
            div17_50B(isnan(div17_50B_old)) = [];
            
            % for div10-div17 comparison ONLY for Eloc
            div10_50B_other = div10_50B;
            div17_50B_other = div17_50B;
            [r10_50B,~] = find(div10_50B<=elocThr);%find(div10_50B==0);
            div10_50B_other(r10_50B) = [];
            div17_50B_other(r10_50B) = [];

        end %if aa
        
        fig1 = figure('Position', [1,41,1280,607.33]);
        xlim([0 xLocs1(end)+1]); hold on;
        
        xJitt = jittAmt*rand(length(div07_0B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(1),div07_0B,scattSz,'o','markeredgecolor','k','markerfacecolor','w');
        xJitt = jittAmt*rand(length(div10_0B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(2),div10_0B,scattSz,'o','markeredgecolor','k','markerfacecolor',[0.4 0.4 0.4]);
        xJitt = jittAmt*rand(length(div17_0B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(3),div17_0B,scattSz,'o','markeredgecolor','k','markerfacecolor','k');
        
        xJitt = jittAmt*rand(length(div07_25B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(4),div07_25B,scattSz,'o','markeredgecolor','r','markerfacecolor','w');
        xJitt = jittAmt*rand(length(div10_25B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(5),div10_25B,scattSz,'o','markeredgecolor','r','markerfacecolor',[1 0.4 0.4]);
        xJitt = jittAmt*rand(length(div17_25B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(6),div17_25B,scattSz,'o','markeredgecolor','r','markerfacecolor','r');
        
        xJitt = jittAmt*rand(length(div07_50B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(7),div07_50B,scattSz,'o','markeredgecolor','b','markerfacecolor','w');
        xJitt = jittAmt*rand(length(div10_50B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(8),div10_50B,scattSz,'o','markeredgecolor','b','markerfacecolor',[0.4 0.4 1]);
        xJitt = jittAmt*rand(length(div17_50B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(9),div17_50B,scattSz,'o','markeredgecolor','b','markerfacecolor','b');

        plot([xLocs1(1)-sz/2, xLocs1(1)+sz/2], [mean(div07_0B) mean(div07_0B)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(2)-sz/2, xLocs1(2)+sz/2], [mean(div10_0B) mean(div10_0B)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(3)-sz/2, xLocs1(3)+sz/2], [mean(div17_0B) mean(div17_0B)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(4)-sz/2, xLocs1(4)+sz/2], [mean(div07_25B) mean(div07_25B)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(5)-sz/2, xLocs1(5)+sz/2], [mean(div10_25B) mean(div10_25B)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(6)-sz/2, xLocs1(6)+sz/2], [mean(div17_25B) mean(div17_25B)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(7)-sz/2, xLocs1(7)+sz/2], [mean(div07_50B) mean(div07_50B)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(8)-sz/2, xLocs1(8)+sz/2], [mean(div10_50B) mean(div10_50B)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(9)-sz/2, xLocs1(9)+sz/2], [mean(div17_50B) mean(div17_50B)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        
        set(gca,'box','off','tickdir','out');
        xticks(xLocs1);
        xticklabels({'','','','','','','','',''});
        
        disp('');
        disp(thisVar);
        disp('');
        disp(['N for div07_0B = ',num2str(length(div07_0B))]);
        disp(['N for div10_0B = ',num2str(length(div10_0B))]);
        disp(['N for div17_0B = ',num2str(length(div17_0B))]);
        disp('');
        disp(['N for div07_25B = ',num2str(length(div07_25B))]);
        disp(['N for div10_25B = ',num2str(length(div10_25B))]);
        disp(['N for div17_25B = ',num2str(length(div17_25B))]);
        disp('');
        disp(['N for div07_50B = ',num2str(length(div07_50B))]);
        disp(['N for div10_50B = ',num2str(length(div10_50B))]);
        disp(['N for div17_50B = ',num2str(length(div17_50B))]);
        disp('');
        
        if ready2save
            saveas(fig1,[figDir,thisVar,'_rawMean.png']);
            saveas(fig1,[figDir,thisVar,'_rawMean.fig']);
            saveas(fig1,[figDir,thisVar,'_rawMean.svg']);
        end %if ready2save
        
        close(fig1);
        
    end %for ii
    
end %for aa



