clc;
clear all;
close all;

addpath(genpath('D:\kate_dropbox\Dropbox\Rutgers\Matlab - Rutgers\Firestein Lab\BCT\'));

%parameters
totaltime = 300;
binsize = 10;
maxlag = 20*binsize;

%options
raster = 1;
plotme = 0;
extracalcs = 0;

disp(' ');

theBinSize = binsize;
theMaxLag = maxlag;
%%

params.binsize = theBinSize;
params.maxlag = theMaxLag;
params.raster = raster;
params.plotme = plotme;
params.extracalcs = extracalcs;

chooseData = 2; %glu injury + BDNF recovery
disp('glu injury + BDNF recovery data');

totalNumExp = 11;

count.cond0g_0b = 1; %want to add to the end always
count.cond0g_50b = 1; %want to add to the end always
count.cond30g_0b = 1; %want to add to the end always
count.cond30g_50b = 1; %want to add to the end always

for ii=1:totalNumExp
    thisExp = ['exp',num2str(ii)] %display this
    
    %BGLU injury recovery
    
    %         mainDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE GLU BDNF from home';
    %         otherDirInfo = ' dissection - hippo glu BDNF';
    loadDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE GLU BDNF from home\';
    saveDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\MEA paper(s)\figures\data - BDNF GLU injury recovery\data_networkParams\';
    
    if ii==1
        expNum = 1;
        meaNames = {'24144', '24145'};
        meaConds = {'0g_0b', '0g_0b'};
        dsxnDate = '2014-06-25';
        recDays = {'div14','div15','div17'};
        fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
        fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat', 'DIV17_Info.mat'};
    elseif ii==2
        expNum = 2;
        meaNames = {'24139', '24144', '24145'};
        meaConds = {'30g_0b', '0g_0b', '30g_0b'};
        dsxnDate = '2014-09-15';
        recDays = {'div14','div15','div17'};
        fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
        fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat', 'DIV17_Info.mat'};
    elseif ii==3
        expNum = 3;
        meaNames = {'24131', '24138', '24139', '24140', '24141', '24142', '24143', '24144', ...
            '24145', '24146'};
        meaConds = {'0g_0b', '30g_0b', '60g_0b', '60g_50b', '0g_50b', '30g_50b', '60g_50b', '60g_0b', ...
            '0g_0b', '0g_50b'};
        dsxnDate = '2015-02-19';
        recDays = {'div14','div15','div17'};
        fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
        fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat', 'DIV17_Info.mat'};
    elseif ii==4
        expNum = 4;
        meaNames = {'24131', '24138', '24139', '24140', '24141', '24142', '24143', '24144', ...
            '24145', '24146'};
        meaConds = {'30g_0b', '30g_50b', '60g_50b', '60g_0b', '30g_0b', '0g_50b', '0g_0b', '60g_50b', ...
            '60g_0b', '30g_50b'};
        dsxnDate = '2015-04-22';
        recDays = {'div14','div15','div17'};
        fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
        fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat', 'DIV17_Info.mat'};
    elseif ii==5
        expNum = 5;
        meaNames = {'12314', '15904', '24131', '24140', '24141', '24142', '24143', '24145', ...
            '26615', '26619'};
        meaConds = {'30g_50b', '60g_50b', '30g_0b', '60g_0b', '30g_0b', '0g_0b', '0g_50b', '0g_50b', ...
            '60g_0b', '0g_0b'};
        dsxnDate = '2015-11-23';
        recDays = {'div14','div15','div17'};
        fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
        fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat', 'DIV17_Info.mat'};
    elseif ii==6
        expNum = 6;
        meaNames = {'12314', '24131', '24140', '24143', '24144', '24146', '26614', '26615', ...
            '26616', '26619', '26873'};
        meaConds = {'60g_50b', '0g_0b', '0g_0b', '30g_0b', '0g_50b', '30g_50b', '60g_50b', '60g_0b', ...
            '30g_0b', '60g_0b', '30g_50b'};
        dsxnDate = '2016-02-01';
        recDays = {'div14','div15','div17'};
        fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
        fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat', 'DIV17_Info.mat'};
    elseif ii==7
        expNum = 7;
        meaNames = {'12314', '24131', '24139', '24140', '24141', '24142', '24143', '24144', ...
            '24145', '24146', '26614', '26615', '26619', '26873'};
        meaConds = {'60g_0b', '60g_50b', '0g_50b', '60g_50b', '0g_50b', '30g_0b', '30g_50b', '30g_0b', ...
            '0g_0b', '30g_50b', '30g_50b', '60g_0b', '60g_0b', '60g_50b'};
        dsxnDate = '2016-04-17';
        recDays = {'div14','div15','div17'};
        fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
        fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat', 'DIV17_Info.mat'};
    elseif ii==8
        expNum = 8;
        meaNames = {'12314', '15904', '24131', '24139', '24141', '24142', '24143', '24145', ...
            '26614', '26615', '26619', '26873', 'I5405', 'I5616', 'I5628', 'I6481'};
        meaConds = {'60g_50b', '0g_0b', '30g_0b', '60g_50b', '0g_50b', '0g_0b', '30g_0b', '60g_0b', ...
            '60g_0b', '60g_0b', '30g_0b', '0g_50b', '60g_0b', '0g_50b', '0g_0b', '30g_0b'};
        dsxnDate = '2016-05-24';
        recDays = {'div14','div15','div17'};
        fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
        fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat', 'DIV17_Info.mat'};
    elseif ii==9
        expNum = 9;
        meaNames = {'24131', '24141', '24144', '26619', 'I2420', 'I3820', 'I5405', 'I5616', ...
            'I5628', 'I5908', 'I6481'};
        meaConds = {'0g_0b', '30g_0b', '60g_50b', '30g_50b', '30g_0b', '30g_50b', '0g_50b', '0g_0b', ...
            '60g_0b', '60g_50b', '0g_50b'};
        dsxnDate = '2016-07-11';
        recDays = {'div14','div15','div17'};
        fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
        fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat', 'DIV17_Info.mat'};
    elseif ii==10
        expNum = 10;
        meaNames = {'I2420', 'I5616', 'I6481'};
        meaConds = {'30g_0b', '30g_0b', '0g_0b'};
        dsxnDate = '2017-02-20';
        recDays = {'div14','div15','div17'};
        fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
        fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat', 'DIV17_Info.mat'};
    elseif ii==11
        expNum = 11;
        meaNames = {'I5616', 'I5908', 'I6481'};
        meaConds = {'0g_0b', '30g_0b', '0g_0b'};
        dsxnDate = '2017-03-21';
        recDays = {'div14','div15','div17'};
        fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
        fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat', 'DIV17_Info.mat'};
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
            
            allBadChannels = [];
            for kk=1:length(recDays)
                thisRecDay = recDays{kk};
                
                % % % INFO
                netwData.(thisCond).(thisRecDay)(thisCount).meaName                  = meaNames{jj};
                netwData.(thisCond).(thisRecDay)(thisCount).dsxnDate                 = dsxnDate;
                netwData.(thisCond).(thisRecDay)(thisCount).expNum                   = ii;
                netwData.(thisCond).(thisRecDay)(thisCount).meaNum                   = thisCount;
                
                rawdataLoc = [loadDir,loadDate,' dissection - hippo glu BDNF\matlab data\',meaNames{jj},'\'];
                
                myFile1 = [rawdataLoc,fileNames1{kk}];
                myFile2 = [rawdataLoc,fileNames2{kk}];
                
                if isfile(myFile1) && isfile(myFile2)
                    
                    load(myFile1,'SpikeTime','SpikeElectrode');
                    load(myFile2,'thebadchannels');
                    
                    thebadchannels = unique([thebadchannels, 5]);
                    
                    netwData.(thisCond).(thisRecDay)(thisCount).SpikeTime                = SpikeTime;
                    netwData.(thisCond).(thisRecDay)(thisCount).SpikeElectrode           = SpikeElectrode;
                    netwData.(thisCond).(thisRecDay)(thisCount).thebadchannels           = thebadchannels;
                else
                    netwData.(thisCond).(thisRecDay)(thisCount).SpikeTime                = [];
                    netwData.(thisCond).(thisRecDay)(thisCount).SpikeElectrode           = [];
                    netwData.(thisCond).(thisRecDay)(thisCount).thebadchannels           = [];
                end% if ~isempty
                
                allBadChannels = [allBadChannels, thebadchannels];
                
            end %for kk
            
            elec2elim = unique(allBadChannels);
            
            for kk=1:length(recDays)
                
                thisRecDay = recDays{kk};
                
                netwData.(thisCond).(thisRecDay)(thisCount).allBadChannels = elec2elim;
                allBadChannels = elec2elim;
                
                myFile1 = [rawdataLoc,fileNames1{kk}];
                myFile2 = [rawdataLoc,fileNames2{kk}];
                if isfile(myFile1) && isfile(myFile2)
                    
                    checkElecs = netwData.(thisCond).(thisRecDay)(thisCount).SpikeElectrode;
                    checkTime = netwData.(thisCond).(thisRecDay)(thisCount).SpikeTime;
                    
                    rElim = [];
                    for mm=1:length(elec2elim)
                        [r,~] = find(checkElecs==elec2elim(mm));
                        addR = reshape(r,[length(r),1]);
                        rElim = [rElim; addR];
                    end %for mm
                    
                    checkElecs(rElim) = [];
                    checkTime(rElim) = [];
                    
                    % CHECK DISCRETIZING WITH SPIKE MATRIX
                    % IT'S PUTTING 1 where there is a spike, but it should do more?
                    % not necessarily. with bins at 1msec, there shouldn't be 2 spikes in a
                    % timebin...
                    
                    % get binned matrix of spikes from that raw data and save
                    [spikeMatrixList, spikeMatrix, ~] = ...
                        ConvertSpikeTE(checkTime, checkElecs, binsize, raster, [meaNames{jj},'_',recDays{kk}], rawdataLoc);
                    SpikeElectrode = checkElecs;
                    SpikeTime = checkTime;
                    save([rawdataLoc,recDays{kk},'_netwk.mat'],'spikeMatrixList','spikeMatrix',...
                        'SpikeElectrode','SpikeTime','allBadChannels','params','-v7.3');
                    netwData.(thisCond).(thisRecDay)(thisCount).spikeMatrixList        = spikeMatrixList;
                    netwData.(thisCond).(thisRecDay)(thisCount).spikeMatrix            = spikeMatrix;
                    clear checkElecs checkTime spikeMatrixList;
                    
                    % calculate functional correlations and save
                    tic
                    [xcorrMatrix,lagMatrix] = calcElecCorrs_coeff(spikeMatrix,theMaxLag);
                    toc
                    clear spikeMatrix;
                    save([rawdataLoc,recDays{kk},'_netwk.mat'],'xcorrMatrix','lagMatrix','-append');
                    netwData.(thisCond).(thisRecDay)(thisCount).xcorrMatrix            = xcorrMatrix;
                    netwData.(thisCond).(thisRecDay)(thisCount).lagMatrix              = lagMatrix;
                    
                    % efficiency calculations from BCT
                    Eglob = efficiency_wei(xcorrMatrix,0);
                    Eloc = efficiency_wei(xcorrMatrix,2);
                    
                    % E.A. suggested community metrics from BCT
                    [cmntyNames,Q] = community_louvain(xcorrMatrix,1,[],'modularity');
                    nCmnty = length(unique(cmntyNames));
                    
                    save([rawdataLoc,recDays{kk},'_netwk.mat'],'Eglob','Eloc','Q','nCmnty','-append');
                    
                    netwData.(thisCond).(thisRecDay)(thisCount).Eglob          = Eglob;
                    netwData.(thisCond).(thisRecDay)(thisCount).Eloc           = Eloc;
                    netwData.(thisCond).(thisRecDay)(thisCount).nCmnty         = nCmnty;
                    netwData.(thisCond).(thisRecDay)(thisCount).Q              = Q;
                    clear Eglob Eloc nCmnty Q;
                    
                    % FANO FACTOR
                    %(2) Fano factor (FF) -- spikes were binned into 1 sec windows using the
                    %same variable (SpikeTime) as for ISI calculation. So a 300 sec recording
                    %was binned into 300 x 1 sec windows, and the resulting 300x1 vector
                    %contains the spike count during each 1 sec interval. The FF was calculated
                    %by dividing the variance (not standard deviation) of that vector by the
                    %mean. Importantly, this means that the Fano factor is measuring the spike
                    %count variability of the whole population (not the variability of each
                    %individual electrode) since spikes were pooled from all electrodes.
                    binsize_ms = 100; % in msec % changing to 100msec 2021-09-22
                    thespktime = [0:(binsize_ms/1000):totaltime];
                    
                    unqElecs = unique(SpikeElectrode);
                    for qq=1:length(unqElecs)
                        thisElec = unqElecs(qq);
                        elecName = ['elec',num2str(thisElec)];
                        
                        r1 = find(SpikeElectrode==thisElec);
                        elecSpikes = SpikeTime(r1);
                        
                        elecChunkSpikes = zeros(totaltime,1);
                        
                        for ss=1:totaltime
                            [r2,~] = find(elecSpikes>=thespktime(ss) & elecSpikes<thespktime(ss+1));
                            elecChunkSpikes(ss) = size(r2,1);
                        end %for ii
                        
                        theFF = (std(elecChunkSpikes)^2)/mean(elecChunkSpikes);
                        
                        ffData(qq).elecName         = elecName;
                        ffData(qq).theFF            = theFF;
                        ffData(qq).elecSpikes       = elecSpikes;
                        ffData(qq).elecChunkSpikes  = elecChunkSpikes;
                    end %for qq
                    save([rawdataLoc,recDays{kk},'_FFbyElec_100msec.mat'], 'ffData', '-v7.3');
                    clear ffData;
                    
                else
                    
                    netwData.(thisCond).(thisRecDay)(thisCount).Eglob                   = [];
                    netwData.(thisCond).(thisRecDay)(thisCount).Eloc                    = [];
                    netwData.(thisCond).(thisRecDay)(thisCount).nCmnty                  = [];
                    netwData.(thisCond).(thisRecDay)(thisCount).Q                       = [];
                    
                end %if isfile
                
            end %for kk
            
            count.(thisCond) = count.(thisCond) + 1;
        end %if strcmp
    end %for jj
    
end %for ii

save('D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF GLU injury recovery\revision_0g30gonly\data\BGLU_injuryRecovery_netwData.mat','netwData','-v7.3');
network_params_RMonly(theBinSize,theMaxLag);
