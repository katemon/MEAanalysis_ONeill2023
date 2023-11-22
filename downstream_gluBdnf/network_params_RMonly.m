function [] = network_params_RMonly(binsize, maxlag)

addpath(genpath('D:\kate_dropbox\Dropbox\Rutgers\Matlab - Rutgers\Firestein Lab\BCT\'));

%parameters
totaltime = 300;

%options
raster = 0;
plotme = 0;
extracalcs = 1;

% *** change each time! *** %
% chooseData = 2; %glu injury + BDNF recovery
% *** change each time! *** %

totalNumExp = 4;

count.cond0g_0b = 1; %want to add to the end always
count.cond0g_50b = 1; %want to add to the end always
count.cond30g_0b = 1; %want to add to the end always
count.cond30g_50b = 1; %want to add to the end always

params.binsize = binsize;
params.maxlag = maxlag;
params.raster = raster;
params.plotme = plotme;
params.extracalcs = extracalcs;

for ii=1:totalNumExp
    thisExp = ['exp',num2str(ii)] %display this
    %
    %         mainDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE GLU BDNF from home';
    %         otherDirInfo = ' dissection - hippo glu BDNF';
    loadDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE GLU BDNF from home\';
    saveDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\MEA paper(s)\figures\data - BDNF GLU injury recovery\data_networkParams\';
    
    if ii==1
        expNum = 3;
        meaNames = {'24131', '24138', '24139', '24140', '24141', '24142', '24143', '24144', ...
            '24145', '24146'};
        meaConds = {'0g_0b', '30g_0b', '60g_0b', '60g_50b', '0g_50b', '30g_50b', '60g_50b', '60g_0b', ...
            '0g_0b', '0g_50b'};
        dsxnDate = '2015-02-19';
        recDays = {'div14','div15','div17'};
    elseif ii==2
        expNum = 4;
        meaNames = {'24131', '24139', '24140', '24142', '24143', '24144', ...
            '24146'};
        meaConds = {'30g_0b', '60g_50b', '60g_0b', '0g_50b', '0g_0b', '60g_50b', ...
            '30g_50b'};
        dsxnDate = '2015-04-22';
        recDays = {'div14','div15','div17'};
    elseif ii==3
        expNum = 5;
        meaNames = {'12314', '15904', '24131', '24140', '24141', '24142', '24143', '24145', ...
            '26615', '26619'};
        meaConds = {'30g_50b', '60g_50b', '30g_0b', '60g_0b', '30g_0b', '0g_0b', '0g_50b', '0g_50b', ...
            '60g_0b', '0g_0b'};
        dsxnDate = '2015-11-23';
        recDays = {'div14','div15','div17'};
    elseif ii==4
        expNum = 7;
        meaNames = {'12314', '24131', '24139', '24140', '24141', '24142', '24143', '24144', ...
            '24145', '24146', '26614', '26615', '26619', '26873'};
        meaConds = {'60g_0b', '60g_50b', '0g_50b', '60g_50b', '0g_50b', '30g_0b', '30g_50b', '30g_0b', ...
            '0g_0b', '30g_50b', '30g_50b', '60g_0b', '60g_0b', '60g_50b'};
        dsxnDate = '2016-04-17';
        recDays = {'div14','div15','div17'};
    end %if ii
    
    loadDate = strrep(dsxnDate,'-','');
    normDay = recDays{1};
    numMEAs = length(meaNames);
    
    for jj=1:numMEAs
        
        disp(meaNames{jj});
        
        cond = meaConds{jj};
        thisCond = ['cond',cond];
        if ~strcmp(thisCond,'cond60g_0b') && ~strcmp(thisCond,'cond60g_50b')
            thisCount = count.(thisCond);
            
            for kk=1:length(recDays)
                thisRecDay = recDays{kk};
                
                % % % INFO
                netwData.(thisCond).(thisRecDay)(thisCount).meaName                  = meaNames{jj};
                netwData.(thisCond).(thisRecDay)(thisCount).dsxnDate                 = dsxnDate;
                netwData.(thisCond).(thisRecDay)(thisCount).expNum                   = ii;
                netwData.(thisCond).(thisRecDay)(thisCount).meaNum                   = thisCount;
                
                rawdataLoc = [loadDir,loadDate,' dissection - hippo glu BDNF\matlab data\',meaNames{jj},'\'];
                
                myFile1 = [rawdataLoc,thisRecDay,'_netwk.mat'];
                myFile2 = [rawdataLoc,thisRecDay,'_FFbyElec.mat'];
                
                if isfile(myFile1) && isfile(myFile2)
                    
                    load(myFile1,'SpikeTime','SpikeElectrode','allBadChannels');
                    
                    netwData.(thisCond).(thisRecDay)(thisCount).SpikeTime                = SpikeTime;
                    netwData.(thisCond).(thisRecDay)(thisCount).SpikeElectrode           = SpikeElectrode;
                    netwData.(thisCond).(thisRecDay)(thisCount).allBadChannels           = allBadChannels;
                else
                    netwData.(thisCond).(thisRecDay)(thisCount).SpikeTime                = [];
                    netwData.(thisCond).(thisRecDay)(thisCount).SpikeElectrode           = [];
                    netwData.(thisCond).(thisRecDay)(thisCount).allBadChannels           = [];
                end %if ~isempty
                
            end %for kk
            
            for kk=1:length(recDays)
                
                thisRecDay = recDays{kk};
                
                myFile1 = [rawdataLoc,thisRecDay,'_netwk.mat'];
                myFile2 = [rawdataLoc,thisRecDay,'_FFbyElec.mat'];
                
                if isfile(myFile1) && isfile(myFile2)
                    
                    load(myFile1,'SpikeElectrode','SpikeTime',...
                        'Eglob','Eloc','nCmnty','Q');
                    
                    netwData.(thisCond).(thisRecDay)(thisCount).Eglob       = Eglob;
                    netwData.(thisCond).(thisRecDay)(thisCount).Eloc        = Eloc;
                    netwData.(thisCond).(thisRecDay)(thisCount).nCmnty      = nCmnty;
                    netwData.(thisCond).(thisRecDay)(thisCount).Q           = Q;
                    
                else
                    
                    netwData.(thisCond).(thisRecDay)(thisCount).Eglob                   = [];
                    netwData.(thisCond).(thisRecDay)(thisCount).Eloc                    = [];
                    netwData.(thisCond).(thisRecDay)(thisCount).nCmnty                  = [];
                    netwData.(thisCond).(thisRecDay)(thisCount).Q                       = [];
                    
                end% if ~isempty
                
            end %for kk
            
            count.(thisCond) = count.(thisCond) + 1;
        end %if ~strcmp
    end %for jj
    
end %for ii

save('D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF GLU injury recovery\revision_0g30gonly\data\rmBGLU_injuryRecovery_netwData.mat','netwData','-v7.3');

end %function
