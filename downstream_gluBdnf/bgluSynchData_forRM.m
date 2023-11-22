% bgluSynchData_forRM.m

%% PART 0 - set colors

clc; clear all; close all;

% actual colors to use
myColors(1,:) = [0 0 0]; % black
myColors(2,:) = [0.6 0.6 0.6]; % grey
myColors(3,:) = [1 0 0]; % red
myColors(4,:) = [1 0.6 0.6]; % light red

%% PART 1a - GATHER DATA

% % % * * * * * * * * * * % % %
ready2save = 1; % * * * * * * %
% % % * * * * * * * * * * % % %

theDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF GLU injury recovery\revision_0g30gonly\data\';
figDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF GLU injury recovery\revision_0g30gonly\data\figs\';

% load variable elecData
load([theDir, 'bgluDataforRM_byELEC_FF100msec'],'elecData');

theConds = {'cond0g_0b', 'cond0g_50b', 'cond30g_0b', 'cond30g_50b'};
theVars = {'SF147'};
theSubVars.cat1 = {'SF14','SF47','SF71'};
theXlabels = { {'0.1-0.4','0.4-0.7','0.7-1.0'}; ...
    };

% RAW
rawDays = {'div14','div15','div17'};
for ii=1:length(rawDays)
    
    for jj=1:length(theConds)
        
        for kk=1:length(theVars)
            theCatMeth = ['cat',num2str(kk)];
            theseCats = theSubVars.(theCatMeth);
            
            for mm=1:length(theseCats)
                
                rawSynchData = [];
                rawElec1 = [];
                rawElec2 = [];
                rawMEAnums = [];
                rawExpNums = [];
                for nn=1:length(elecData.(theConds{jj}).(rawDays{ii})) % *** need to go through each of the elecData experiments to get all the data
                    thisRawData = elecData.(theConds{jj}).(rawDays{ii})(nn).(theseCats{mm}).rawCleaned;
                    thisRawElec1 = elecData.(theConds{jj}).(rawDays{ii})(nn).(theseCats{mm}).elec1;
                    thisRawElec2 = elecData.(theConds{jj}).(rawDays{ii})(nn).(theseCats{mm}).elec2;
                    thisRawMEAnum = elecData.(theConds{jj}).(rawDays{ii})(nn).meaNum.*ones(size(thisRawElec1));
                    thisRawExpNum = elecData.(theConds{jj}).(rawDays{ii})(nn).expNum.*ones(size(thisRawElec1));
                    
                    rawSynchData = [rawSynchData; thisRawData];
                    rawElec1 = [rawElec1; thisRawElec1];
                    rawElec2 = [rawElec2; thisRawElec2];
                    rawMEAnums = [rawMEAnums; thisRawMEAnum];
                    rawExpNums = [rawExpNums; thisRawExpNum];
                end %for nn
                
                bgluRawSynchData.(theVars{kk}).(theConds{jj}).(rawDays{ii}).(theseCats{mm}).rawCleaned = rawSynchData;
                bgluRawSynchData.(theVars{kk}).(theConds{jj}).(rawDays{ii}).(theseCats{mm}).elec1 = rawElec1;
                bgluRawSynchData.(theVars{kk}).(theConds{jj}).(rawDays{ii}).(theseCats{mm}).elec2 = rawElec2;
                bgluRawSynchData.(theVars{kk}).(theConds{jj}).(rawDays{ii}).(theseCats{mm}).meaNums = rawMEAnums;
                bgluRawSynchData.(theVars{kk}).(theConds{jj}).(rawDays{ii}).(theseCats{mm}).expNums = rawExpNums;
                
            end %for mm
            
        end% for kk
        
    end %for jj
    
end %for ii

if ready2save
    save([theDir, 'bgluSynchData_forRM.mat'],'bgluRawSynchData');
end %if ready2save

clear bgluRawSynchData

% NORMALIZED
normDays = {'div15','div17'};
for ii=1:length(normDays)
    
    for jj=1:length(theConds)
        
        for kk=1:length(theVars)
            theCatMeth = ['cat',num2str(kk)];
            theseCats = theSubVars.(theCatMeth);
            
            for mm=1:length(theseCats)
                
                normSynchData = [];
                normElec1 = [];
                normElec2 = [];
                normMEAnums = [];
                normExpNums = [];
                for nn=1:length(elecData.(theConds{jj}).(normDays{ii})) % *** need to go through each of the elecData experiments to get all the data
                    thisNormData = elecData.(theConds{jj}).(normDays{ii})(nn).(theseCats{mm}).normCleaned;
                    thisNormElec1 = elecData.(theConds{jj}).(normDays{ii})(nn).(theseCats{mm}).elec1;
                    thisNormElec2 = elecData.(theConds{jj}).(normDays{ii})(nn).(theseCats{mm}).elec2;
                    thisNormMEAnum = elecData.(theConds{jj}).(normDays{ii})(nn).meaNum.*ones(size(thisNormElec1));
                    thisNormExpNum = elecData.(theConds{jj}).(normDays{ii})(nn).expNum.*ones(size(thisNormElec1));
                    
                    normSynchData = [normSynchData; thisNormData];
                    normElec1 = [normElec1; thisNormElec1];
                    normElec2 = [normElec2; thisNormElec2];
                    normMEAnums = [normMEAnums; thisNormMEAnum];
                    normExpNums = [normExpNums; thisNormExpNum];
                end %for nn
                
                bgluNormSynchData.(theVars{kk}).(theConds{jj}).(normDays{ii}).(theseCats{mm}).normCleaned = normSynchData;
                bgluNormSynchData.(theVars{kk}).(theConds{jj}).(normDays{ii}).(theseCats{mm}).elec1 = normElec1;
                bgluNormSynchData.(theVars{kk}).(theConds{jj}).(normDays{ii}).(theseCats{mm}).elec2 = normElec2;
                bgluNormSynchData.(theVars{kk}).(theConds{jj}).(normDays{ii}).(theseCats{mm}).meaNums = normMEAnums;
                bgluNormSynchData.(theVars{kk}).(theConds{jj}).(normDays{ii}).(theseCats{mm}).expNums = normExpNums;
            end %for mm
            
        end% for kk
        
    end %for jj
    
end %for ii

if ready2save
    save([theDir, 'bgluSynchData_forRM.mat'],'bgluNormSynchData','-append');
end %if ready2save

clear bgluNormSynchData elecData

