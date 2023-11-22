% main script for analyzing micro-electrode array (MEA) data %%%%%%%%%%%%%%
% 5/12/2016 combined this main function with GetSpikePoints for feeding %%%
% into WaveClus analysis. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6/16/2021 needed to change the way the raw data was accessed: this %%%%%%
% version (_v1) uses the getraw_uv function while the other version (_v2) %
% uses the datastrm function. You may need to use one or the other %%%%%%%%
% depending on your computer and version of MATLAB. %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc; close all;

store_names = cell(1,1);
store_NAEspike = [];
store_NAEburst = [];
store_NAEspike_Enum = cell(1,1);
store_NAEburst_Enum = cell(1,1);
store_AvgSpikes = [];
store_AvgBursts = [];
store_p75spike = [];
store_p75burst = [];
store_StdSpikes = [];
store_StdBursts = [];
store_avgSF_normNAE = [];
store_TotalSpikesNum_normNAE = [];
store_NumBurstlets_normNAE = [];

% *** things to change with each experiment *** %
% meaNames = {'24131', '24138', '24139', '24140', '24141', '24142', '24143', '24144', '24145', '24146'};
% meaConds = {'25B', '0B', '50B', '0B', '50B', '0B', '25B', '50B', '25B', '25B'};
meaNames = {'24142'; '24143'; '24144'};

NumMEAprompt = {'How many MEAs were used for this experiment?'};
HowManyMEAs = inputdlg(NumMEAprompt);
NumMEAs = str2num(HowManyMEAs{1});

ChunkSize = 10000; %10 sec chunk in msec
% ChunkSize = 1000; %for trial only, 1 sec chunk in msec
for ii=1:NumMEAs
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%% SPECIFY SAVE LOCATION BELOW: %%%%%%%%%%%%%%%%%%%%%
    % %         savelocation = 'Z:\Firestein Lab\Kate\MEA data (backup)\09.03.13 dissection_WholeWell+NbActiv4+Hc\matlab data\';
