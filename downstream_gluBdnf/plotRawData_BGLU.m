%% plotRawData_BGLU

clc; clear all; close all;

theDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF GLU injury recovery\revision_0g30gonly_newPlots\data\';%D:\kate_dropbox\Dropbox
figDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF GLU injury recovery\revision_0g30gonly_newPlots\data\figs_estStats\';%D:\kate_dropbox\Dropbox

for aa=1:3
    
    if aa==1
        load([theDir,'bgluDataforRM_byELEC_FF100msec'],'elecData');
        
        varNames = {'spikeRateArray','burstletRateArray','avgBWidth',...
            'elecInGB','ffArray'};
        
        spkThr = 0.2; % spike thresh is 150 spikes per recording
        brstThr = 0.02; % 1 burstlet every 50 sec
        gbThr = 0.01; % global burst
        
    elseif aa==2
        load([theDir, 'bgluSynchData_forRM.mat'],'bgluRawSynchData');
        
        varNames = {'SF147'};
        theSubVars.cat1 = {'SF14','SF47','SF71'};
        
    elseif aa==3
        load([figDir,'bgluNetwOrgData.mat'],'orgData');
        varNames = {'Eloc'};
        
        elocThr = 0.005;
        
    end %if aa
    
    % % % * * * * * * * * * * % % %
    ready2save = 0; % * * * * * * %
    % % % * * * * * * * * * * % % %
    
    scattSz = 10;
    jittAmt = 0.5;
    sz = 0.5;
    xLocs1 = [0.5 1.5 2.5 4.5 5.5 6.5 8.5 9.5 10.5 12.5 13.5 14.5];
    
    theConds = {'cond0g_0b', 'cond0g_50b', 'cond30g_0b', 'cond30g_50b'};
    
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
            div14_0g_0b = [];
            div15_0g_0b = [];
            div17_0g_0b = [];
            for jj=1:size(elecData.cond0g_0b.div15,2)
                div14_0g_0b = [div14_0g_0b; elecData.cond0g_0b.div14(jj).(thisVar).rawCleaned];
                div15_0g_0b = [div15_0g_0b; elecData.cond0g_0b.div15(jj).(thisVar).rawCleaned];
                div17_0g_0b = [div17_0g_0b; elecData.cond0g_0b.div17(jj).(thisVar).rawCleaned];
            end %for jj
            % make # global bursts into global burst rate (Hz)
            if strcmp(varNames{ii},'elecInGB')
                div14_0g_0b = div14_0g_0b./300;
                div15_0g_0b = div15_0g_0b./300;
                div17_0g_0b = div17_0g_0b./300;
            end %if strcmp
            div14_0g_0b_old = div14_0g_0b;
            if strcmp(thisVar,'spikeRateArray')
                [r14_0g_0b,~] = find(div14_0g_0b_old<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r14_0g_0b,~] = find(div14_0g_0b_old<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r14_0g_0b,~] = find(div14_0g_0b_old<gbThr);
            else
                [r14_0g_0b,~] = find(div14_0g_0b_old==0);
            end %if ii
            div14_0g_0b(r14_0g_0b) = [];
            div15_0g_0b(r14_0g_0b) = [];
            div17_0g_0b(r14_0g_0b) = [];
            
            div14_0g_0b_old = div14_0g_0b;
            div14_0g_0b(isnan(div14_0g_0b_old)) = [];
            div15_0g_0b(isnan(div14_0g_0b_old)) = [];
            div17_0g_0b(isnan(div14_0g_0b_old)) = [];
            div15_0g_0b_old = div15_0g_0b;
            div14_0g_0b(isnan(div15_0g_0b_old)) = [];
            div15_0g_0b(isnan(div15_0g_0b_old)) = [];
            div17_0g_0b(isnan(div15_0g_0b_old)) = [];
            div17_0g_0b_old = div17_0g_0b;
            div14_0g_0b(isnan(div17_0g_0b_old)) = [];
            div15_0g_0b(isnan(div17_0g_0b_old)) = [];
            div17_0g_0b(isnan(div17_0g_0b_old)) = [];
            
            div15_0g_0b_other = div15_0g_0b;
            div17_0g_0b_other = div17_0g_0b;
            if strcmp(thisVar,'spikeRateArray')
                [r15_0g_0b,~] = find(div15_0g_0b<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r15_0g_0b,~] = find(div15_0g_0b<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r15_0g_0b,~] = find(div15_0g_0b<gbThr);
            else
                [r15_0g_0b,~] = find(div15_0g_0b==0);
            end %if ii
            div15_0g_0b_other(r15_0g_0b) = [];
            div17_0g_0b_other(r15_0g_0b) = [];
            
            
            div14_0g_50b = [];
            div15_0g_50b = [];
            div17_0g_50b = [];
            for jj=1:size(elecData.cond0g_50b.div15,2)
                div14_0g_50b = [div14_0g_50b; elecData.cond0g_50b.div14(jj).(thisVar).rawCleaned];
                div15_0g_50b = [div15_0g_50b; elecData.cond0g_50b.div15(jj).(thisVar).rawCleaned];
                div17_0g_50b = [div17_0g_50b; elecData.cond0g_50b.div17(jj).(thisVar).rawCleaned];
            end %for jj
            % make # global bursts into global burst rate (Hz)
            if strcmp(varNames{ii},'elecInGB')
                div14_0g_50b = div14_0g_50b./300;
                div15_0g_50b = div15_0g_50b./300;
                div17_0g_50b = div17_0g_50b./300;
            end %if strcmp
            div14_0g_50b_old = div14_0g_50b;
            if strcmp(thisVar,'spikeRateArray')
                [r14_0g_50b,~] = find(div14_0g_50b_old<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r14_0g_50b,~] = find(div14_0g_50b_old<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r14_0g_50b,~] = find(div14_0g_50b_old<gbThr);
            else
                [r14_0g_50b,~] = find(div14_0g_50b_old==0);
            end %if ii
            div14_0g_50b(r14_0g_50b) = [];
            div15_0g_50b(r14_0g_50b) = [];
            div17_0g_50b(r14_0g_50b) = [];
            
            div14_0g_50b_old = div14_0g_50b;
            div14_0g_50b(isnan(div14_0g_50b_old)) = [];
            div15_0g_50b(isnan(div14_0g_50b_old)) = [];
            div17_0g_50b(isnan(div14_0g_50b_old)) = [];
            div15_0g_50b_old = div15_0g_50b;
            div14_0g_50b(isnan(div15_0g_50b_old)) = [];
            div15_0g_50b(isnan(div15_0g_50b_old)) = [];
            div17_0g_50b(isnan(div15_0g_50b_old)) = [];
            div17_0g_50b_old = div17_0g_50b;
            div14_0g_50b(isnan(div17_0g_50b_old)) = [];
            div15_0g_50b(isnan(div17_0g_50b_old)) = [];
            div17_0g_50b(isnan(div17_0g_50b_old)) = [];
            
            div15_0g_50b_other = div15_0g_50b;
            div17_0g_50b_other = div17_0g_50b;
            if strcmp(thisVar,'spikeRateArray')
                [r15_0g_50b,~] = find(div15_0g_50b<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r15_0g_50b,~] = find(div15_0g_50b<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r15_0g_50b,~] = find(div15_0g_50b<gbThr);
            else
                [r15_0g_50b,~] = find(div15_0g_50b==0);
            end %if ii
            div15_0g_50b_other(r15_0g_50b) = [];
            div17_0g_50b_other(r15_0g_50b) = [];
            
            
            div14_30g_0b = [];
            div15_30g_0b = [];
            div17_30g_0b = [];
            for jj=1:size(elecData.cond30g_0b.div15,2)
                div14_30g_0b = [div14_30g_0b; elecData.cond30g_0b.div14(jj).(thisVar).rawCleaned];
                div15_30g_0b = [div15_30g_0b; elecData.cond30g_0b.div15(jj).(thisVar).rawCleaned];
                div17_30g_0b = [div17_30g_0b; elecData.cond30g_0b.div17(jj).(thisVar).rawCleaned];
            end %for jj
            % make # global bursts into global burst rate (Hz)
            if strcmp(varNames{ii},'elecInGB')
                div14_30g_0b = div14_30g_0b./300;
                div15_30g_0b = div15_30g_0b./300;
                div17_30g_0b = div17_30g_0b./300;
            end %if strcmp
            div14_30g_0b_old = div14_30g_0b;
            if strcmp(thisVar,'spikeRateArray')
                [r14_30g_0b,~] = find(div14_30g_0b_old<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r14_30g_0b,~] = find(div14_30g_0b_old<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r14_30g_0b,~] = find(div14_30g_0b_old<gbThr);
            else
                [r14_30g_0b,~] = find(div14_30g_0b_old==0);
            end %if ii
            div14_30g_0b(r14_30g_0b) = [];
            div15_30g_0b(r14_30g_0b) = [];
            div17_30g_0b(r14_30g_0b) = [];
            
            div14_30g_0b_old = div14_30g_0b;
            div14_30g_0b(isnan(div14_30g_0b_old)) = [];
            div15_30g_0b(isnan(div14_30g_0b_old)) = [];
            div17_30g_0b(isnan(div14_30g_0b_old)) = [];
            div15_30g_0b_old = div15_30g_0b;
            div14_30g_0b(isnan(div15_30g_0b_old)) = [];
            div15_30g_0b(isnan(div15_30g_0b_old)) = [];
            div17_30g_0b(isnan(div15_30g_0b_old)) = [];
            div17_30g_0b_old = div17_30g_0b;
            div14_30g_0b(isnan(div17_30g_0b_old)) = [];
            div15_30g_0b(isnan(div17_30g_0b_old)) = [];
            div17_30g_0b(isnan(div17_30g_0b_old)) = [];
            
            div15_30g_0b_other = div15_30g_0b;
            div17_30g_0b_other = div17_30g_0b;
            if strcmp(thisVar,'spikeRateArray')
                [r15_30g_0b,~] = find(div15_30g_0b<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r15_30g_0b,~] = find(div15_30g_0b<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r15_30g_0b,~] = find(div15_30g_0b<gbThr);
            else
                [r15_30g_0b,~] = find(div15_30g_0b==0);
            end %if ii
            div15_30g_0b_other(r15_30g_0b) = [];
            div17_30g_0b_other(r15_30g_0b) = [];
            
            
            div14_30g_50b = [];
            div15_30g_50b = [];
            div17_30g_50b = [];
            for jj=1:size(elecData.cond30g_50b.div15,2)
                div14_30g_50b = [div14_30g_50b; elecData.cond30g_50b.div14(jj).(thisVar).rawCleaned];
                div15_30g_50b = [div15_30g_50b; elecData.cond30g_50b.div15(jj).(thisVar).rawCleaned];
                div17_30g_50b = [div17_30g_50b; elecData.cond30g_50b.div17(jj).(thisVar).rawCleaned];
            end %for jj
            % make # global bursts into global burst rate (Hz)
            if strcmp(varNames{ii},'elecInGB')
                div14_30g_50b = div14_30g_50b./300;
                div15_30g_50b = div15_30g_50b./300;
                div17_30g_50b = div17_30g_50b./300;
            end %if strcmp
            div14_30g_50b_old = div14_30g_50b;
            if strcmp(thisVar,'spikeRateArray')
                [r14_30g_50b,~] = find(div14_30g_50b_old<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r14_30g_50b,~] = find(div14_30g_50b_old<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r14_30g_50b,~] = find(div14_30g_50b_old<gbThr);
            else
                [r14_30g_50b,~] = find(div14_30g_50b_old==0);
            end %if ii
            div14_30g_50b(r14_30g_50b) = [];
            div15_30g_50b(r14_30g_50b) = [];
            div17_30g_50b(r14_30g_50b) = [];
            
            div14_30g_50b_old = div14_30g_50b;
            div14_30g_50b(isnan(div14_30g_50b_old)) = [];
            div15_30g_50b(isnan(div14_30g_50b_old)) = [];
            div17_30g_50b(isnan(div14_30g_50b_old)) = [];
            div15_30g_50b_old = div15_30g_50b;
            div14_30g_50b(isnan(div15_30g_50b_old)) = [];
            div15_30g_50b(isnan(div15_30g_50b_old)) = [];
            div17_30g_50b(isnan(div15_30g_50b_old)) = [];
            div17_30g_50b_old = div17_30g_50b;
            div14_30g_50b(isnan(div17_30g_50b_old)) = [];
            div15_30g_50b(isnan(div17_30g_50b_old)) = [];
            div17_30g_50b(isnan(div17_30g_50b_old)) = [];
            
            div15_30g_50b_other = div15_30g_50b;
            div17_30g_50b_other = div17_30g_50b;
            if strcmp(thisVar,'spikeRateArray')
                [r15_30g_50b,~] = find(div15_30g_50b<spkThr);
            elseif strcmp(thisVar,'burstletRateArray')
                [r15_30g_50b,~] = find(div15_30g_50b<brstThr);
            elseif strcmp(thisVar,'elecInGB')
                [r15_30g_50b,~] = find(div15_30g_50b<gbThr);
            else
                [r15_30g_50b,~] = find(div15_30g_50b==0);
            end %if ii
            div15_30g_50b_other(r15_30g_50b) = [];
            div17_30g_50b_other(r15_30g_50b) = [];
            
        elseif aa==2
            
            div14_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div14.(thisVar).rawCleaned;
            div15_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div15.(thisVar).rawCleaned;
            div17_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div17.(thisVar).rawCleaned;
            
            div14_0g_0b_old = div14_0g_0b;
            div14_0g_0b(isnan(div14_0g_0b_old)) = [];
            div15_0g_0b(isnan(div14_0g_0b_old)) = [];
            div17_0g_0b(isnan(div14_0g_0b_old)) = [];
            div15_0g_0b_old = div15_0g_0b;
            div14_0g_0b(isnan(div15_0g_0b_old)) = [];
            div15_0g_0b(isnan(div15_0g_0b_old)) = [];
            div17_0g_0b(isnan(div15_0g_0b_old)) = [];
            div17_0g_0b_old = div17_0g_0b;
            div14_0g_0b(isnan(div17_0g_0b_old)) = [];
            div15_0g_0b(isnan(div17_0g_0b_old)) = [];
            div17_0g_0b(isnan(div17_0g_0b_old)) = [];
            
            % for div15-div17 comparison ONLY
            div15_0g_0b_other = div15_0g_0b;
            div17_0g_0b_other = div17_0g_0b;
            [r15_0g_0b,~] = find(div15_0g_0b==0);
            div15_0g_0b_other(r15_0g_0b) = [];
            div17_0g_0b_other(r15_0g_0b) = [];
            
            
            div14_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div14.(thisVar).rawCleaned;
            div15_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div15.(thisVar).rawCleaned;
            div17_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div17.(thisVar).rawCleaned;
            
            div14_0g_50b_old = div14_0g_50b;
            div14_0g_50b(isnan(div14_0g_50b_old)) = [];
            div15_0g_50b(isnan(div14_0g_50b_old)) = [];
            div17_0g_50b(isnan(div14_0g_50b_old)) = [];
            div15_0g_50b_old = div15_0g_50b;
            div14_0g_50b(isnan(div15_0g_50b_old)) = [];
            div15_0g_50b(isnan(div15_0g_50b_old)) = [];
            div17_0g_50b(isnan(div15_0g_50b_old)) = [];
            div17_0g_50b_old = div17_0g_50b;
            div14_0g_50b(isnan(div17_0g_50b_old)) = [];
            div15_0g_50b(isnan(div17_0g_50b_old)) = [];
            div17_0g_50b(isnan(div17_0g_50b_old)) = [];
            
            % for div15-div17 comparison ONLY
            div15_0g_50b_other = div15_0g_50b;
            div17_0g_50b_other = div17_0g_50b;
            [r15_0g_50b,~] = find(div15_0g_50b==0);
            div15_0g_50b_other(r15_0g_50b) = [];
            div17_0g_50b_other(r15_0g_50b) = [];
            
            
            div14_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div14.(thisVar).rawCleaned;
            div15_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div15.(thisVar).rawCleaned;
            div17_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div17.(thisVar).rawCleaned;
            
            div14_30g_0b_old = div14_30g_0b;
            div14_30g_0b(isnan(div14_30g_0b_old)) = [];
            div15_30g_0b(isnan(div14_30g_0b_old)) = [];
            div17_30g_0b(isnan(div14_30g_0b_old)) = [];
            div15_30g_0b_old = div15_30g_0b;
            div14_30g_0b(isnan(div15_30g_0b_old)) = [];
            div15_30g_0b(isnan(div15_30g_0b_old)) = [];
            div17_30g_0b(isnan(div15_30g_0b_old)) = [];
            div17_30g_0b_old = div17_30g_0b;
            div14_30g_0b(isnan(div17_30g_0b_old)) = [];
            div15_30g_0b(isnan(div17_30g_0b_old)) = [];
            div17_30g_0b(isnan(div17_30g_0b_old)) = [];
            
            % for div15-div17 comparison ONLY
            div15_30g_0b_other = div15_30g_0b;
            div17_30g_0b_other = div17_30g_0b;
            [r15_30g_0b,~] = find(div15_30g_0b==0);
            div15_30g_0b_other(r15_30g_0b) = [];
            div17_30g_0b_other(r15_30g_0b) = [];
            
            
            div14_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div14.(thisVar).rawCleaned;
            div15_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div15.(thisVar).rawCleaned;
            div17_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div17.(thisVar).rawCleaned;
            
            div14_30g_50b_old = div14_30g_50b;
            div14_30g_50b(isnan(div14_30g_50b_old)) = [];
            div15_30g_50b(isnan(div14_30g_50b_old)) = [];
            div17_30g_50b(isnan(div14_30g_50b_old)) = [];
            div15_30g_50b_old = div15_30g_50b;
            div14_30g_50b(isnan(div15_30g_50b_old)) = [];
            div15_30g_50b(isnan(div15_30g_50b_old)) = [];
            div17_30g_50b(isnan(div15_30g_50b_old)) = [];
            div17_30g_50b_old = div17_30g_50b;
            div14_30g_50b(isnan(div17_30g_50b_old)) = [];
            div15_30g_50b(isnan(div17_30g_50b_old)) = [];
            div17_30g_50b(isnan(div17_30g_50b_old)) = [];
            
            % for div15-div17 comparison ONLY
            div15_30g_50b_other = div15_30g_50b;
            div17_30g_50b_other = div17_30g_50b;
            [r15_30g_50b,~] = find(div15_30g_50b==0);
            div15_30g_50b_other(r15_30g_50b) = [];
            div17_30g_50b_other(r15_30g_50b) = [];
            
        elseif aa==3
            
            data1a = [];
            data2a = [];
            data3a = [];
            for jj=1:length(orgData.(thisVar).div14)
                if ~isempty(orgData.(thisVar).div14(jj).cond0g_0b)
                    data1a = [data1a; orgData.(thisVar).div14(jj).cond0g_0b];
                    data2a = [data2a; orgData.(thisVar).div15(jj).cond0g_0b];
                    data3a = [data3a; orgData.(thisVar).div17(jj).cond0g_0b];
                end %if ~isempty
            end %for ii
            div14_0g_0b = data1a;
            div15_0g_0b = data2a;
            div17_0g_0b = data3a;
            
            div14_0g_0b_old = div14_0g_0b;
            [r14_0g_0b,~] = find(div14_0g_0b_old<elocThr);%find(div14_0g_0b_old==0);
            div14_0g_0b(r14_0g_0b) = [];
            div15_0g_0b(r14_0g_0b) = [];
            div17_0g_0b(r14_0g_0b) = [];
            
            div14_0g_0b_old = div14_0g_0b;
            div14_0g_0b(isnan(div14_0g_0b_old)) = [];
            div15_0g_0b(isnan(div14_0g_0b_old)) = [];
            div17_0g_0b(isnan(div14_0g_0b_old)) = [];
            div15_0g_0b_old = div15_0g_0b;
            div14_0g_0b(isnan(div15_0g_0b_old)) = [];
            div15_0g_0b(isnan(div15_0g_0b_old)) = [];
            div17_0g_0b(isnan(div15_0g_0b_old)) = [];
            div17_0g_0b_old = div17_0g_0b;
            div14_0g_0b(isnan(div17_0g_0b_old)) = [];
            div15_0g_0b(isnan(div17_0g_0b_old)) = [];
            div17_0g_0b(isnan(div17_0g_0b_old)) = [];
            
            % for div10-div17 comparison ONLY for Eloc
            div15_0g_0b_other = div15_0g_0b;
            div17_0g_0b_other = div17_0g_0b;
            [r15_0g_0b,~] = find(div15_0g_0b<=elocThr);%find(div15_0g_0b==0);
            div15_0g_0b_other(r15_0g_0b) = [];
            div17_0g_0b_other(r15_0g_0b) = [];
            
            
            data1b = [];
            data2b = [];
            data3b = [];
            for jj=1:length(orgData.(thisVar).div14)
                if ~isempty(orgData.(thisVar).div14(jj).cond0g_50b)
                    data1b = [data1b; orgData.(thisVar).div14(jj).cond0g_50b];
                    data2b = [data2b; orgData.(thisVar).div15(jj).cond0g_50b];
                    data3b = [data3b; orgData.(thisVar).div17(jj).cond0g_50b];
                end %if ~isempty
            end %for ii
            div14_0g_50b = data1b;
            div15_0g_50b = data2b;
            div17_0g_50b = data3b;
            
            div14_0g_50b_old = div14_0g_50b;
            [r14_0g_50b,~] = find(div14_0g_50b_old<=elocThr);%find(div14_0g_50b_old==0);
            div14_0g_50b(r14_0g_50b) = [];
            div15_0g_50b(r14_0g_50b) = [];
            div17_0g_50b(r14_0g_50b) = [];
            
            div14_0g_50b_old = div14_0g_50b;
            div14_0g_50b(isnan(div14_0g_50b_old)) = [];
            div15_0g_50b(isnan(div14_0g_50b_old)) = [];
            div17_0g_50b(isnan(div14_0g_50b_old)) = [];
            div15_0g_50b_old = div15_0g_50b;
            div14_0g_50b(isnan(div15_0g_50b_old)) = [];
            div15_0g_50b(isnan(div15_0g_50b_old)) = [];
            div17_0g_50b(isnan(div15_0g_50b_old)) = [];
            div17_0g_50b_old = div17_0g_50b;
            div14_0g_50b(isnan(div17_0g_50b_old)) = [];
            div15_0g_50b(isnan(div17_0g_50b_old)) = [];
            div17_0g_50b(isnan(div17_0g_50b_old)) = [];
            
            % for div10-div17 comparison ONLY for Eloc
            div15_0g_50b_other = div15_0g_50b;
            div17_0g_50b_other = div17_0g_50b;
            [r15_0g_50b,~] = find(div15_0g_50b<=elocThr);%find(div15_0g_50b==0);
            div15_0g_50b_other(r15_0g_50b) = [];
            div17_0g_50b_other(r15_0g_50b) = [];
            
            
            data1c = [];
            data2c = [];
            data3c = [];
            for jj=1:length(orgData.(thisVar).div14)
                if ~isempty(orgData.(thisVar).div14(jj).cond30g_0b)
                    data1c = [data1c; orgData.(thisVar).div14(jj).cond30g_0b];
                    data2c = [data2c; orgData.(thisVar).div15(jj).cond30g_0b];
                    data3c = [data3c; orgData.(thisVar).div17(jj).cond30g_0b];
                end %if ~isempty
            end %for ii
            div14_30g_0b = data1c;
            div15_30g_0b = data2c;
            div17_30g_0b = data3c;
            
            div14_30g_0b_old = div14_30g_0b;
            [r14_30g_0b,~] = find(div14_30g_0b_old<=elocThr);%find(div14_30g_0b_old==0);
            div14_30g_0b(r14_30g_0b) = [];
            div15_30g_0b(r14_30g_0b) = [];
            div17_30g_0b(r14_30g_0b) = [];

            div14_30g_0b_old = div14_30g_0b;
            div14_30g_0b(isnan(div14_30g_0b_old)) = [];
            div15_30g_0b(isnan(div14_30g_0b_old)) = [];
            div17_30g_0b(isnan(div14_30g_0b_old)) = [];
            div15_30g_0b_old = div15_30g_0b;
            div14_30g_0b(isnan(div15_30g_0b_old)) = [];
            div15_30g_0b(isnan(div15_30g_0b_old)) = [];
            div17_30g_0b(isnan(div15_30g_0b_old)) = [];
            div17_30g_0b_old = div17_30g_0b;
            div14_30g_0b(isnan(div17_30g_0b_old)) = [];
            div15_30g_0b(isnan(div17_30g_0b_old)) = [];
            div17_30g_0b(isnan(div17_30g_0b_old)) = [];
            
            % for div10-div17 comparison ONLY for Eloc
            div15_30g_0b_other = div15_30g_0b;
            div17_30g_0b_other = div17_30g_0b;
            [r15_30g_0b,~] = find(div15_30g_0b<=elocThr);%find(div15_30g_0b==0);
            div15_30g_0b_other(r15_30g_0b) = [];
            div17_30g_0b_other(r15_30g_0b) = [];
            
            
            data1d = [];
            data2d = [];
            data3d = [];
            for jj=1:length(orgData.(thisVar).div14)
                if ~isempty(orgData.(thisVar).div14(jj).cond30g_50b)
                    data1d = [data1d; orgData.(thisVar).div14(jj).cond30g_50b];
                    data2d = [data2d; orgData.(thisVar).div15(jj).cond30g_50b];
                    data3d = [data3d; orgData.(thisVar).div17(jj).cond30g_50b];
                end %if ~isempty
            end %for ii
            div14_30g_50b = data1d;
            div15_30g_50b = data2d;
            div17_30g_50b = data3d;
            
            div14_30g_50b_old = div14_30g_50b;
            [r14_30g_50b,~] = find(div14_30g_50b_old<=elocThr);%find(div14_30g_50b_old==0);
            div14_30g_50b(r14_30g_50b) = [];
            div15_30g_50b(r14_30g_50b) = [];
            div17_30g_50b(r14_30g_50b) = [];
            
            div14_30g_50b_old = div14_30g_50b;
            div14_30g_50b(isnan(div14_30g_50b_old)) = [];
            div15_30g_50b(isnan(div14_30g_50b_old)) = [];
            div17_30g_50b(isnan(div14_30g_50b_old)) = [];
            div15_30g_50b_old = div15_30g_50b;
            div14_30g_50b(isnan(div15_30g_50b_old)) = [];
            div15_30g_50b(isnan(div15_30g_50b_old)) = [];
            div17_30g_50b(isnan(div15_30g_50b_old)) = [];
            div17_30g_50b_old = div17_30g_50b;
            div14_30g_50b(isnan(div17_30g_50b_old)) = [];
            div15_30g_50b(isnan(div17_30g_50b_old)) = [];
            div17_30g_50b(isnan(div17_30g_50b_old)) = [];
            
            % for div10-div17 comparison ONLY for Eloc
            div15_30g_50b_other = div15_30g_50b;
            div17_30g_50b_other = div17_30g_50b;
            [r15_30g_50b,~] = find(div15_30g_50b<=elocThr);%find(div15_30g_50b==0);
            div15_30g_50b_other(r15_30g_50b) = [];
            div17_30g_50b_other(r15_30g_50b) = [];
            
        end %if aa
        
        fig1 = figure('Position', [1,41,1280,607.33]);
        xlim([0 xLocs1(end)+1]); hold on;
        
        xJitt = jittAmt*rand(length(div14_0g_0b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(1),div14_0g_0b,scattSz,'o','markeredgecolor','k','markerfacecolor','w');
        xJitt = jittAmt*rand(length(div15_0g_0b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(2),div15_0g_0b,scattSz,'o','markeredgecolor','k','markerfacecolor',[0.4 0.4 0.4]);
        xJitt = jittAmt*rand(length(div17_0g_0b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(3),div17_0g_0b,scattSz,'o','markeredgecolor','k','markerfacecolor','k');
        
        xJitt = jittAmt*rand(length(div14_0g_50b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(4),div14_0g_50b,scattSz,'d','markeredgecolor','k','markerfacecolor','w');
        xJitt = jittAmt*rand(length(div15_0g_50b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(5),div15_0g_50b,scattSz,'d','markeredgecolor','k','markerfacecolor',[0.4 0.4 0.4]);
        xJitt = jittAmt*rand(length(div17_0g_50b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(6),div17_0g_50b,scattSz,'d','markeredgecolor','k','markerfacecolor','k');
        
        xJitt = jittAmt*rand(length(div14_0g_0b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(7),div14_0g_0b,scattSz,'o','markeredgecolor','r','markerfacecolor','w');
        xJitt = jittAmt*rand(length(div15_0g_0b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(8),div15_0g_0b,scattSz,'o','markeredgecolor','r','markerfacecolor',[1 0.4 0.4]);
        xJitt = jittAmt*rand(length(div17_0g_0b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(9),div17_0g_0b,scattSz,'o','markeredgecolor','r','markerfacecolor','r');
        
        xJitt = jittAmt*rand(length(div14_0g_50b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(10),div14_0g_50b,scattSz,'d','markeredgecolor','r','markerfacecolor','w');
        xJitt = jittAmt*rand(length(div15_0g_50b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(11),div15_0g_50b,scattSz,'d','markeredgecolor','r','markerfacecolor',[1 0.4 0.4]);
        xJitt = jittAmt*rand(length(div17_0g_50b),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(12),div17_0g_50b,scattSz,'d','markeredgecolor','r','markerfacecolor','r');
        
        plot([xLocs1(1)-sz/2, xLocs1(1)+sz/2], [mean(div14_0g_0b) mean(div14_0g_0b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(2)-sz/2, xLocs1(2)+sz/2], [mean(div15_0g_0b) mean(div15_0g_0b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(3)-sz/2, xLocs1(3)+sz/2], [mean(div17_0g_0b) mean(div17_0g_0b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(4)-sz/2, xLocs1(4)+sz/2], [mean(div14_0g_50b) mean(div14_0g_50b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(5)-sz/2, xLocs1(5)+sz/2], [mean(div15_0g_50b) mean(div15_0g_50b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(6)-sz/2, xLocs1(6)+sz/2], [mean(div17_0g_50b) mean(div17_0g_50b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(7)-sz/2, xLocs1(7)+sz/2], [mean(div14_30g_0b) mean(div14_30g_0b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(8)-sz/2, xLocs1(8)+sz/2], [mean(div15_30g_0b) mean(div15_30g_0b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(9)-sz/2, xLocs1(9)+sz/2], [mean(div17_30g_0b) mean(div17_30g_0b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(10)-sz/2, xLocs1(10)+sz/2], [mean(div14_30g_50b) mean(div14_30g_50b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(11)-sz/2, xLocs1(11)+sz/2], [mean(div15_30g_50b) mean(div15_30g_50b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        plot([xLocs1(12)-sz/2, xLocs1(12)+sz/2], [mean(div17_30g_50b) mean(div17_30g_50b)],'color','k', 'linewidth',5); %[0.4 0.4 0.4],'linewidth',2);
        
        set(gca,'box','off','tickdir','out');
        xticks(xLocs1);
        xticklabels({'','','','','','','','','','','',''});
        
        disp('');
        disp(thisVar);
        disp('');
        disp(['N for div14_0g_0b = ',num2str(length(div14_0g_0b))]);
        disp(['N for div15_0g_0b = ',num2str(length(div15_0g_0b))]);
        disp(['N for div17_0g_0b = ',num2str(length(div17_0g_0b))]);
        disp('');
        disp(['N for div14_0g_50b = ',num2str(length(div14_0g_50b))]);
        disp(['N for div15_0g_50b = ',num2str(length(div15_0g_50b))]);
        disp(['N for div17_0g_50b = ',num2str(length(div17_0g_50b))]);
        disp('');
        disp(['N for div14_30g_0b = ',num2str(length(div14_30g_0b))]);
        disp(['N for div15_30g_0b = ',num2str(length(div15_30g_0b))]);
        disp(['N for div17_30g_0b = ',num2str(length(div17_30g_0b))]);
        disp('');
        disp(['N for div14_30g_50b = ',num2str(length(div14_30g_50b))]);
        disp(['N for div15_30g_50b = ',num2str(length(div15_30g_50b))]);
        disp(['N for div17_30g_50b = ',num2str(length(div17_30g_50b))]);
        disp('');
        
        if ready2save
            saveas(fig1,[figDir,thisVar,'_rawMean.png']);
            saveas(fig1,[figDir,thisVar,'_rawMean.fig']);
            saveas(fig1,[figDir,thisVar,'_rawMean.svg']);
        end %if ready2save
        
        close(fig1);
        
    end %for ii
    
end %for aa



