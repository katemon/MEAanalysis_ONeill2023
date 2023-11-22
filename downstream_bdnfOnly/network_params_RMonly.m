function [] = network_params_RMonly(binsize, maxlag)

addpath(genpath('D:\kate_dropbox\Dropbox\Rutgers\Matlab - Rutgers\Firestein Lab\BCT\'));

%parameters
totaltime = 300;

%options
raster = 0;
plotme = 0;
extracalcs = 1;

% ************************************************
totalNumExp = 3;

count.cond0B = 1; %want to add to the end always
count.cond25B = 1; %want to add to the end always
count.cond50B = 1; %want to add to the end always
% ************************************************

params.binsize = binsize;
params.maxlag = maxlag;
params.raster = raster;
params.plotme = plotme;
params.extracalcs = extracalcs;

for ii=1:totalNumExp
    thisExp = ['exp',num2str(ii)] %display this
    
    %         mainDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE BDNF dose response from home';
    %         otherDirInfo = ' dissection';
    loadDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE BDNF dose response from home\';
    saveDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\MEA paper(s)\figures\data - BDNF dose response\data_networkParams\';
    
    if ii==1
        expNum = 3;
        meaNames = {'24131', '24138', '24139', '24140', '24141', '24142', '24143', '24144', '24145', '24146'};
        meaConds = {'50B', '0B', '25B', '25B', '50B', '0B', '25B', '0B', '50B', '50B'};
        dsxnDate = '2015-01-19';
        recDays = {'div07','div10','div17'};
    elseif ii==2
        expNum = 4;
        meaNames = {'24131', '24138', '24139', '24140', '24141', '24142', '24143', '24144', '24146'};
        meaConds = {'25B', '25B', '0B', '0B', '25B', '25B', '50B', '50B', '0B'};
        dsxnDate = '2015-03-26';
        recDays = {'div07','div10','div17'};
    elseif ii==3
        expNum = 7;
        meaNames = {'24131', '24138', '24139', '24140', '24141', '24143', '24144', '24146'};
        meaConds = {'25B', '0B', '50B', '0B', '50B', '25B', '50B', '25B'};
        dsxnDate = '2015-09-15';
        recDays = {'div07','div10','div17'};
    end %if ii
    
    loadDate = strrep(dsxnDate,'-','');
    normDay = recDays{1};
    numMEAs = length(meaNames);
    
    for jj=1:numMEAs
        
        disp(meaNames{jj});
        
        cond = meaConds{jj};
        thisCond = ['cond',cond];
        thisCount = count.(thisCond);
        
        for kk=1:length(recDays)
            thisRecDay = recDays{kk};
            
            % % % INFO
            netwData.(thisCond).(thisRecDay)(thisCount).meaName                  = meaNames{jj};
            netwData.(thisCond).(thisRecDay)(thisCount).dsxnDate                 = dsxnDate;
            netwData.(thisCond).(thisRecDay)(thisCount).expNum                   = ii;
            netwData.(thisCond).(thisRecDay)(thisCount).meaNum                   = thisCount;
            
            rawdataLoc = [loadDir,loadDate,' dissection\matlab data\',meaNames{jj},'\'];
            
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
    end %for jj
    
end %for ii

save('D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF dose response\revision_0B25B50Bonly\data\rmBDNF_doseResponse_netwData.mat','netwData','-v7.3');

end %function