%     savelocation = 'R:\Firestein Lab\Kate ONeill\Matlab analyzed data\Renalayze STIM DATA\2016 0417 dissection - NbA4 Hc stim\matlab data\';
    savelocation = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\MEA RAW data\REANALYSIS - BDNF GLU DATA\2015 04.22 dissection_NbActiv4 Hc glu BDNF\matlab data\';
    %%%%%%%%%%%%%%%%%%%% SPECIFY SAVE LOCATION ABOVE: %%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %NOTE: it should always end in \matlab data\ -- you need to inlude the
    % last backslash!!!
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % IF YOU LEAVE IT AS ' directory_root = uigetdir; ', THEN YOU HAVE TO
    % SELECT FROM THE BEGINNING WHERE YOU ARE GOING TO EACH TIME. IF YOU
    % ARE ALWAYS GOING TO YOUR EXTERNAL HARD DRIVE, FOR EXAMPLE, PUT '... =
    % uigetdir('D:\FiresteinLab') ' OR SOMETHING SIMILAR.
    % %         directory_root = uigetdir('D:\Firestein Lab\Kate\MEA data (backup)\09.03.13 dissection_WholeWell+NbActiv4+Hc\', 'Choose RAW data MEA directory');
%     directory_root = uigetdir('R:\Firestein Lab\Kate ONeill\MEA data (backup)\STIM DATA\2016 04.17 dissection_NbActiv4 Hc stim\', 'Choose RAW data MEA directory'); %choose directory with particular MEA
    directory_root = uigetdir('C:\Users\Kate\Dropbox\Rutgers\Firestein Lab\AI collab\Kate''s BIC data\2016-11-30 dissection_NbActiv4 Hippo glu BICUC\', 'Choose RAW data MEA directory'); %choose directory with particular MEA;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    directory_props = dir(directory_root);
    FakeSize = size(directory_props,1); %For some reason, there are two empty rows
    directory_props = directory_props(3:FakeSize,1); %so get rid of 'em!
    NumFiles = size(directory_props,1); %Actual number of files
    
    % Prompt for name of MEA
    MEAnameprompt = {'Name of MEA     (NOTE: This must be the same name as the corresponding folder in matlab data)'};
    MEAname = inputdlg(MEAnameprompt);
    myMEA = MEAname{1};
    
    % Pre-allocate
    RawFileNames = cell(NumFiles,1);
    RawFileLocs = cell(NumFiles,1);
    FileNames = cell(NumFiles,1);
    enterbadE = cell(NumFiles*2,1);
    badEanswer = cell(NumFiles,1);
    badEinput = zeros(NumFiles,1);
    spikeinput = cell(NumFiles,1);
    SpikeThresh = zeros(NumFiles,1);
    removechannels = cell(NumFiles,1);
    % Ask for all bad electrodes
    for mm=1:NumFiles
        RawFileNames{mm} = directory_props(mm,1).name;
        RawFileLocs{mm} = strcat(directory_root, '\', RawFileNames{mm,1});
        % Prompt for bad electrodes. Convert them from MCS to Matlab.
        ifbadE{1} = {['Do you need to enter bad electrodes for the file named ', ...
            RawFileNames{mm},' of MEA ', myMEA, '? If yes, enter Y. If no, enter N.']};
        promptifbadE_cell{1} = inputdlg(ifbadE{1});
        promptifbadE_str = promptifbadE_cell{1};
        
        yesorno = strcmpi('Y',promptifbadE_str); %using case insensitive string compare
        if yesorno==1
            enterbadE{mm} = {['Enter bad electrodes for ', RawFileNames{mm},' (NOTE the dummy electrodes 1, 5, 8, 57, and 64 are already included - NO COMMAS!):']};
            badEanswer{mm} = inputdlg(enterbadE{mm});
            badEchannels = badEanswer{mm};
        else %yesorno==0
            badEchannels{1} = '';
        end %if yesorno
        
        if isempty(badEchannels{1})
            badEchannels = '';
            badEinput = str2num(badEchannels);
        elseif length(badEchannels{1}>2)
            badEinput = badEchannels{1};
            badEinput = str2num(badEinput);
        else %just one bad channel
            badEinput = cellfun(@str2num,badEchannels);
        end %if isempty
        badchannels = ConvertMCS2Matlab(badEinput); %1, 5, 8, 57, 64 already included 
        removechannels{mm} = badchannels;
    end %for mm
    
    fs = 20000;
    for jj=1:NumFiles
        [pathstr, name, ext] = fileparts(RawFileLocs{jj,1});
        MyFile = name;
        FileNames{1} = MyFile; %for saving
        
        % Accomodate size of file
        thesize = directory_props(jj).bytes;
        if thesize>705655000 && thesize<1408897000
            totaltime = 300; %5min
        elseif thesize>1408897000 && thesize<4221866000
            totaltime = 600; %10min
        elseif thesize>4221866000 && thesize<5000000000
            totaltime = 1800; %30min; need to split into 10min chunks
        end %if thesize
        
        % Parameters and empty vectors
        h = waitbar(0,'Computing awesomeness...');
        FilteredData = [];
        TotalSpikesNum = 0;
        SpikeTime = [];
        SpikeIter = [];
        SpikeElectrode = [];
        SpikeVoltage = [];
        ChunkSpikes = [];
        ChunkSpikesAll = [];
        wc_SpikeVolts = [];
        wc_SpikeIters = [];
        wc_SpikeTimes = [];
        ElimSpks_total = 0;
        ElimSpks_ALL = [];
        ElimSpks2_total = 0;
        ElimSpks2_ALL = [];
        
        % go through data chunk by chunk
        close(h);
        numits = 0;
        AllThresh = [];
        AllSigma = [];
        
        %                 for zz=1:10000:10001 %for trial only
        %                 zz %for trial only
        for zz=1:ChunkSize:totaltime*1000 %in msec
            Time = [zz,zz+ChunkSize];
            %             Time = [zz,zz+1000]; %for trial only
            DataChunk = getraw_uv(RawFileLocs{jj},Time); %getraw_uv needs msec for input but gives iterations for output
            chunk = (zz-1)/ChunkSize + 1;
            %             chunk = (zz-1)/1000 + 1; %for trial only
            h = waitbar(zz/(totaltime*1000),strcat(['Processing ', int2str(chunk),' of ', int2str(totaltime/10),'...']));
            
            %convert removechannels cell to string
            thebadchannels = removechannels{jj};
            
            % FILTER DATA chunk
            % filterrawdata m-file is same for wc and reg analysis
            [FilteredChunk] = filterrawdata_wc(DataChunk,thebadchannels);
            clear DataChunk; %save memory
            numits = numits + size(FilteredChunk,2);
            
            % GET ADAPTIVE THRESHOLD FROM RAW DATA
            % adaptivethresh m-file is same for wc and reg analysis
            %%% uncomment next 3 lines for adaptive thresholding
            [ThreshAdapt,Sigma_N] = adaptivethresh_wc(FilteredChunk,thebadchannels);
            AllThresh = [AllThresh, ThreshAdapt];
            AllSigma = [AllSigma, Sigma_N];
            
            % GET SPIKES IN THAT CHUNK
            %%% comment next line for adaptive thresholding
            %             [SpikeMag,ChunkSpikes] = findspikesKMF(FilteredChunk,SpikeThresh(jj));
            %%% uncomment next line for adaptive thresholding
            [SpikeTrain] = adaptivefindspikesKMF(FilteredChunk,ThreshAdapt);
            
            % DETERMINE LOCATION/VOLTAGE FOR THAT SPIKE
            % spikepatch m-file is same for wc and reg analysis
            [spikeV, spikeI, spikeE] = spikepatch_wc(SpikeTrain);
            clear SpikeTrain; %save memory
            ChunkSpikes = length(spikeV);
            ChunkSpikesAll = [ChunkSpikesAll, ChunkSpikes];
            
            spikeV_old = spikeV;
            spikeI_old = spikeI;
            spikeE_old = spikeE;
            
            [~,sortedI] = sort(spikeI);
            spikeI = spikeI_old(sortedI);
            spikeE = spikeE_old(sortedI);
            spikeV = spikeV_old(sortedI);
            clear spikeI_old spikeE_old spikeV_old sortedI; %save memory
            
            % GET SPIKE TIME, SPIKE ELECTRODE, AND SPIKE VOLTAGE
            % burst m-file for wc is more involved than for reg analysis
            [pVRange, pIRange, ElimSpks_chunk] = spikewave_wc(ChunkSpikes,...
                RawFileLocs{jj},chunk,FilteredChunk,ChunkSize,spikeI,spikeE,totaltime);
            clear FilteredChunk; %save memory
            
            %These spikes were eliminated because they were too close to
            %the beginning or end of the data chunk.
            ElimSpks_total = ElimSpks_total + ElimSpks_chunk; %if any spikes to eliminate, add them up
            ElimSpks_ALL = [ElimSpks_ALL, ElimSpks_chunk];

            %Check about 2.0 msec deadtime
            [ElimSpks2_chunk, new_spikeI, new_spikeE, new_spikeV, new_pVRange, new_pIRange] = ...
                deadtime_wc(spikeI, spikeE, spikeV, pVRange, pIRange);
            clear spikeI spikeE spikeV pVRange pIRange; %save memory
            
            %These spikes were eliminated because of deadtime (i.e. same
            %spike was detected twice).
            ElimSpks2_total = ElimSpks2_total + ElimSpks2_chunk; %if any spikes to eliminate, add them up
            ElimSpks2_ALL = [ElimSpks2_ALL, ElimSpks2_chunk];
            ChunkSpikes = ChunkSpikes - ElimSpks2_chunk;
            
            % convert and append
            % everything here has no "deadspikes" but might have spikes too
            % close to beginning or end of chunk
            % For (almost all) variables, need to correct for the fact that the iterations and times
            % of the spikes are with respect to the total time within that chunk (2e5 iterations), not
            % the total time of the whole recording (6e6 iterations). Therefore, a correction is introduced.
            % The correction (zz-1)*20 is the same as saying (chunk-1)*ChunkSize*20, which is found in
            % the m-file spikewave.m
            SpikeTime = [SpikeTime; (new_spikeI+((zz-1)*20))./fs]; %convert from iterations to sec
            SpikeIter = [SpikeIter; new_spikeI+((zz-1)*20)]; %iterations of that actual chunk, not just within chunk
            SpikeElectrode = [SpikeElectrode; new_spikeE];
            SpikeVoltage = [SpikeVoltage; new_spikeV];
            wc_SpikeTimes = [wc_SpikeTimes; (new_pIRange+((zz-1)*20))./fs]; % in seconds
            wc_SpikeTimes_msec = wc_SpikeTimes.*1000; %in msec
            wc_SpikeIters = [wc_SpikeIters; new_pIRange+((zz-1)*20)]; %in iterations
            wc_SpikeElecs = SpikeElectrode;
            wc_SpikeVolts = [wc_SpikeVolts; new_pVRange];
            TotalSpikesNum = length(SpikeTime); %TotalSpikesNum + ChunkSpikes is 1 off from length(SpikeTime)???
            
            clear new_spikeI new_spikeE new_spikeV new_pIRange new_pVRange; %save memory
            
            % IF ANY SPIKES TO ELIMINATE (due to beginning or end of chunk), DO IT HERE
            if ElimSpks_total>0
                [r,~] = find(wc_SpikeVolts(:,1)==0);
                ForWC_SpikeVolts = wc_SpikeVolts;
                ForWC_SpikeIters = wc_SpikeIters;
                ForWC_SpikeTimes_matrix = wc_SpikeTimes; %in sec
                ForWC_SpikeTimes_vector = wc_SpikeTimes_msec(:,20); %vector is in msec
                ForWC_SpikeElecs = wc_SpikeElecs;
                ForWC_SpikeVolts(r,:) = [];
                ForWC_SpikeIters(r,:) = [];
                ForWC_SpikeTimes_matrix(r,:) = []; %matrix is in sec
                ForWC_SpikeTimes_vector(r,:) = []; %vector is in msec
                ForWC_SpikeElecs(r,:) = [];
            else
                ForWC_SpikeVolts = wc_SpikeVolts;
                ForWC_SpikeIters = wc_SpikeIters;
                ForWC_SpikeTimes_matrix = wc_SpikeTimes; %matrix is in sec
                ForWC_SpikeTimes_vector = wc_SpikeTimes_msec(:,20); %vector is in msec
                ForWC_SpikeElecs = wc_SpikeElecs;
            end %if ElimSpks
            
            if (((Time(2)-1)/(600*1000))==1)
                AvgVoltage = mean(SpikeVoltage);
                ThreshAvg = mean(AllThresh,2);
                
                spikesave = strcat(savelocation, MEAname{1},'\', MyFile, '_', 'Info1.mat');
                save(spikesave, 'MEAname', 'myMEA', 'MyFile', 'SpikeTime', 'SpikeElectrode', 'SpikeVoltage', ...
                    'SpikeIter', 'TotalSpikesNum', 'thebadchannels', 'ChunkSpikesAll', 'ElimSpks_ALL', 'ElimSpks2_ALL', ...
                    'totaltime', 'numits', 'AllSigma', 'AllThresh', 'AvgVoltage', 'ThreshAvg', 'ElimSpks_total', 'ElimSpks2_total',...
                    'wc_SpikeVolts', 'wc_SpikeIters', 'wc_SpikeTimes', 'wc_SpikeTimes_msec', 'wc_SpikeElecs', ...
                    'ElimSpks_total', 'ElimSpks2_total', 'ForWC_SpikeVolts', 'ForWC_SpikeIters', ...
                    'ForWC_SpikeTimes_matrix', 'ForWC_SpikeTimes_vector', 'ForWC_SpikeElecs');
                
                [pathstr, name, ext] = fileparts(spikesave);
                spikesave2 = strcat(pathstr,'\WF Info\',name,'WF',ext);
                
                spikes = ForWC_SpikeVolts;
                index = ForWC_SpikeTimes_vector;
                save(spikesave2, 'spikes', 'index');
                
                FilteredData = [];
                TotalSpikesNum = 0;
                SpikeTime = [];
                SpikeIter = [];
                SpikeElectrode = [];
                SpikeVoltage = [];
                ChunkSpikes = [];
                ChunkSpikesAll = [];
                wc_SpikeVolts = [];
                wc_SpikeIters = [];
                wc_SpikeTimes = [];
                ElimSpks_total = 0;
                ElimSpks_ALL = [];
                ElimSpks2_total = 0;
                ElimSpks2_ALL = [];
                AllThresh = [];
                AllSigma = [];
                
            elseif (((Time(2)-1)/(600*1000))==2)
                AvgVoltage = mean(SpikeVoltage);
                ThreshAvg = mean(AllThresh,2);
                
                spikesave = strcat(savelocation, MEAname{1},'\', MyFile, '_', 'Info2.mat');
                save(spikesave, 'MEAname', 'myMEA', 'MyFile', 'SpikeTime', 'SpikeElectrode', 'SpikeVoltage', ...
                    'SpikeIter', 'TotalSpikesNum', 'thebadchannels', 'ChunkSpikesAll', 'ElimSpks_ALL', 'ElimSpks2_ALL', ...
                    'totaltime', 'numits', 'AllSigma', 'AllThresh', 'AvgVoltage', 'ThreshAvg', 'ElimSpks_total', 'ElimSpks2_total',...
                    'wc_SpikeVolts', 'wc_SpikeIters', 'wc_SpikeTimes', 'wc_SpikeTimes_msec', 'wc_SpikeElecs', ...
                    'ElimSpks_total', 'ElimSpks2_total', 'ForWC_SpikeVolts', 'ForWC_SpikeIters', ...
                    'ForWC_SpikeTimes_matrix', 'ForWC_SpikeTimes_vector', 'ForWC_SpikeElecs');
                
                [pathstr, name, ext] = fileparts(spikesave);
                spikesave2 = strcat(pathstr,'\WF Info\',name,'WF',ext);
                
                spikes = ForWC_SpikeVolts;
                index = ForWC_SpikeTimes_vector;
                save(spikesave2, 'spikes', 'index');
                
                FilteredData = [];
                TotalSpikesNum = 0;
                SpikeTime = [];
                SpikeIter = [];
                SpikeElectrode = [];
                SpikeVoltage = [];
                ChunkSpikes = [];
                ChunkSpikesAll = [];
                wc_SpikeVolts = [];
                wc_SpikeIters = [];
                wc_SpikeTimes = [];
                ElimSpks_total = 0;
                ElimSpks_ALL = [];
                ElimSpks2_total = 0;
                ElimSpks2_ALL = [];
                AllThresh = [];
                AllSigma = [];
                
            elseif (((Time(2)-1)/(600*1000))==3)
                AvgVoltage = mean(SpikeVoltage);
                ThreshAvg = mean(AllThresh,2);
                
                spikesave = strcat(savelocation, MEAname{1},'\', MyFile, '_', 'Info3.mat');
                save(spikesave, 'MEAname', 'myMEA', 'MyFile', 'SpikeTime', 'SpikeElectrode', 'SpikeVoltage', ...
                    'SpikeIter', 'TotalSpikesNum', 'thebadchannels', 'ChunkSpikesAll', 'ElimSpks_ALL', 'ElimSpks2_ALL', ...
                    'totaltime', 'numits', 'AllSigma', 'AllThresh', 'AvgVoltage', 'ThreshAvg', 'ElimSpks_total', 'ElimSpks2_total',...
                    'wc_SpikeVolts', 'wc_SpikeIters', 'wc_SpikeTimes', 'wc_SpikeTimes_msec', 'wc_SpikeElecs', ...
                    'ElimSpks_total', 'ElimSpks2_total', 'ForWC_SpikeVolts', 'ForWC_SpikeIters', ...
                    'ForWC_SpikeTimes_matrix', 'ForWC_SpikeTimes_vector', 'ForWC_SpikeElecs');
                
                [pathstr, name, ext] = fileparts(spikesave);
                spikesave2 = strcat(pathstr,'\WF Info\',name,'WF',ext);
                
                spikes = ForWC_SpikeVolts;
                index = ForWC_SpikeTimes_vector;
                save(spikesave2, 'spikes', 'index');
                
                FilteredData = [];
                TotalSpikesNum = 0;
                SpikeTime = [];
                SpikeIter = [];
                SpikeElectrode = [];
                SpikeVoltage = [];
                ChunkSpikes = [];
                ChunkSpikesAll = [];
                wc_SpikeVolts = [];
                wc_SpikeIters = [];
                wc_SpikeTimes = [];
                ElimSpks_total = 0;
                ElimSpks_ALL = [];
                ElimSpks2_total = 0;
                ElimSpks2_ALL = [];
                AllThresh = [];
                AllSigma = [];
            end %if Time
            
            % uncomment next four lines if you would like to save each
            % chunk of the filtered data
            % NOTE: This is not recommended as it takes up a lot of space
            % and time.
            %             chunknum = int2str((zz-1)/10000 + 1);
            %             chunksave = strcat('D:\Firestein Lab\MEA Data\021913 dissection\matlab data\', MEAname{1},'\chunks\', MyFile, '_', 'chunk', chunknum, '.mat');
            %             save(chunksave, 'FilteredChunk', 'SpikeThresh', 'ChunkSpikes');
            %FilteredData.(chunkname) = FilteredChunk; %can't save under struct
            %FilteredData = [FilteredData; FilteredChunk]; %CANNOT append horizontally or vertically
            close(h);
            chunk = chunk + 1;
        end %for zz
        
        AvgVoltage = mean(SpikeVoltage);
        ThreshAvg = mean(AllThresh,2);
        
        if totaltime<600
            spikesave = strcat(savelocation, MEAname{1},'\', MyFile, '_', 'Info.mat');
            save(spikesave, 'MEAname', 'myMEA', 'MyFile', 'SpikeTime', 'SpikeElectrode', 'SpikeVoltage', ...
                'SpikeIter', 'TotalSpikesNum', 'thebadchannels', 'ChunkSpikesAll', 'ElimSpks_ALL', 'ElimSpks2_ALL', ...
                'totaltime', 'numits', 'AllSigma', 'AllThresh', 'AvgVoltage', 'ThreshAvg', 'ElimSpks_total', 'ElimSpks2_total', ...
                'wc_SpikeVolts', 'wc_SpikeIters', 'wc_SpikeTimes', 'wc_SpikeTimes_msec', 'wc_SpikeElecs', ...
                'ElimSpks_total', 'ElimSpks2_total', 'ForWC_SpikeVolts', 'ForWC_SpikeIters', ...
                'ForWC_SpikeTimes_matrix', 'ForWC_SpikeTimes_vector', 'ForWC_SpikeElecs');
            
            [pathstr, name, ext] = fileparts(spikesave);
            spikesave2 = strcat(pathstr,'\WF Info\',name,'WF',ext);
            
            spikes = ForWC_SpikeVolts;
            index = ForWC_SpikeTimes_vector;
            save(spikesave2, 'spikes', 'index');   
        end %if totaltime
        
    end %for jj = NumFiles
   
    clear AvgVoltage ThreshAvg;
    
    % LOAD INFO FROM *.MAT FILES FOR FURTHER SPIKE AND BURST ANALYSIS
    matlabdataloc = strcat(savelocation, MEAname{1});
    directory_props = dir(matlabdataloc);
    FakeSize = size(directory_props,1); %For some reason, there are two empty rows
    directory_props = directory_props(3:FakeSize,1); %so get rid of 'em!
    NumFiles = size(directory_props,1); %Actual number of recordings
    
    %pre-allocate
    fileinfo = cell(NumFiles-1,1);
    myfilepath = cell(NumFiles-1,1);
    %goes through all matlab data once to get num bursts and max num bursts
    % UPDATE 6/13/2016: NEED TO DO NUMFILES - 1 BC OF WF INFO FOLDER
    for kk=1:NumFiles-1
        fileinfo{kk,1} = directory_props(kk,1).name;
        myfilename = fileinfo{kk,1};
        %for some reason, the line below occasionally has issues
        % concatenating the correct file path
        myfilepath{kk,1} = strcat(savelocation, MEAname{1}, '\', fileinfo{kk,1});
        load(myfilepath{kk,1}, 'SpikeVoltage', 'SpikeTime', 'SpikeElectrode', 'SpikeIter', ...
            'TotalSpikesNum', 'numits', 'totaltime', 'wc_SpikeElecs', 'wc_SpikeVolts', ...
            'wc_SpikeIters', 'wc_SpikeTimes', 'wc_SpikeTimes_msec', 'ForWC_SpikeVolts', ...
            'ForWC_SpikeIters', 'ForWC_SpikeElecs', 'ForWC_SpikeTimes_matrix', 'ForWC_SpikeTimes_vector');
        
        % COUNT NUMBER OF BURSTS
        % also CALCULATE SYNCHRONY OF FIRING AND # TIMES ELECTRODES FIRE TOGETHER
        %SynchFire is SF in the paper!
        %NumFire is Nxy in the paper!
        [NumBurstlets, ISI_perE, ISI_overall, IBI_perE, IBI_overall, bwidth_iter, bwidth_time, ...
            BBegin_iter, BEnd_iter, burstElectrode, ItersInBurst, VoltsInBurst, TimesInBurst, ...
            NSpikesInBurst, BBegin_allE, BEnd_allE, EFireArray, EFireMatrix, Fc, EBurstMatrix, ...
            EBurstArray, SynchFire, NumFire] = detectbursts(SpikeVoltage, SpikeTime, ...
            SpikeElectrode, SpikeIter, fs, numits, totaltime);
        
        %         BurstletsWidth_time = bwidth_iter./fs; %now it is in sec
        if isempty(bwidth_time)
            AvgBurstletWidth = 0;
        else
            AvgBurstletWidth = mean(bwidth_time);
        end %if isempty
        
        % NEW 9/21/2015 NUMBER OF ACTIVE ELECTRODES
        % SEPARATED BASED ON SPIKING AND BURSTING
        [p75_spike, p75_burst, count_spike, vals_spike, freq_spike, ...
            count_burst, vals_burst, freq_burst, SpikesPerE, std_Spikes, SpikesPerE_1std, ...
            SpikesPerE_2std, BurstsPerE, std_Bursts, BurstsPerE_1std, BurstsPerE_2std] ...
            = get75th(EFireArray, EBurstArray, EFireMatrix, EBurstMatrix, ...
            TotalSpikesNum, NumBurstlets);
        
        [store_NAEspike, store_NAEburst, store_NAEspike_Enum, store_NAEburst_Enum, ...
            NAEspike_Enum, NAEburst_Enum, NAEspike, NAEburst] ...
            = getNAE(p75_spike, p75_burst, EFireArray, EBurstArray, store_NAEspike, ...
            store_NAEburst, store_NAEspike_Enum, store_NAEburst_Enum);
        
        r_keepspk1 = [];
        r_keepspk2 = [];
        r_keepspk3 = [];
        if (max(EFireArray)>1) %&& (NAEspike>=2)
            for nn=1:length(NAEspike_Enum)
                [r_spk1,~] = find(SpikeElectrode==NAEspike_Enum(nn));
                r_keepspk1 = [r_keepspk1; r_spk1];
                [r_spk2,~] = find(wc_SpikeElecs==NAEspike_Enum(nn));
                r_keepspk2 = [r_keepspk2; r_spk2];
                [r_spk3,~] = find(ForWC_SpikeElecs==NAEspike_Enum(nn));
                r_keepspk3 = [r_keepspk3; r_spk3];
            end %for nn
            
            r_keepspk1 = sort(r_keepspk1);
            SpikeElectrode_ActvSpk = SpikeElectrode(r_keepspk1);
            SpikeTime_ActvSpk = SpikeTime(r_keepspk1);
            SpikeIter_ActvSpk = SpikeIter(r_keepspk1);
            SpikeVoltage_ActvSpk = SpikeVoltage(r_keepspk1);
            ISI_perE_ActvSpk = ISI_perE(NAEspike_Enum,:);
            ISI_ActvSpk = SpikeIter_ActvSpk(2:end) - SpikeIter_ActvSpk(1:end-1);
            TotalSpikesNum_ActvSpk = length(r_keepspk1);
            
            r_keepspk2 = sort(r_keepspk2);
            wc_SpikeVolts_ActvSpk = wc_SpikeVolts(r_keepspk2);
            wc_SpikeIters_ActvSpk = wc_SpikeIters(r_keepspk2);
            wc_SpikeTimes_ActvSpk = wc_SpikeTimes(r_keepspk2);
            wc_SpikeTimes_msec_ActvSpk = wc_SpikeTimes_msec(r_keepspk2);
            wc_SpikeElecs_ActvSpk = wc_SpikeElecs(r_keepspk2);
            
            r_keepspk3 = sort(r_keepspk3);
            ForWC_SpikeVolts_ActvSpk = ForWC_SpikeVolts(r_keepspk3,:);
            ForWC_SpikeIters_ActvSpk = ForWC_SpikeIters(r_keepspk3,:);
            ForWC_SpikeTimes_matrix_ActvSpk = ForWC_SpikeTimes_matrix(r_keepspk3,:);
            ForWC_SpikeTimes_vector_ActvSpk = ForWC_SpikeTimes_vector(r_keepspk3,:);
            ForWC_SpikeElecs_ActvSpk = ForWC_SpikeElecs(r_keepspk3,:);
            
        else
            SpikeElectrode_ActvSpk = [];
            SpikeTime_ActvSpk = [];
            SpikeIter_ActvSpk = [];
            SpikeVoltage_ActvSpk = [];
            ISI_perE_ActvSpk = [];
            ISI_ActvSpk = [];
            TotalSpikesNum_ActvSpk = [];
            
            wc_SpikeVolts_ActvSpk = [];
            wc_SpikeIters_ActvSpk = [];
            wc_SpikeTimes_ActvSpk = [];
            wc_SpikeTimes_msec_ActvSpk = [];
            wc_SpikeElecs_ActvSpk = [];
            
            ForWC_SpikeVolts_ActvSpk = [];
            ForWC_SpikeIters_ActvSpk = [];
            ForWC_SpikeTimes_matrix_ActvSpk = [];
            ForWC_SpikeTimes_vector_ActvSpk = [];
            ForWC_SpikeElecs_ActvSpk = [];
            
        end %if ~isempty
        
        r_keepbrst = [];
        if (max(EBurstArray>1)) %&& (NAEburst>=2)
            for pp=1:length(NAEburst_Enum)
                [r_brst,~] = find(burstElectrode==NAEburst_Enum(pp));
                r_keepbrst = [r_keepbrst; r_brst];
            end %for pp
            r_keepbrst = sort(r_keepbrst);
            burstElectrode_ActvBrst = burstElectrode(r_keepbrst);
            NumBurstlets_ActvBrst = length(r_keepbrst);
            BBegin_ActvBrst = BBegin_iter(r_keepbrst);
            BEnd_ActvBrst = BEnd_iter(r_keepbrst);
            BurstletsWidth_ActvBrst = (BEnd_ActvBrst - BBegin_ActvBrst)./fs; %in sec
            AvgBurstletWidth_ActvBrst = mean(BurstletsWidth_ActvBrst);
            ItersInBurst_ActvBrst = ItersInBurst(r_keepbrst);
            VoltsInBurst_ActvBrst = VoltsInBurst(r_keepbrst);
            TimesInBurst_ActvBrst = TimesInBurst(r_keepbrst);
            NSpikesInBurst_ActvBrst = NSpikesInBurst(r_keepbrst);
            IBI_perE_ActvBrst = IBI_perE(NAEburst_Enum,:);
            IBI_ActvBrst = BBegin_ActvBrst(2:end) - BEnd_ActvBrst(1:end-1);
            
        else
            burstElectrode_ActvBrst = [];
            NumBurstlets_ActvBrst = [];
            BBegin_ActvBrst = [];
            BEnd_ActvBrst = [];
            BurstletsWidth_ActvBrst = [];
            AvgBurstletWidth_ActvBrst = [];
            ItersInBurst_ActvBrst = [];
            VoltsInBurst_ActvBrst = [];
            TimesInBurst_ActvBrst = [];
            NSpikesInBurst_ActvBrst = [];
            IBI_perE_ActvBrst = [];
            IBI_ActvBrst = [];
        end %if ~isempty
        
        avgSF = mean(mean(SynchFire,1),2);
        avgSF_normNAE = avgSF/NAEburst;
        
        TotalSpikesNum_normNAE = TotalSpikesNum/NAEspike;
        NumBurstlets_normNAE = NumBurstlets/NAEburst;
        
        % GRAPH AND SAVE AVERAGES, STDEVS, AND HISTOGRAMS
        [~, filename, ~] = fileparts(fileinfo{kk,1});        
        thisname = strcat(MEAname{1},'_',filename);
        thisnameavg = strcat(thisname, ' avg');
        thisnamehist = strcat(thisname, ' hist');
        
        hfigs(1) = figure(1); %Bring Figure to foreground
        t1 = thisnameavg;
        saveas(hfigs(1), [t1 '.fig']) %Matlab .FIG file
        saveas(hfigs(1), [t1 '.tif']) %Standard TIF graphics file (best for web)
        
        hfigs(2) = figure(2); %Bring Figure to foreground
        t2 = thisnamehist;
        saveas(hfigs(2), [t2 '.fig']) %Matlab .FIG file
        saveas(hfigs(2), [t2 '.tif']) %Standard TIF graphics file (best for web)
        
        close(hfigs); %close just these two figures
        
        % CONCATENATE STORE VARIABLES FOR SAVING
        store_names{end+1} = thisname;
        store_AvgSpikes = [store_AvgSpikes; SpikesPerE];
        store_AvgBursts = [store_AvgBursts; BurstsPerE];
        store_p75spike = [store_p75spike; p75_spike];
        store_p75burst = [store_p75burst; p75_burst];
        store_StdSpikes = [store_StdSpikes; std_Spikes];
        store_StdBursts = [store_StdBursts; std_Bursts];
        store_avgSF_normNAE = [store_avgSF_normNAE; avgSF_normNAE];
        store_TotalSpikesNum_normNAE = [store_TotalSpikesNum_normNAE; TotalSpikesNum_normNAE];
        store_NumBurstlets_normNAE = [store_NumBurstlets_normNAE; NumBurstlets_normNAE];
        
        % SAVE, SAVE, SAVE!
        spikesave = myfilepath{kk,1};            
        
        save(spikesave,'p75_spike', 'p75_burst', 'count_spike', 'vals_spike', ...
            'freq_spike', 'count_burst', 'vals_burst', 'freq_burst', 'SpikesPerE', ...
            'std_Spikes', 'SpikesPerE_1std', 'SpikesPerE_2std', 'BurstsPerE', ...
            'std_Bursts', 'BurstsPerE_1std', 'BurstsPerE_2std', 'NAEspike', ...
            'NAEburst', 'NAEspike_Enum', 'NAEburst_Enum', 'avgSF_normNAE', ...
            'TotalSpikesNum_normNAE', 'NumBurstlets_normNAE', ...
            'SpikeElectrode_ActvSpk', 'SpikeTime_ActvSpk', 'SpikeIter_ActvSpk', ...
            'SpikeVoltage_ActvSpk', 'TotalSpikesNum_ActvSpk', 'ISI_perE_ActvSpk', 'ISI_ActvSpk', 'burstElectrode_ActvBrst', ...
            'NumBurstlets_ActvBrst', 'BBegin_ActvBrst', 'BEnd_ActvBrst', 'IBI_perE_ActvBrst', 'IBI_ActvBrst', ...
            'BurstletsWidth_ActvBrst', 'AvgBurstletWidth_ActvBrst', 'ItersInBurst_ActvBrst', ...
            'TimesInBurst_ActvBrst', 'VoltsInBurst_ActvBrst', 'NSpikesInBurst_ActvBrst', ...
            'ForWC_SpikeVolts_ActvSpk', 'ForWC_SpikeIters_ActvSpk', 'ForWC_SpikeTimes_matrix_ActvSpk', ...
            'ForWC_SpikeTimes_vector_ActvSpk', 'ForWC_SpikeElecs_ActvSpk', 'wc_SpikeVolts_ActvSpk', ...
            'wc_SpikeIters_ActvSpk', 'wc_SpikeTimes_ActvSpk', 'wc_SpikeTimes_msec_ActvSpk', ...
            'wc_SpikeElecs_ActvSpk', 'r_keepspk1', 'r_keepspk2', 'r_keepspk3', 'r_keepbrst', '-append');
        
        save(spikesave, 'NumBurstlets', 'ISI_perE', 'ISI_overall', 'IBI_perE', 'IBI_overall', ...
            'bwidth_time', 'bwidth_iter', 'AvgBurstletWidth', 'BBegin_iter', 'BEnd_iter', ...
            'BBegin_allE', 'BEnd_allE', 'EFireMatrix', 'EFireArray', ...
            'ItersInBurst', 'VoltsInBurst', 'TimesInBurst', 'NSpikesInBurst',...
            'burstElectrode', 'fs', 'numits', 'totaltime', 'Fc', ...
            'EBurstMatrix', 'EBurstArray', 'SynchFire', 'avgSF', 'NumFire', '-append');
        
        [pathstr, name, ext] = fileparts(spikesave);
        spikesave2 = strcat(pathstr,'\WF Info\',name,'WF',ext);
        
        spikes_ActvSpk = ForWC_SpikeVolts_ActvSpk;
        index_ActvSpk = ForWC_SpikeTimes_vector_ActvSpk;
        save(spikesave2, 'spikes_ActvSpk', 'index_ActvSpk', '-append');
        
    end %for kk
    
    if ii==NumMEAs
        % save the store_var for everything here !!!
        storesave = strcat(savelocation, MEAname{1},'\', 'MEA', myMEA, '_', 'StoredVars.mat');
        save(storesave, 'store_names', 'store_AvgSpikes', 'store_AvgBursts', ...
            'store_p75spike', 'store_p75burst', 'store_StdSpikes', 'store_StdBursts', ...
            'store_avgSF_normNAE', 'store_TotalSpikesNum_normNAE', 'store_NumBurstlets_normNAE');
    end %if ii
    
end %for ii = NumMEAs