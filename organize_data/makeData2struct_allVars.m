%makeData2struct_allVars.m
clc; clear all; close all;

% recording parameters
fs = 20000;
totalTime = 300; %sec
numIts = totalTime*fs;
totalElecs = 64;

% *** change each time! *** %
% chooseData = 0; %glu only
% chooseData = 1; %BDNF dose response
chooseData = 2; %glu injury + BDNF recovery
% *** change each time! *** %

if chooseData==0 %glu only
    totalNumExp = 5;
    mainDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE GLU ONLY from home';
    otherDirInfo = ' dissection - glu only';
    
elseif chooseData==1 %BDNF dose response
    totalNumExp = 7;
    mainDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE BDNF dose response from home';
    otherDirInfo = ' dissection';
    
elseif chooseData==2 %glu injury + BDNF recovery
    totalNumExp = 11;
    mainDir = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE GLU BDNF from home';
    otherDirInfo = ' dissection - hippo glu BDNF';
    
end %if chooseData

for ii=1:totalNumExp

    if chooseData==0 %glu only
        if ii==1
            expNum = 1;
            meaNames = {'24131', '24139', '24140', '24143', '24144', '24145'};
            meaConds = {'250g', '250g', '175g', '175g', '0g', '0g'};
            dsxnDate = '2014-06-25';
            recDays = {'div14','div15'};%,'div17'};
            fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat'};%, 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat'};%, 'DIV17_Info.mat'};
        elseif ii==2
            expNum = 2;
            meaNames = {'24139', '24141', '24144', '24145'};
            meaConds = {'30g', '100g', '0g', '30g'};
            dsxnDate = '2014-09-15';
            recDays = {'div14','div15'};%,'div17'};
            fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat'};%, 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat'};%, 'DIV17_Info.mat'};
        elseif ii==3
            expNum = 3;
            meaNames = {'I3820', 'I5405', 'I5908'};
            meaConds = {'100g', '175g', '0g'};
            dsxnDate = '2016-06-21';
            recDays = {'div14','div15'};%,'div17'};
            fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat'};%, 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat'};%, 'DIV17_Info.mat'};
        elseif ii==4
            expNum = 4;
            meaNames = {'I2420', 'I3820', 'I5405', 'I5616', 'I5628', 'I5908', 'I6481'};
            meaConds = {'30g', '250g', '100g', '30g', '100g', '250g', '0g'};
            dsxnDate = '2017-02-20';
            recDays = {'div14','div15'};%,'div17'};
            fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat'};%, 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat'};%, 'DIV17_Info.mat'};
        elseif ii==5
            expNum = 5;
            meaNames = {'I2420', 'I5616', 'I5908', 'I6481'};
            meaConds = {'175g', '0g', '30g', '0g'};
            dsxnDate = '2017-03-21';
            recDays = {'div14','div15'};%,'div17'};
            fileNames1 = {'DIV14_NEWinfo.mat', 'DIV15_NEWinfo.mat'};%, 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV14_Info.mat', 'DIV15_Info.mat'};%, 'DIV17_Info.mat'};
        end
        
    elseif chooseData==1 %BDNF dose response
        if ii==1
            expNum = 1;
            meaNames = {'24131', '24138', '24139', '24141', '24142', '24143', '24145', '24146'};
            meaConds = {'50B', '0B', '25B', '0B', '0B', '50B', '50B', '25B'};
            dsxnDate = '2013-10-31';
            recDays = {'div07','div10','div17'};
            fileNames1 = {'DIV7_NEWinfo.mat', 'DIV10_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV7_Info.mat', 'DIV10_Info.mat', 'DIV17_Info.mat'};
        elseif ii==2
            expNum = 2;
            meaNames = {'24138', '24141', '24145'};
            meaConds = {'25B', '25B', '0B'};
            dsxnDate = '2013-12-05';
            recDays = {'div07','div10','div17'};
            fileNames1 = {'DIV7_NEWinfo.mat', 'DIV10_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV7_Info.mat', 'DIV10_Info.mat', 'DIV17_Info.mat'};
        elseif ii==3
            expNum = 3;
            meaNames = {'24131', '24138', '24139', '24140', '24141', '24142', '24143', '24144', '24145', '24146'};
            meaConds = {'50B', '0B', '25B', '25B', '50B', '0B', '25B', '0B', '50B', '50B'};
            dsxnDate = '2015-01-19';
            recDays = {'div07','div10','div17'};
            fileNames1 = {'DIV7_NEWinfo.mat', 'DIV10_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV7_Info.mat', 'DIV10_Info.mat', 'DIV17_Info.mat'};
        elseif ii==4
            expNum = 4;
            meaNames = {'24131', '24138', '24139', '24140', '24141', '24142', '24143', '24144', '24145', '24146'};
            meaConds = {'25B', '25B', '0B', '0B', '25B', '25B', '50B', '50B', '50B', '0B'};
            dsxnDate = '2015-03-26';
            recDays = {'div07','div10','div17'};
            fileNames1 = {'DIV7_NEWinfo.mat', 'DIV10_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV7_Info.mat', 'DIV10_Info.mat', 'DIV17_Info.mat'};
        elseif ii==5
            expNum = 5;
            meaNames = {'24131', '24138', '24139', '24140', '24141', '24142', '24143', '24144', '24145', '24146'};
            meaConds = {'0B', '50B', '0B', '25B', '50B', '0B', '50B', '0B', '25B', '25B'};
            dsxnDate = '2015-06-04';
            recDays = {'div07','div10','div17'};
            fileNames1 = {'DIV7_NEWinfo.mat', 'DIV10_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV7_Info.mat', 'DIV10_Info.mat', 'DIV17_Info.mat'};
        elseif ii==6
            expNum = 6;
            meaNames = {'24131', '24139', '24140', '24141', '24142', '24143', '24146'};
            meaConds = {'50B', '0B', '25B', '0B', '25B', '50B', '25B'};
            dsxnDate = '2015-08-04';
            recDays = {'div07','div10','div17'};
            fileNames1 = {'DIV7_NEWinfo.mat', 'DIV10_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV7_Info.mat', 'DIV10_Info.mat', 'DIV17_Info.mat'};
        elseif ii==7
            expNum = 7;
            meaNames = {'24131', '24138', '24139', '24140', '24141', '24142', '24143', '24144', '24145', '24146'};
            meaConds = {'25B', '0B', '50B', '0B', '50B', '0B', '25B', '50B', '25B', '25B'};
            dsxnDate = '2015-09-15';
            recDays = {'div07','div10','div17'};
            fileNames1 = {'DIV7_NEWinfo.mat', 'DIV10_NEWinfo.mat', 'DIV17_NEWinfo.mat'};
            fileNames2 = {'DIV7_Info.mat', 'DIV10_Info.mat', 'DIV17_Info.mat'};
        end %if ii
        
    elseif chooseData==2 %glu injury + BDNF recovery
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
    end %if chooseData
    
    loadDate = strrep(dsxnDate,'-','');
    saveDir = [mainDir,'\',loadDate,otherDirInfo,'\matlab data\pubData\'];
    
    for jj=1:length(meaNames)
        
        for kk=1:length(recDays)
            
            loadDir = [mainDir,'\',loadDate,otherDirInfo,'\matlab data\',meaNames{jj},'\'];
            
            if exist([loadDir,fileNames1{kk}]) ~= 0
                load([loadDir,fileNames1{kk}]);
                load([loadDir,fileNames2{kk}], 'thebadchannels');
                thebadchannels = [thebadchannels, 5];
                
                %this is what we have already: EFireArray, EFireMatrix,
                %SpikeElectrode, SpikeIter, SpikeTime, SpikeVoltage, TotalSpikesNum
                
                saveDirAll = [saveDir, 'mea', meaNames{jj}, '_',recDays{kk},'_allVars.mat'];
                %now load into organizingPubData and get back everything you need
                [EFireArray, EFireMatrix, NumBurstlets, VoltsInBurst, avgVoltsPerBurst, EBurstMatrix, EBurstArray, bwidth_timeMSEC, AvgBurstletWidth, ...
                    NSpikesInBurst, Fc, burstElectrode, SynchFire, SynchFire_cleaned, FF_1secSpike, FF_1secBurst, NumGlobalBursts, ...
                    globalBursts_Elecs, globalBursts_NumBInGB, globalBursts_AvgNumBInGB, globalBursts_AvgWidth_msec] ...
                    = organizingPubData(SpikeVoltage, SpikeTime, SpikeElectrode, SpikeIter, TotalSpikesNum, numIts, totalTime, fs, thebadchannels, saveDirAll);
                
                %AvgSF needs to take into account the # of electrodes not being used
                
                % raw data for whole MEA
                %         TotalSpikesNum
                avgSpikeMag = mean(abs(SpikeVoltage)); %*** changed 2019-08-27
                %         FF_1secSpike
                %         NumBurstlets
                avgBurstletMag = mean(abs(avgVoltsPerBurst)); %*** changed 2019-08-27
                %         AvgBurstletWidth
                avgNumSpikesPerBurstlet = mean(NSpikesInBurst);
                %         FF_1secBurst
                avgSF_raw = mean(mean(SynchFire,1),2);
                avgSF_rawCleaned = mean(mean(SynchFire_cleaned,1),2);
                %         NumGlobalBursts
                %         globalBursts_AvgNumBInGB
                %         globalBursts_AvgWidth_msec
                
                % saving data
                MEAinfo(jj).MEAname = meaNames{jj};
                MEAinfo(jj).dsxnDate = dsxnDate;
                MEAinfo(jj).expNum = expNum;
                MEAinfo(jj).MEAnum = jj;
                MEAinfo(jj).condition = meaConds{jj};
                
                thisRecDay = recDays{kk};
                MEAinfo(jj).(thisRecDay).numSpikes = TotalSpikesNum;
                MEAinfo(jj).(thisRecDay).spikeRate = TotalSpikesNum/totalTime; %spike/sec
                MEAinfo(jj).(thisRecDay).avgSpikeMag = avgSpikeMag;
                MEAinfo(jj).(thisRecDay).FF_1secSpike = FF_1secSpike;
                MEAinfo(jj).(thisRecDay).numBurstlets = NumBurstlets;
                MEAinfo(jj).(thisRecDay).burstletRate = NumBurstlets/totalTime; %burstlets/sec
                MEAinfo(jj).(thisRecDay).avgBurstletMag = avgBurstletMag;
                MEAinfo(jj).(thisRecDay).avgBurstletWidth = AvgBurstletWidth; %in msec
                MEAinfo(jj).(thisRecDay).avgNumSpikesPerB = avgNumSpikesPerBurstlet;
                MEAinfo(jj).(thisRecDay).FF_1secBurstlet = FF_1secBurst;
                MEAinfo(jj).(thisRecDay).avgSF_raw = avgSF_raw;
                MEAinfo(jj).(thisRecDay).avgSF_rawCleaned = avgSF_rawCleaned;
                MEAinfo(jj).(thisRecDay).numGlobalBursts = NumGlobalBursts;
                MEAinfo(jj).(thisRecDay).globalBurstRate = NumGlobalBursts/totalTime;
                MEAinfo(jj).(thisRecDay).avgNumBinGB = globalBursts_AvgNumBInGB;
                MEAinfo(jj).(thisRecDay).avgGBWidth = globalBursts_AvgWidth_msec;
                MEAinfo(jj).(thisRecDay).thebadchannels = thebadchannels;
                
                
                % raw data for per electrode basis
                %             EFireArray
                %             EFireMatrix
                %             EBurstArray
                %             EBurstMatrix
                %             SynchFire
                voltsInSpikes_byElec = cell(totalElecs,1);
                avgVoltsInSpikes_byElec = zeros(totalElecs,1);
                timesOfSpikes_byElec = cell(totalElecs,1);
                voltsInBurst_byElec = cell(totalElecs,1);
                avgVoltsPerBurst_byElec = zeros(totalElecs,1);
                bwidthT_byElec = cell(totalElecs,1);
                avgBwidthT_byElec = zeros(totalElecs,1);
                numSpksInBrst_byElec = cell(totalElecs,1);
                avgNumSpksInBrst_byElec = zeros(totalElecs,1);
                elecInGB_byElec = zeros(totalElecs,1);
                for aa=1:totalElecs
                    
                    [Selec,~] = find(SpikeElectrode==aa);
                    spkVolts = [];
                    spkTimes = [];
                    for bb=1:length(Selec)
                        spkVolts = [spkVolts; SpikeVoltage(Selec(bb))];
                        spkTimes = [spkTimes; SpikeTime(Selec(bb))];
                    end %for bb
                    voltsInSpikes_byElec{aa} = spkVolts;
                    avgVoltsInSpikes_byElec(aa) = mean(abs(spkVolts));
                    timesOfSpikes_byElec{aa} = spkTimes;
                    
                    [Belec,~] = find(burstElectrode==aa); %this gives the rows where the data for this electrode is
                    brstVolts = [];
                    brstTimes = [];
                    nSpkBrst = [];
                    for cc=1:length(Belec)
                        brstVolts = [brstVolts; VoltsInBurst{Belec(cc)}];
                        brstTimes = [brstTimes; bwidth_timeMSEC(Belec(cc))];
                        nSpkBrst = [nSpkBrst; NSpikesInBurst(Belec(cc))];
                    end %for cc
                    voltsInBurst_byElec{aa} = brstVolts;
                    avgVoltsPerBurst_byElec(aa) = mean(abs(brstVolts));  %*** changed 2019-08-27
                    bwidthT_byElec{aa} = brstTimes;
                    avgBwidthT_byElec(aa) = mean(brstTimes);
                    numSpksInBrst_byElec{aa} = nSpkBrst;
                    avgNumSpksInBrst_byElec(aa) = mean(nSpkBrst);
                    
                    for dd=1:NumGlobalBursts
                        if ~isempty(find(globalBursts_Elecs{dd}==aa))
                            elecInGB_byElec(aa) = elecInGB_byElec(aa) + 1;
                        end %if ~isempty
                    end %for dd
                    
                end %for aa
                
                % saving data
                ELECinfo(jj).MEAname = meaNames{jj};
                ELECinfo(jj).dsxnDate = dsxnDate;
                ELECinfo(jj).expNum = expNum;
                ELECinfo(jj).MEAnum = jj;
                ELECinfo(jj).condition = meaConds{jj};
                
                thisRecDay = recDays{kk};
                ELECinfo(jj).(thisRecDay).spikeArray = EFireArray'; %make all vars vertical
                ELECinfo(jj).(thisRecDay).spikeRateArray = EFireArray'./totalTime; %make all vars vertical
                ELECinfo(jj).(thisRecDay).spikeMatrix = EFireMatrix;
                ELECinfo(jj).(thisRecDay).spikeRateMatrix = EFireMatrix./totalTime;
                ELECinfo(jj).(thisRecDay).allSpkVolts = voltsInSpikes_byElec;
                ELECinfo(jj).(thisRecDay).avgSpkMag = avgVoltsInSpikes_byElec;
                ELECinfo(jj).(thisRecDay).allSpkTimes = timesOfSpikes_byElec;
                ELECinfo(jj).(thisRecDay).burstletArray = EBurstArray'; %make all vars vertical
                ELECinfo(jj).(thisRecDay).burstletRateArray = EBurstArray'./totalTime; %make all vars vertical
                ELECinfo(jj).(thisRecDay).burstletMatrix = EBurstMatrix;
                ELECinfo(jj).(thisRecDay).burstletRateMatrix = EBurstMatrix./totalTime;
                ELECinfo(jj).(thisRecDay).allBVolts = voltsInBurst_byElec;
                ELECinfo(jj).(thisRecDay).avgBMag = avgVoltsPerBurst_byElec;
                ELECinfo(jj).(thisRecDay).allBWidths = bwidthT_byElec;
                ELECinfo(jj).(thisRecDay).avgBWidth = avgBwidthT_byElec;
                ELECinfo(jj).(thisRecDay).allSpksInBrsts = numSpksInBrst_byElec;
                ELECinfo(jj).(thisRecDay).avgSpksInBrsts = avgNumSpksInBrst_byElec;
                ELECinfo(jj).(thisRecDay).SynchFire = SynchFire;
                ELECinfo(jj).(thisRecDay).SynchFire_cleaned = SynchFire_cleaned;
                ELECinfo(jj).(thisRecDay).elecInGB = elecInGB_byElec;
                ELECinfo(jj).(thisRecDay).thebadchannels = thebadchannels;
                
            else
                % whole MEA basis
                MEAinfo(jj).MEAname = meaNames{jj};
                MEAinfo(jj).dsxnDate = dsxnDate;
                MEAinfo(jj).expNum = expNum;
                MEAinfo(jj).MEAnum = jj;
                MEAinfo(jj).condition = meaConds{jj};
                
                thisRecDay = recDays{kk};
                MEAinfo(jj).(thisRecDay).numSpikes = [];
                MEAinfo(jj).(thisRecDay).spikeRate = [];
                MEAinfo(jj).(thisRecDay).avgSpikeMag = [];
                MEAinfo(jj).(thisRecDay).FF_1secSpike = [];
                MEAinfo(jj).(thisRecDay).numBurstlets = [];
                MEAinfo(jj).(thisRecDay).burstletRate = [];
                MEAinfo(jj).(thisRecDay).avgBurstletMag = [];
                MEAinfo(jj).(thisRecDay).avgBurstletWidth = [];
                MEAinfo(jj).(thisRecDay).avgNumSpikesPerB = [];
                MEAinfo(jj).(thisRecDay).FF_1secBurstlet = [];
                MEAinfo(jj).(thisRecDay).avgSF_raw = [];
                MEAinfo(jj).(thisRecDay).avgSF_rawCleaned = [];
                MEAinfo(jj).(thisRecDay).numGlobalBursts = [];
                MEAinfo(jj).(thisRecDay).globalBurstRate = [];
                MEAinfo(jj).(thisRecDay).avgNumBinGB = [];
                MEAinfo(jj).(thisRecDay).avgGBWidth = [];
                MEAinfo(jj).(thisRecDay).thebadchannels = [];
                
                % per electrode basis
                ELECinfo(jj).MEAname = meaNames{jj};
                ELECinfo(jj).dsxnDate = dsxnDate;
                ELECinfo(jj).expNum = expNum;
                ELECinfo(jj).MEAnum = jj;
                ELECinfo(jj).condition = meaConds{jj};
                
                thisRecDay = recDays{kk};
                ELECinfo(jj).(thisRecDay).spikeArray = [];
                ELECinfo(jj).(thisRecDay).spikeRateArray = [];
                ELECinfo(jj).(thisRecDay).spikeMatrix = [];
                ELECinfo(jj).(thisRecDay).spikeRateMatrix = [];
                ELECinfo(jj).(thisRecDay).allSpkVolts = [];
                ELECinfo(jj).(thisRecDay).avgSpkMag = [];
                ELECinfo(jj).(thisRecDay).allSpkTimes = [];
                ELECinfo(jj).(thisRecDay).burstletArray = [];
                ELECinfo(jj).(thisRecDay).burstletRateArray = [];
                ELECinfo(jj).(thisRecDay).burstletMatrix = [];
                ELECinfo(jj).(thisRecDay).burstletRateMatrix = [];
                ELECinfo(jj).(thisRecDay).allBVolts = [];
                ELECinfo(jj).(thisRecDay).avgBMag = [];
                ELECinfo(jj).(thisRecDay).allBWidths = [];
                ELECinfo(jj).(thisRecDay).avgBWidth = [];
                ELECinfo(jj).(thisRecDay).allSpksInBrsts = [];
                ELECinfo(jj).(thisRecDay).avgSpksInBrsts = [];
                ELECinfo(jj).(thisRecDay).SynchFire = [];
                ELECinfo(jj).(thisRecDay).SynchFire_cleaned = [];
                ELECinfo(jj).(thisRecDay).elecInGB = [];
                ELECinfo(jj).(thisRecDay).thebadchannels = [];
                
            end %if exist
            
        end %for kk
        
    end %for jj
    
    %save!!!!!!!!!!!
    saveDirPub = [saveDir, 'dsxn', loadDate, '_pubVars.mat'];
    save(saveDirPub, 'MEAinfo', 'ELECinfo');
    
    expName = ['exp',num2str(ii)];
    byMEA.(expName) = MEAinfo;
    byELEC.(expName) = ELECinfo;
    
    clear MEAinfo ELECinfo
    
end %for ii
save([mainDir,'\','\pubData - all exp\pubData_RAW_sepByDsxn.mat'], 'byELEC', 'byMEA');

