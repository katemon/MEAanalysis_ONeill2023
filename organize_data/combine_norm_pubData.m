%% organize and normalize data by MEA
clc; clear all;

normNotes = {}; % *** added 2019-09-03
N = 0;

% *** change each time! *** %
% chooseData = 0; %glu only
% chooseData = 1; %BDNF dose response
chooseData = 2; %glu injury + BDNF recovery
% *** change each time! *** %

if chooseData==0
    dataDir = 'C:\Users\Kate\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE GLU ONLY from home\pubData - all exp\';
    load([dataDir,'pubData_RAW_sepByDsxn.mat'],'byMEA');
    
    totalNumExp = 5;
    recDays = {'div14','div15'};%,'div17'};
    
    count.cond0g = 1; %want to add to the end always
    count.cond30g = 1; %want to add to the end always
    count.cond100g = 1; %want to add to the end always
    count.cond175g = 1; %want to add to the end always
    count.cond250g = 1; %want to add to the end always
elseif chooseData==1
    dataDir = 'C:\Users\Kate\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE BDNF dose response from home\pubData - all exp\';
    load([dataDir,'pubData_RAW_sepByDsxn.mat'],'byMEA');
    
    totalNumExp = 7;
    recDays = {'div07','div10','div17'};
    
    count.cond0B = 1; %want to add to the end always
    count.cond25B = 1; %want to add to the end always
    count.cond50B = 1; %want to add to the end always
elseif chooseData==2
    dataDir = 'C:\Users\Kate\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE GLU BDNF from home\pubData - all exp\';
    load([dataDir,'pubData_RAW_sepByDsxn.mat'],'byMEA');
    
    totalNumExp = 11;
    recDays = {'div14','div15','div17'};
    
    count.cond0g_0b = 1; %want to add to the end always
    count.cond0g_50b = 1; %want to add to the end always
    count.cond30g_0b = 1; %want to add to the end always
    count.cond30g_50b = 1; %want to add to the end always
    count.cond60g_0b = 1; %want to add to the end always
    count.cond60g_50b = 1; %want to add to the end always
else
    disp('chooseData must = 0, 1, or 2');
end %if chooseData

normDay = recDays{1};

for ii=1:totalNumExp
    thisExp = ['exp',num2str(ii)] %display this
    numMEAs = length(byMEA.(thisExp));
    
    for jj=1:numMEAs
        cond = byMEA.(thisExp)(jj).condition;
        thisCond = ['cond',cond];
        thisCount = count.(thisCond);
        
        for kk=1:length(recDays)
            thisRecDay = recDays{kk};
            recDayData = byMEA.(thisExp)(jj).(thisRecDay);
            
            
            % % % INFO
            
            meaData.(thisCond).(thisRecDay)(thisCount).meaName                  = byMEA.(thisExp)(jj).MEAname;
            meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate                 = byMEA.(thisExp)(jj).dsxnDate;
            meaData.(thisCond).(thisRecDay)(thisCount).expNum                   = ii;
            meaData.(thisCond).(thisRecDay)(thisCount).meaNum                   = thisCount;
            meaData.(thisCond).(thisRecDay)(thisCount).thebadchannels           = recDayData.thebadchannels;
            
            
            % % % RAW DATA - SET
            
            meaData.(thisCond).(thisRecDay)(thisCount).spikeRate.raw            = recDayData.spikeRate;
            meaData.(thisCond).(thisRecDay)(thisCount).avgSpikeMag.raw          = recDayData.avgSpikeMag; %if 0 spikes, avgSpikeMag = []
            meaData.(thisCond).(thisRecDay)(thisCount).FF_1secSpike.raw         = recDayData.FF_1secSpike; %if 0 spikes, FF_1secSpike = []
            meaData.(thisCond).(thisRecDay)(thisCount).burstletRate.raw         = recDayData.burstletRate;
            meaData.(thisCond).(thisRecDay)(thisCount).avgBurstletMag.raw       = recDayData.avgBurstletMag; %if 0 burstlets, avgBurstletMag = []
            meaData.(thisCond).(thisRecDay)(thisCount).avgBurstletWidth.raw     = recDayData.avgBurstletWidth; %if 0 burstlets, avgBurstletWidth = []
            meaData.(thisCond).(thisRecDay)(thisCount).avgNumSpikesPerB.raw     = recDayData.avgNumSpikesPerB; %if 0 burstlets, avgNumSpikesPerB = []
            meaData.(thisCond).(thisRecDay)(thisCount).FF_1secBurstlet.raw      = recDayData.FF_1secBurstlet; %if 0 burstlets, FF_1secBurstlet = []
            meaData.(thisCond).(thisRecDay)(thisCount).avgSF.raw                = recDayData.avgSF_raw;
            meaData.(thisCond).(thisRecDay)(thisCount).avgSF_cleaned.raw        = recDayData.avgSF_rawCleaned;
            meaData.(thisCond).(thisRecDay)(thisCount).globalBurstRate.raw      = recDayData.globalBurstRate;
            meaData.(thisCond).(thisRecDay)(thisCount).avgNumBinGB.raw          = recDayData.avgNumBinGB; %if 0 GB, avgNumBinGB = []
            meaData.(thisCond).(thisRecDay)(thisCount).avgGBWidth.raw           = recDayData.avgGBWidth; %if 0 GB, avgGBWidth = []
            
            
            % % % RAW DATA - CHECK
            
            % make sure data with "0" countable things doesn't have any
            % other variables derived from it!
            if recDayData.spikeRate==0
%                 meaData.(thisCond).(thisRecDay)(thisCount).avgSpikeMag.raw   = []; %if 0 spikes, avgSpikeMag = []
%                 meaData.(thisCond).(thisRecDay)(thisCount).FF_1secSpike.raw = []; %if 0 spikes, FF_1secSpike = []
                meaData.(thisCond).(thisRecDay)(thisCount).avgSpikeMag.raw   = 0; %if 0 spikes, avgSpikeMag = 0
                meaData.(thisCond).(thisRecDay)(thisCount).FF_1secSpike.raw = 0; %if 0 spikes, FF_1secSpike = 0

                N = N + 1;
                normNotes{N} = ['RAW data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                    meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                    'spikeRate = 0 on ', thisRecDay, '. Therefore, the RAW data of derived parameters -- ',...
                    'avgSpikeMag = 0 and FF_1secSpike = 0. Refer to data at ',...
                    'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')',' raw.'];
                disp(normNotes{N});
            end %if recDayData.spikeRate
            
            if recDayData.burstletRate==0
%                 meaData.(thisCond).(thisRecDay)(thisCount).avgBurstletMag.raw   = []; %if 0 burstlets, avgBurstletMag = []
%                 meaData.(thisCond).(thisRecDay)(thisCount).avgBurstletWidth.raw = []; %if 0 burstlets, avgBurstletWidth = []
%                 meaData.(thisCond).(thisRecDay)(thisCount).avgNumSpikesPerB.raw = []; %if 0 burstlets, avgNumSpikesPerB = []
%                 meaData.(thisCond).(thisRecDay)(thisCount).FF_1secBurstlet.raw  = []; %if 0 burstlets, FF_1secBurstlet = []
                meaData.(thisCond).(thisRecDay)(thisCount).avgBurstletMag.raw   = 0; %if 0 burstlets, avgBurstletMag = 0
                meaData.(thisCond).(thisRecDay)(thisCount).avgBurstletWidth.raw = 0; %if 0 burstlets, avgBurstletWidth = 0
                meaData.(thisCond).(thisRecDay)(thisCount).avgNumSpikesPerB.raw = 0; %if 0 burstlets, avgNumSpikesPerB = 0
                meaData.(thisCond).(thisRecDay)(thisCount).FF_1secBurstlet.raw  = 0; %if 0 burstlets, FF_1secBurstlet = 0
                
                N = N + 1;
                normNotes{N} = ['RAW data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                    meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                    'burstletRate = 0 on ', thisRecDay, '. Therefore, the RAW data of derived parameters -- ',...
                    'avgBurstletMag = 0, avgBurstletWidth = 0, avgNumSpikesPerB = 0, and FF_1secBurstlet = 0. Refer to data at ',...
                    'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')',' raw.'];
                disp(normNotes{N});
            end %if recDayData.burstletRate
            
            if recDayData.globalBurstRate==0
%                 meaData.(thisCond).(thisRecDay)(thisCount).avgNumBinGB.raw = []; %if 0 GB, avgNumBinGB = []
%                 meaData.(thisCond).(thisRecDay)(thisCount).avgGBWidth.raw  = []; %if 0 GB, avgGBWidth = []
                meaData.(thisCond).(thisRecDay)(thisCount).avgNumBinGB.raw = 0; %if 0 GB, avgNumBinGB = 0
                meaData.(thisCond).(thisRecDay)(thisCount).avgGBWidth.raw  = 0; %if 0 GB, avgGBWidth = 0
                
                N = N + 1;
                normNotes{N} = ['RAW data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                    meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                    'globalBurstRate = 0 on ', thisRecDay, '. Therefore, the RAW data of derived parameters -- '...
                    'avgNumBinGB = 0 and avgNumBinGB = 0. Refer to data at ',...
                    'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')',' raw.'];
                disp(normNotes{N});
            end %if recDayData.globalBurstRate
            
            
            % % % NORM DATA - SET
            
            vars2check = {'spikeRate', 'avgSpikeMag', 'FF_1secSpike', 'burstletRate', 'avgBurstletMag', 'avgBurstletWidth', 'avgNumSpikesPerB', 'FF_1secBurstlet',...
                'avgSF', 'avgSF_cleaned', 'globalBurstRate', 'avgNumBinGB', 'avgGBWidth'};
            
            if kk>1 %only do norm if is not the first day of recording
                for normVar=1:length(vars2check)
                    
                    thisVar = meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).raw; %numerator
                    baselineVar = meaData.(thisCond).(normDay)(thisCount).(vars2check{normVar}).raw; %denomenator
                    
                    alreadyElim = 0;
                    
                    if isempty(thisVar) || isempty(baselineVar) %if either variable = []
                        % []/[] = [] ... []/0 or []/# = [] ... but 0/[] or
                        % #/[] gives an error - this check makes sure every
                        % thing with [] anywhere gives norm = []
%                         meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = [];        
                        
                        if isempty(baselineVar) && ~isempty(thisVar)
                            % baseline only is []
                            % eliminate norm
                            meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = [];
                            
                            alreadyElim = 1;
                            
                            N = N + 1;
                            normNotes{N} = ['data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                                vars2check{normVar}, ' = [] on ', normDay, '. This is a #/[] case... ', ...
                                'Therefore, the normalized version is eliminated (= []). Refer to ',...
                                'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2check{normVar},'.norm'];
                            disp(normNotes{N});
                            
                        elseif ~isempty(baselineVar) && isempty(thisVar)
                            % current var is []
                            % norm = 0
                            meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = 0;
                            
                            N = N + 1;
                            normNotes{N} = ['data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                                vars2check{normVar}, ' = [] on ', thisRecDay, '. This is a []/# case... ', ...
                                'Therefore, the normalized version = 0. Refer to ',...
                                'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2check{normVar},'.norm'];
                            disp(normNotes{N});
                            
                        elseif isempty(baselineVar) && isempty(thisVar)
                            % both are []
                            % norm = []/[] = 1
                            meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = 1;
                            
                            N = N + 1;
                            normNotes{N} = ['data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                                vars2check{normVar}, ' = [] on ', normDay, ' AND on ', thisRecDay, '. This is a []/[] case... ', ...
                                'Therefore, the normalized version = 1. Refer to ',...
                                'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2check{normVar},'.norm'];
                            disp(normNotes{N});
                            
                        end %if isempty()
                    end %if isempty() checking all cases
                        
                        
                    if (~isempty(isnan(thisVar)) && isnan(thisVar)) || (~isempty(isnan(baselineVar)) && isnan(baselineVar))
                        %if either variable = NaN
                        % NaN/NaN... NaN/0... NaN/#... 0/NaN... #/NaN...
%                         meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = [];        
                        
                        if isnan(baselineVar) && ~isnan(thisVar)
                            % baseline only is NaN
                            % eliminate norm
                            if alreadyElim %if alreadyElim==1
                                N = N + 1;
                                normNotes{N} = ['data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                    meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                                    vars2check{normVar}, ' = NaN on ', normDay, '. This is a 0/NaN or #/NaN case... ', ...
                                    'This data point has already been eliminated!!! Refer to ',...
                                    'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2check{normVar},'.norm'];
                                disp(normNotes{N});
                                
                            else %if alreadyElim==0
                                meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = [];
                                
                                alreadyElim = 1;
                                
                                N = N + 1;
                                normNotes{N} = ['data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                    meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                                    vars2check{normVar}, ' = NaN on ', normDay, '. This is a 0/NaN or #/NaN case... ', ...
                                    'Therefore, the normalized version is eliminated (= []). Refer to ',...
                                    'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2check{normVar},'.norm'];
                                disp(normNotes{N});
                            end %if ~alreadyElim
                            
                            N = N + 1;
                            normNotes{N} = ['data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                                vars2check{normVar}, ' = NaN on ', normDay, '. This is a 0/NaN or #/NaN case... ', ...
                                'Therefore, the normalized version is eliminated (= []). Refer to ',...
                                'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2check{normVar},'.norm'];
                            disp(normNotes{N});
                            
                        elseif ~isnan(baselineVar) && isnan(thisVar)
                            % current var is NaN
                            % norm = 0
                            meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = 0;
                            
                            N = N + 1;
                            normNotes{N} = ['data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                                vars2check{normVar}, ' = NaN on ', thisRecDay, '. This is a NaN/# or NaN/0 case... ', ...
                                'Therefore, the normalized version = 0. Refer to ',...
                                'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2check{normVar},'.norm'];
                            disp(normNotes{N});
                            
                        elseif isnan(baselineVar) && isnan(thisVar)
                            % both are NaN
                            % norm = NaN/NaN = 1
                            meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = 1;
                            
                            N = N + 1;
                            normNotes{N} = ['data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                                vars2check{normVar}, ' = NaN on ', normDay, ' AND on ', thisRecDay, '. This is a NaN/NaN case... ', ...
                                'Therefore, the normalized version = 1. Refer to ',...
                                'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2check{normVar},'.norm'];
                            disp(normNotes{N});
                            
                        end %if isnan() 
                    end %if isnan() checking all cases
                    
                    %if ~isempty(thisVar) && ~isempty(baselineVar) for all
                    if ~isempty(thisVar) && thisVar==0 && ~isempty(baselineVar) && baselineVar==0 %0/0 case ... norm = 1
                        % when 0/0, set norm = 1
                        meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = 1;
                        
                        N = N + 1;
                        normNotes{N} = ['data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                            meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                            vars2check{normVar}, ' = 0 on ', normDay, 'and also on ', thisRecDay, '. This is the 0/0 case... ', ...
                            'Therefore, the normalized version of this variable has been set to 1. Refer to ',...
                            'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2check{normVar},'.norm'];
                        disp(normNotes{N});
                        
                    elseif ~isempty(thisVar) && thisVar==0 && ~isempty(baselineVar) && baselineVar>0 %0/# case... norm = raw/baseline
                        % when 0/#, do regular division
                        meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = thisVar/baselineVar;
                        
                        N = N + 1;
                        normNotes{N} = ['data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                            meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                            vars2check{normVar}, ' > 0 on ', normDay, ' and = 0 on ', thisRecDay, '. This is the 0/# case... ', ...
                            'Therefore, the normalized version is the regular divsion (a.k.a. 0). Refer to ',...
                            'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2check{normVar},'.norm'];
                        disp(normNotes{N});
                        
                    elseif ~isempty(baselineVar) && baselineVar==0 && ~isempty(thisVar) && thisVar>0 %#/0 case... norm = []
                        % when #/0, set norm = []
                        meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = [];
                        
                        N = N + 1;
                        normNotes{N} = ['data from ', meaData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                            meaData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, '...', ...
                            vars2check{normVar}, ' = 0 on ', normDay, 'and > 0 on ', thisRecDay, '. This is the #/0 case... ', ...
                            'Therefore, the normalized version is eliminated (= []). Refer to ',...
                            'meaData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2check{normVar},'.norm'];
                        disp(normNotes{N});
                        
                    elseif ~isempty(baselineVar) && baselineVar>0 && ~isempty(thisVar) && thisVar>0 %normal cases
                        meaData.(thisCond).(thisRecDay)(thisCount).(vars2check{normVar}).norm = thisVar/baselineVar;
                        
                    end %if 0 cases and normal case
                    
                end %for normVar
                
            end %if kk
            
            count.(thisCond) = thisCount+1;
            clear recDayData;
            
        end %for kk
        
    end %for jj
    
end %for ii

meaData.meaNormNotes = normNotes;
save([dataDir, 'pubData_RawNorm_sepByCond_final0Tracking.mat'],'meaData');

%% organize and normalize data by ELECTRODE

clc; clear all;

normNotes = {}; % *** added 2019-09-03
N = 0;

% *** change each time! *** %
% chooseData = 0; %glu only
% chooseData = 1; %BDNF dose response
chooseData = 2; %glu injury + BDNF recovery
% *** change each time! *** %

if chooseData==0
    dataDir = 'C:\Users\Kate\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE GLU ONLY from home\pubData - all exp\';
    load([dataDir,'pubData_RAW_sepByDsxn.mat'],'byELEC');
    
    totalNumExp = 5;
    recDays = {'div14','div15'};%,'div17'};
    
    count.cond0g = 1; %want to add to the end always
    count.cond30g = 1; %want to add to the end always
    count.cond100g = 1; %want to add to the end always
    count.cond175g = 1; %want to add to the end always
    count.cond250g = 1; %want to add to the end always
elseif chooseData==1
    dataDir = 'C:\Users\Kate\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE BDNF dose response from home\pubData - all exp\';
    load([dataDir,'pubData_RAW_sepByDsxn.mat'],'byELEC');
    
    totalNumExp = 7;
    recDays = {'div07','div10','div17'};
    
    count.cond0B = 1; %want to add to the end always
    count.cond25B = 1; %want to add to the end always
    count.cond50B = 1; %want to add to the end always
elseif chooseData==2
    dataDir = 'C:\Users\Kate\Dropbox\Rutgers\Firestein Lab\MEA matlab data\REANALYZE GLU BDNF from home\pubData - all exp\';
    load([dataDir,'pubData_RAW_sepByDsxn.mat'],'byELEC');
    
    totalNumExp = 11;
    recDays = {'div14','div15','div17'};
    
    count.cond0g_0b = 1; %want to add to the end always
    count.cond0g_50b = 1; %want to add to the end always
    count.cond30g_0b = 1; %want to add to the end always
    count.cond30g_50b = 1; %want to add to the end always
    count.cond60g_0b = 1; %want to add to the end always
    count.cond60g_50b = 1; %want to add to the end always
else
    disp('chooseData must = 0, 1, or 2');
end %if chooseData

normDay = recDays{1};

for mm=1:totalNumExp
    thisExp = ['exp',num2str(mm)] %display this
    numMEAs = length(byELEC.(thisExp));
    
    for nn=1:numMEAs
        cond = byELEC.(thisExp)(nn).condition;
        thisCond = ['cond',cond];
        thisCount = count.(thisCond);
        
        elec2elim = [byELEC.(thisExp)(nn).(recDays{1}).thebadchannels];
        for qq=2:length(recDays)
            elec2elim = [elec2elim, byELEC.(thisExp)(nn).(recDays{qq}).thebadchannels(5:end)];
        end %for qq
        elec2elim = unique(sort(elec2elim)); %sort and get rid of duplicates
        
        for pp=1:length(recDays)
            thisRecDay = recDays{pp};
            
            recDayData = byELEC.(thisExp)(nn).(thisRecDay);
            
            if isempty(recDayData.spikeArray)
                
                elecData.(thisCond).(thisRecDay)(thisCount).meaName        = byELEC.(thisExp)(nn).MEAname;
                elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate       = byELEC.(thisExp)(nn).dsxnDate;
                elecData.(thisCond).(thisRecDay)(thisCount).expNum         = mm;
                elecData.(thisCond).(thisRecDay)(thisCount).meaNum         = thisCount;
                elecData.(thisCond).(thisRecDay)(thisCount).thebadchannels = [];
                
                elecData.(thisCond).(thisRecDay)(thisCount).spikeRateArray    = [];
                elecData.(thisCond).(thisRecDay)(thisCount).avgSpkMag         = [];
                elecData.(thisCond).(thisRecDay)(thisCount).burstletRateArray = [];
                elecData.(thisCond).(thisRecDay)(thisCount).avgBMag           = [];
                elecData.(thisCond).(thisRecDay)(thisCount).avgBWidth         = [];
                elecData.(thisCond).(thisRecDay)(thisCount).avgSpksInBrsts    = [];
                elecData.(thisCond).(thisRecDay)(thisCount).elecInGB          = [];
                elecData.(thisCond).(thisRecDay)(thisCount).SynchFire         = [];
                
            else %if ~isempty
                
                vars2assign = {'spikeRateArray', 'avgSpkMag', 'burstletRateArray', 'avgBMag', 'avgBWidth', ...
                    'avgSpksInBrsts', 'elecInGB', 'SynchFire' };
                
                elecData.(thisCond).(thisRecDay)(thisCount).meaName        = byELEC.(thisExp)(nn).MEAname;
                elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate       = byELEC.(thisExp)(nn).dsxnDate;
                elecData.(thisCond).(thisRecDay)(thisCount).expNum         = mm;
                elecData.(thisCond).(thisRecDay)(thisCount).meaNum         = thisCount;
                elecData.(thisCond).(thisRecDay)(thisCount).thebadchannels = recDayData.thebadchannels;
                
                for rr=1:length(vars2assign)
                    elecData.(thisCond).(thisRecDay)(thisCount).(vars2assign{rr}).raw                         = recDayData.(vars2assign{rr});
                    elecData.(thisCond).(thisRecDay)(thisCount).(vars2assign{rr}).rawElec                     = [1:1:64]';
                    elecData.(thisCond).(thisRecDay)(thisCount).(vars2assign{rr}).rawCleaned                  = recDayData.(vars2assign{rr});
                    elecData.(thisCond).(thisRecDay)(thisCount).(vars2assign{rr}).rawCleanedElec              = [1:1:64]';
                    elecData.(thisCond).(thisRecDay)(thisCount).(vars2assign{rr}).rawCleanedElec(elec2elim)   = [];
                    if rr==length(vars2assign) %for SynchFire
                        elecData.(thisCond).(thisRecDay)(thisCount).(vars2assign{rr}).rawCleaned(elec2elim,:) = [];
                        elecData.(thisCond).(thisRecDay)(thisCount).(vars2assign{rr}).rawCleaned(:,elec2elim) = [];
                    else
                        elecData.(thisCond).(thisRecDay)(thisCount).(vars2assign{rr}).rawCleaned(elec2elim)   = [];
                    end %if rr
                end %for rr
                
                % eliminate NaNs (0/0) and Infs (#/0)
                
                % % %                     %this section needs to check the raw data; the derived
                % % %                     %vars tend to have NaN in places where they weren't calculated
                % % %                     vars2check = {'avgSpkMag','avgSpksInBrsts','avgBMag','avgBWidth'};
                % % %
                % % %                     for ss=1:length(vars2check)
                % % %                         thisVar = elecData.(thisCond).(thisRecDay)(thisCount).(vars2norm{uu}).rawCleaned;
                % % %                         thisElec = elecData.(thisCond).(thisRecDay)(thisCount).(vars2norm{uu}).rawCleanedElec;
                % % %                     end %for ss
                
                vars2norm = {'spikeRateArray', 'avgSpkMag', 'burstletRateArray', 'avgBMag', 'avgBWidth', ...
                    'avgSpksInBrsts', 'elecInGB', 'SynchFire' };
                % CALCULATE NORM FOR ALL VARIABLES ELEC BY ELEC
                % ALSO CHECK for [] and NaN and 0/0 and #/0 and 0/# cases
                for ss=1:length(vars2norm)
                    
                    if pp>1 %can't do for normDay data
                        
                        if ss<length(vars2norm)
                            thisVar = elecData.(thisCond).(thisRecDay)(thisCount).(vars2norm{ss}).rawCleaned;
                            thisElec = elecData.(thisCond).(thisRecDay)(thisCount).(vars2norm{ss}).rawCleanedElec;
                            
                            baselineVar = elecData.(thisCond).(normDay)(thisCount).(vars2norm{ss}).rawCleaned;
                            baselineElec = elecData.(thisCond).(normDay)(thisCount).(vars2norm{ss}).rawCleanedElec;
                            
                            normVar = zeros(size(thisVar));
                            normElec = zeros(size(thisElec));
                            
                            baselineSpikes = elecData.(thisCond).(normDay)(thisCount).spikeRateArray.rawCleaned;
                            baselineBurstlets = elecData.(thisCond).(normDay)(thisCount).burstletRateArray.rawCleaned;
                            
                            theseSpikes = elecData.(thisCond).(thisRecDay)(thisCount).spikeRateArray.rawCleaned;
                            theseBurstlets = elecData.(thisCond).(thisRecDay)(thisCount).burstletRateArray.rawCleaned;
                            
                            for tt=1:length(thisVar) %check each entry
                                thisVar_indivE = thisVar(tt);
                                thisElec_indivE = thisElec(tt);
                                baselineVar_indivE = baselineVar(tt);
                                
                                checkBaseSpikes = baselineSpikes(tt);
                                checkBaseBurstlets = baselineBurstlets(tt);
                                checkTheseSpikes = theseSpikes(tt);
                                checkTheseBurstlets = theseBurstlets(tt);
                                
                                % alreadyElim = 0; % don't need this
                                % because elimination is done at end by
                                % finding 123456789
                                
                                if isempty(thisVar_indivE) || isempty(baselineVar_indivE) %if either variable = []
                                    % % % * * * % % % 2020-04-23
                                    % also check if spikeRateArray(tt) or burstletRateArray(tt) == 0
                                    % because if so, then can just be 0
                                    % % % * * * % % % 2020-04-23
                                    
                                    % []/[] = [] ... []/0 or []/# = [] ... but 0/[] or
                                    % #/[] gives an error - this check makes sure every
                                    % thing with [] anywhere gives norm = [] (now set
                                    % to 123456789, to be corrected later)
%                                     normVar(tt) = 123456789;
%                                     normElec(tt) = 123456789;
                                    
                                    if isempty(baselineVar_indivE) && ~isempty(thisVar_indivE)
                                        % baseline only is []
                                        % norm = 123456789
                                        normVar(tt) = 123456789;
                                        normElec(tt) = 123456789;
                                        
                                        % check baselineVar values
                                        if checkBaseSpikes==0 && checkBaseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ...
                                                '. This is a [] case due to spikes and burstlets = 0 on ', normDay,...
                                                '... Therefore, this datapoint has been removed from the array. Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkBaseSpikes==0 && checkBaseBurstlets~=0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ...
                                                '. This is a [] case due to spikes = 0 on ', normDay,...
                                                '... Therefore, this datapoint has been removed from the array. Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkBaseSpikes~=0 && checkBaseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ...
                                                '. This is a [] case due to burstlets = 0 on ', normDay,...
                                                '... Therefore, this datapoint has been removed from the array. Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        else % not sure why
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ...
                                                '. This is a [] case... Therefore, this datapoint has been removed from the array. Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        end %if checkBaseSpikes
                                    
                                    elseif isempty(thisVar_indivE) && ~isempty(baselineVar_indivE)
                                        % current var is []
                                        % norm = 0
                                        normVar(tt) = 0;
                                        normElec(tt) = thisElec_indivE;
                                        
                                        % check thisVar values
                                        if checkTheseSpikes==0 && checkTheseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', thisRecDay, ...
                                                '. This is a []/# case due to spikes and burstlets = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 0... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkTheseSpikes==0 && checkTheseBurstlets~=0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', thisRecDay, ...
                                                '. This is a []/# case due to spikes = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 0... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkTheseSpikes~=0 && checkTheseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', thisRecDay, ...
                                                '. This is a []/# case due to burstlets = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 0... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        else % not sure why
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', thisRecDay, ...
                                                '. This is a []/# case. Therefore, the normalized version = 0... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        end %if checkTheseSpikes
                                        
                                    elseif isempty(thisVar_indivE) && isempty(baselineVar_indivE)
                                        % both are []
                                        % norm = []/[] = 1
                                        normVar(tt) = 1;
                                        normElec(tt) = thisElec_indivE;
                                        
                                        % check baselineVar values
                                        if checkBaseSpikes==0 && checkBaseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a []/[] case due to spikes and burstlets = 0 on ', normDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkBaseSpikes==0 && checkBaseBurstlets~=0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a []/[] case due to spikes = 0 on ', normDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkBaseSpikes~=0 && checkBaseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a []/[] case due to burstlets = 0 on ', normDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        else % not sure why
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a []/[] case. Therefore, the normalized version = 1... Refer to ', ...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        end %if checkBaseSpikes
                                        
                                        % check thisVar values
                                        if checkTheseSpikes==0 && checkTheseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a []/[] case due to spikes and burstlets = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkTheseSpikes==0 && checkTheseBurstlets~=0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a []/[] case due to spikes = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkTheseSpikes~=0 && checkTheseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a []/[] case due to burstlets = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        else % not sure why
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = [] on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a []/[] case. Therefore, the normalized version = 1... Refer to ', ...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        end %if checkTheseSpikes
                                    
                                    end %if isempty
                                end %if isempty() checking all cases
                                    
                                    
                                if isnan(thisVar_indivE) || isnan(baselineVar_indivE) %if either variable = NaN
                                    % % % * * * % % % 2020-04-23
                                    % check if spikeRateArray(tt) or burstletRateArray(tt) == 0
                                    % because if so, then can just be 0
                                    % % % * * * % % % 2020-04-23
                                    
                                    % []/[] = [] ... []/0 or []/# = [] ... but 0/[] or
                                    % #/[] gives an error - this check makes sure every
                                    % thing with [] anywhere gives norm = [] (now set
                                    % to 123456789, to be corrected later)
%                                     normVar(tt) = 123456789;
%                                     normElec(tt) = 123456789;

                                    if isnan(baselineVar_indivE) && ~isnan(thisVar_indivE)
                                        % baseline only is NaN
                                        % norm = 12345678
                                        normVar(tt) = 123456789;
                                        normElec(tt) = 123456789;
                                        
                                        % check baselineVar values
                                        if checkBaseSpikes==0 && checkBaseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ...
                                                '. This is a #/NaN case due to spikes and burstlets = 0 on ', normDay,...
                                                '... Therefore, this datapoint has been removed from the array. Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkBaseSpikes==0 && checkBaseBurstlets~=0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ...
                                                '. This is a #/NaN case due to spikes = 0 on ', normDay,...
                                                '... Therefore, this datapoint has been removed from the array. Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkBaseSpikes~=0 && checkBaseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ...
                                                '. This is a #/NaN case due to burstlets = 0 on ', normDay,...
                                                '... Therefore, this datapoint has been removed from the array. Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        else % not sure why
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ...
                                                '. This is a #/NaN case... Therefore, this datapoint has been removed from the array. Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        end %if checkBaseSpikes
                                    
                                    elseif isnan(thisVar_indivE) && ~isnan(baselineVar_indivE)
                                        % current var is NaN
                                        % norm = 0
                                        normVar(tt) = 0;
                                        normElec(tt) = thisElec_indivE;
                                        
                                        % check thisVar values
                                        if checkTheseSpikes==0 && checkTheseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', thisRecDay, ...
                                                '. This is a NaN/# case due to spikes and burstlets = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 0... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkTheseSpikes==0 && checkTheseBurstlets~=0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', thisRecDay, ...
                                                '. This is a NaN/# case due to spikes = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 0... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkTheseSpikes~=0 && checkTheseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', thisRecDay, ...
                                                '. This is a NaN/# case due to burstlets = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 0... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        else % not sure why
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', thisRecDay, ...
                                                '. This is a NaN/# case. Therefore, the normalized version = 0... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        end %if checkTheseSpikes
                                        
                                    elseif isnan(thisVar_indivE) && isnan(baselineVar_indivE)
                                        % both are NaN
                                        % norm = NaN/NaN = 1
                                        normVar(tt) = 1;
                                        normElec(tt) = thisElec_indivE;
                                        
                                        % check baselineVar values
                                        if checkBaseSpikes==0 && checkBaseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a NaN/NaN case due to spikes and burstlets = 0 on ', normDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkBaseSpikes==0 && checkBaseBurstlets~=0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a NaN/NaN case due to spikes = 0 on ', normDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkBaseSpikes~=0 && checkBaseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a NaN/NaN case due to burstlets = 0 on ', normDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        else % not sure why
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a NaN/NaN case. Therefore, the normalized version = 1... Refer to ', ...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        end %if checkBaseSpikes
                                        
                                        % check thisVar values
                                        if checkTheseSpikes==0 && checkTheseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a NaN/NaN case due to spikes and burstlets = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkTheseSpikes==0 && checkTheseBurstlets~=0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a NaN/NaN case due to spikes = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        elseif checkTheseSpikes~=0 && checkTheseBurstlets==0
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a NaN/NaN case due to burstlets = 0 on ', thisRecDay,...
                                                '. Therefore, the normalized version = 1... Refer to ',...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        else % not sure why
                                            N = N + 1;
                                            normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ', ...
                                                elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                                num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = NaN on ', normDay, ' AND on ', thisRecDay, ...
                                                '. This is a NaN/NaN case. Therefore, the normalized version = 1... Refer to ', ...
                                                'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                            disp(normNotes{N});
                                        end %if checkTheseSpikes
                                    
                                    end %if isnan
                                end %if isnan() checking all cases
                                    
                                    
                                if thisVar_indivE==0 && baselineVar_indivE==0 %0/0 case ... norm = 1
                                    % when 0/0, set norm = 1
                                    normVar(tt) = 1;
                                    normElec(tt) = thisElec_indivE;
                                    
                                    N = N + 1;
                                    normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                        elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                        num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = 0 on ', normDay, ' AND on ', thisRecDay, ...
                                        '. This is a 0/0 case... Therefore, this datapoint has been set to = 1. Refer to ',...
                                        'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                    disp(normNotes{N});
                                    
                                    
                                elseif thisVar_indivE==0 && baselineVar_indivE>0 %0/# case... norm = raw/baseline
                                    % when 0/#, do regular division
                                    normVar(tt) = thisVar_indivE / baselineVar_indivE;
                                    normElec(tt) = thisElec_indivE;
                                    
                                    N = N + 1;
                                    normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                        elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                        num2str(thisElec(tt)),'... ', vars2norm{ss}, ' > 0 on ', normDay, ' and = 0 on ', thisRecDay, ...
                                        '. This is the 0/# case... Therefore, the normalized version is the regular divsion (a.k.a. 0). . Refer to ',...
                                        'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                    disp(normNotes{N});
                                    
                                    
                                elseif baselineVar_indivE==0 && thisVar_indivE>0 %#/0 case... norm = []
                                    % when #/0, set norm = [] ... 123456789 to be
                                    % corrected later
                                    normVar(tt) = 123456789;
                                    normElec(tt) = 123456789;
                                    
                                    N = N + 1;
                                    normNotes{N} = ['data from ', elecData.(thisCond).(thisRecDay)(thisCount).dsxnDate, ' of MEA ',...
                                        elecData.(thisCond).(thisRecDay)(thisCount).meaName, ' and condition ', thisCond, ' and electrode ', ...
                                        num2str(thisElec(tt)),'... ', vars2norm{ss}, ' = 0 on ', normDay, ' and > 0 on ', thisRecDay, ...
                                        '. This is the #/0 case... Therefore, this datapoint has been removed from the array. Refer to ',...
                                        'elecData.',thisCond,'.',thisRecDay,'(',num2str(thisCount),')','.',vars2norm{ss},'.normCleaned'];
                                    disp(normNotes{N});
                                    
                                    
                                elseif baselineVar_indivE>0 && thisVar_indivE>0 %normal cases
                                    normVar(tt) = thisVar_indivE / baselineVar_indivE;
                                    normElec(tt) = thisElec_indivE;
                                    
                                end %if ==0 all 0 cases and normal case
                                
                            end %for tt
                            
                            [dp2elim,~] = find(normVar==123456789);
                            normVar(dp2elim) = [];
                            normElec(dp2elim) = [];
                            
                            elecData.(thisCond).(thisRecDay)(thisCount).(vars2norm{ss}).normCleaned = normVar;
                            elecData.(thisCond).(thisRecDay)(thisCount).(vars2norm{ss}).normCleanedElec = normElec;
                            
                        end %if ss<
                        
                    end % if pp
                    
                    %NOW CALCULATE SYNCHFIRE NORM (needs separate checking bc it's
                    % a matrix)
                    if ss==length(vars2norm)
                        
                        currSF = elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.rawCleaned;
                        currElec = elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.rawCleanedElec;
                        
                        baseSF = elecData.(thisCond).(normDay)(thisCount).SynchFire.rawCleaned;
                        baseElec = elecData.(thisCond).(normDay)(thisCount).SynchFire.rawCleanedElec;
                        
                        elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.normMatrix = zeros(size(baseSF));
                        
                        [zeroR,zeroC] = find(baseSF==0);
                        r2elim = [];
                        c2elim = [];
                        for dd=1:length(zeroR)
                            %if this and div07 are both 0, then ==1
                            if currSF(zeroR(dd),zeroC(dd))==0% && baseSF(r2(dd),c2(dd))==0
                                elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.normMatrix(zeroR(dd),zeroC(dd)) = 1;
                            elseif currSF(zeroR(dd),zeroC(dd))~=0% && baseSF(r2(dd),c2(dd))==0
                                r2elim = [r2elim, zeroR(dd)];
                                c2elim = [c2elim, zeroC(dd)];
                                elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.normMatrix(zeroR(dd),zeroC(dd)) = 123456789;
                            end %if curr
                        end %for dd
                        
                        % * * * DOES THIS WORK ? ? ? * * *
                        for ee=1:size(baseSF,1)
                                for ff=1:size(baseSF,2)
                                    if (currSF(ee,ff)/baseSF(ee,ff))<Inf
                                        elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.normMatrix(ee,ff) = currSF(ee,ff)/baseSF(ee,ff);
                                    end %if < Inf
                                end %for ff
                        end %for ee
                        
                        % now you have a matrix of electrodes to
                        % give the electrode pairs
                        SFmatrixElec1 = repmat(currElec,[1 length(currElec)]);%,length(currElec)); %each row is the same
                        SFmatrixElec2 = repmat(currElec',[length(currElec) 1]);%,length(currElec)); %each col is the same
                        elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.SFmatrixElec1 = SFmatrixElec1;
                        elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.SFmatrixElec2 = SFmatrixElec2;
     
                        [xDim,yDim] = size(elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.normMatrix);
                        SFmatrix = elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.normMatrix;
%                         for gg=1:length(r2elim) %can readd as a check
%                             SFmatrix(r2elim(gg),c2elim(gg)) = 123456789;
%                         end %for gg
                        SFarray = reshape(SFmatrix,[xDim*yDim,1]);
                        [sf2elim,~] = find(SFarray==123456789);
                        if isempty(sf2elim) %an extra check
                            disp('nothing to eliminate!');
                        end %if isempty
                        newSFarray = SFarray;
                        newSFarray(sf2elim) = [];
                        elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.normArrayCleaned = newSFarray;
                        
                        SFarrayElec1 = reshape(SFmatrixElec1,[xDim*yDim,1]);
                        SFarrayElec2 = reshape(SFmatrixElec2,[xDim*yDim,1]);
                        newSFarrayElec1 = SFarrayElec1;
                        newSFarrayElec2 = SFarrayElec2;
                        newSFarrayElec1(sf2elim) = [];
                        newSFarrayElec2(sf2elim) = [];
                        
                        elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.normArrayCleanedElec1 = newSFarrayElec1;
                        elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.normArrayCleanedElec2 = newSFarrayElec2;
                        
                    end %if ss
                    
                end %for ss
                
                % % % now that you've gotten to the end of the MEA, do SynchFire
                % categorization!
                % * * * CHECK LATER * * *
                if ~isempty(elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.rawCleaned) % * * * is this necessary?
                    
                    % set once
                    
                    rawBaseSF = elecData.(thisCond).(normDay)(thisCount).SynchFire.rawCleaned; % * * * changed
                    rawCurrSF = elecData.(thisCond).(thisRecDay)(thisCount).SynchFire.rawCleaned;  % * * * changed
                    rawElec1 = elecData.(thisCond).(normDay)(thisCount).SynchFire.SFmatrixElec1;  % * * * changed
                    rawElec2 = elecData.(thisCond).(normDay)(thisCount).SynchFire.SFmatrixElec2;  % * * * changed
                    
                    % % METHOD 1: 0.1 - 0.4, 0.4 - 0.7, 0.7 - 1.0 [used in Kutzing papers]
                    lim1_1 = 0.1;
                    lim2_1 = 0.4;
                    lim3_1 = 0.7;
                    lim4_1 = 1.0;
                    
                    [r14,c14] = find(rawBaseSF>=lim1_1 & rawBaseSF<lim2_1);
                    base14SF = [];
                    curr14SF = [];
                    elec1_14 = [];
                    elec2_14 = [];
                    for group1=1:length(r14) % this finds which ones started between 0.1 and 0.4
                        base14SF = [base14SF; rawBaseSF(r14(group1),c14(group1))]; % * * * make vertical
                        curr14SF = [curr14SF; rawCurrSF(r14(group1),c14(group1))]; % * * * make vertical
                        elec1_14 = [elec1_14; rawElec1(r14(group1),c14(group1))]; % * * * added
                        elec2_14 = [elec2_14; rawElec2(r14(group1),c14(group1))]; % * * * added
                    end %for group1
                    elecData.(thisCond).(normDay)(thisCount).SF14.rawCleaned = base14SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF14.elec1 = elec1_14;
                    elecData.(thisCond).(normDay)(thisCount).SF14.elec2 = elec2_14;
                    
                    [r47,c47] = find(rawBaseSF>=lim2_1 & rawBaseSF<lim3_1);
                    base47SF = [];
                    curr47SF = [];
                    elec1_47 = [];
                    elec2_47 = [];
                    for group2=1:length(r47) % this finds which ones started between 0.1 and 0.4
                        base47SF = [base47SF; rawBaseSF(r47(group2),c47(group2))]; % * * * make vertical
                        curr47SF = [curr47SF; rawCurrSF(r47(group2),c47(group2))]; % * * * make vertical
                        elec1_47 = [elec1_47; rawElec1(r47(group2),c47(group2))]; % * * * added
                        elec2_47 = [elec2_47; rawElec2(r47(group2),c47(group2))]; % * * * added
                    end %for group2
                    elecData.(thisCond).(normDay)(thisCount).SF47.rawCleaned = base47SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF47.elec1 = elec1_47;
                    elecData.(thisCond).(normDay)(thisCount).SF47.elec2 = elec2_47;
                    
                    [r71,c71] = find(rawBaseSF>=lim3_1 & rawBaseSF<lim4_1);
                    base71SF = [];
                    curr71SF = [];
                    elec1_71 = [];
                    elec2_71 = [];
                    for group3=1:length(r71) % this finds which ones started between 0.1 and 0.4
                        base71SF = [base71SF; rawBaseSF(r71(group3),c71(group3))]; % * * * make vertical
                        curr71SF = [curr71SF; rawCurrSF(r71(group3),c71(group3))]; % * * * make vertical
                        elec1_71 = [elec1_71; rawElec1(r71(group3),c71(group3))]; % * * * added
                        elec2_71 = [elec2_71; rawElec2(r71(group3),c71(group3))]; % * * * added
                    end %for group3
                    elecData.(thisCond).(normDay)(thisCount).SF71.rawCleaned = base71SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF71.elec1 = elec1_71;
                    elecData.(thisCond).(normDay)(thisCount).SF71.elec2 = elec2_71;
                    
                    if pp>1
                        elecData.(thisCond).(thisRecDay)(thisCount).SF14.rawCleaned = curr14SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF14.normCleaned = curr14SF./base14SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF14.elec1 = elec1_14;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF14.elec2 = elec2_14;
                        
                        elecData.(thisCond).(thisRecDay)(thisCount).SF47.rawCleaned = curr47SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF47.normCleaned = curr47SF./base47SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF47.elec1 = elec1_47;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF47.elec2 = elec2_47;
                        
                        elecData.(thisCond).(thisRecDay)(thisCount).SF71.rawCleaned = curr71SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF71.normCleaned = curr71SF./base71SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF71.elec1 = elec1_71;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF71.elec2 = elec2_71;
                    end %if pp
                    
                    % % METHOD 2: 0.2 - 0.4, 0.4 - 0.6, 0.6 - 0.8, 0.8 - 1.0 [Kate's idea from thesis]
                    lim1_2 = 0.2;
                    lim2_2 = 0.4;
                    lim3_2 = 0.6;
                    lim4_2 = 0.8;
                    lim5_2 = 1.0;
                    
                    [r24,c24] = find(rawBaseSF>=lim1_2 & rawBaseSF<lim2_2);
                    base24SF = [];
                    curr24SF = [];
                    elec1_24 = [];
                    elec2_24 = [];
                    for group1=1:length(r24) % this finds which ones started between 0.1 and 0.4
                        base24SF = [base24SF; rawBaseSF(r24(group1),c24(group1))]; % * * * make vertical
                        curr24SF = [curr24SF; rawCurrSF(r24(group1),c24(group1))]; % * * * make vertical
                        elec1_24 = [elec1_24; rawElec1(r24(group1),c24(group1))]; % * * * added
                        elec2_24 = [elec2_24; rawElec2(r24(group1),c24(group1))]; % * * * added
                    end %for group1
                    elecData.(thisCond).(normDay)(thisCount).SF24.rawCleaned = base24SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF24.elec1 = elec1_24;
                    elecData.(thisCond).(normDay)(thisCount).SF24.elec2 = elec2_24;
                    
                    [r46,c46] = find(rawBaseSF>=lim2_2 & rawBaseSF<lim3_2);
                    base46SF = [];
                    curr46SF = [];
                    elec1_46 = [];
                    elec2_46 = [];
                    for group2=1:length(r46) % this finds which ones started between 0.1 and 0.4
                        base46SF = [base46SF; rawBaseSF(r46(group2),c46(group2))]; % * * * make vertical
                        curr46SF = [curr46SF; rawCurrSF(r46(group2),c46(group2))]; % * * * make vertical
                        elec1_46 = [elec1_46; rawElec1(r46(group2),c46(group2))]; % * * * added
                        elec2_46 = [elec2_46; rawElec2(r46(group2),c46(group2))]; % * * * added
                    end %for group2
                    elecData.(thisCond).(normDay)(thisCount).SF46.rawCleaned = base46SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF46.elec1 = elec1_46;
                    elecData.(thisCond).(normDay)(thisCount).SF46.elec2 = elec2_46;
                    
                    [r68,c68] = find(rawBaseSF>=lim3_2 & rawBaseSF<lim4_2);
                    base68SF = [];
                    curr68SF = [];
                    elec1_68 = [];
                    elec2_68 = [];
                    for group3=1:length(r68) % this finds which ones started between 0.1 and 0.4
                        base68SF = [base68SF; rawBaseSF(r68(group3),c68(group3))]; % * * * make vertical
                        curr68SF = [curr68SF; rawCurrSF(r68(group3),c68(group3))]; % * * * make vertical
                        elec1_68 = [elec1_68; rawElec1(r68(group3),c68(group3))]; % * * * added
                        elec2_68 = [elec2_68; rawElec2(r68(group3),c68(group3))]; % * * * added
                    end %for group3
                    elecData.(thisCond).(normDay)(thisCount).SF68.rawCleaned = base68SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF68.elec1 = elec1_68;
                    elecData.(thisCond).(normDay)(thisCount).SF68.elec2 = elec2_68;
                    
                    [r81,c81] = find(rawBaseSF>=lim4_2 & rawBaseSF<lim5_2);
                    base81SF = [];
                    curr81SF = [];
                    elec1_81 = [];
                    elec2_81 = [];
                    for group4=1:length(r81) % this finds which ones started between 0.1 and 0.4
                        base81SF = [base81SF; rawBaseSF(r81(group4),c81(group4))]; % * * * make vertical
                        curr81SF = [curr81SF; rawCurrSF(r81(group4),c81(group4))]; % * * * make vertical
                        elec1_81 = [elec1_81; rawElec1(r81(group4),c81(group4))]; % * * * added
                        elec2_81 = [elec2_81; rawElec2(r81(group4),c81(group4))]; % * * * added
                    end %for group4
                    elecData.(thisCond).(normDay)(thisCount).SF81.rawCleaned = base81SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF81.elec1 = elec1_81;
                    elecData.(thisCond).(normDay)(thisCount).SF81.elec2 = elec2_81;
                    
                    if pp>1
                        elecData.(thisCond).(thisRecDay)(thisCount).SF24.rawCleaned = curr24SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF24.normCleaned = curr24SF./base24SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF24.elec1 = elec1_24;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF24.elec2 = elec2_24;
                        
                        elecData.(thisCond).(thisRecDay)(thisCount).SF46.rawCleaned = curr46SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF46.normCleaned = curr46SF./base46SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF46.elec1 = elec1_46;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF46.elec2 = elec2_46;
                        
                        elecData.(thisCond).(thisRecDay)(thisCount).SF68.rawCleaned = curr68SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF68.normCleaned = curr68SF./base68SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF68.elec1 = elec1_68;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF68.elec2 = elec2_68;
                        
                        elecData.(thisCond).(thisRecDay)(thisCount).SF81.rawCleaned = curr81SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF81.normCleaned = curr81SF./base81SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF81.elec1 = elec1_81;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF81.elec2 = elec2_81;
                    end %if pp
                    
                    % % METHOD 3: 0.1 - 0.3, 0.3 - 0.5, 0.5 - 0.7, 0.7 - 0.9, 0.9 - 1.0 [Kate's newest idea]
                    lim1_3 = 0.1;
                    lim2_3 = 0.3;
                    lim3_3 = 0.5;
                    lim4_3 = 0.7;
                    lim5_3 = 0.9;
                    lim6_3 = 1.0;
                    
                    [r13,c13] = find(rawBaseSF>=lim1_3 & rawBaseSF<lim2_3);
                    base13SF = [];
                    curr13SF = [];
                    elec1_13 = [];
                    elec2_13 = [];
                    for group1=1:length(r13) % this finds which ones started between 0.1 and 0.4
                        base13SF = [base13SF; rawBaseSF(r13(group1),c13(group1))]; % * * * make vertical
                        curr13SF = [curr13SF; rawCurrSF(r13(group1),c13(group1))]; % * * * make vertical
                        elec1_13 = [elec1_13; rawElec1(r13(group1),c13(group1))]; % * * * added
                        elec2_13 = [elec2_13; rawElec2(r13(group1),c13(group1))]; % * * * added
                    end %for group1
                    elecData.(thisCond).(normDay)(thisCount).SF13.rawCleaned = base13SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF13.elec1 = elec1_13;
                    elecData.(thisCond).(normDay)(thisCount).SF13.elec2 = elec2_13;
                    
                    [r35,c35] = find(rawBaseSF>=lim2_3 & rawBaseSF<lim3_3);
                    base35SF = [];
                    curr35SF = [];
                    elec1_35 = [];
                    elec2_35 = [];
                    for group2=1:length(r35) % this finds which ones started between 0.1 and 0.4
                        base35SF = [base35SF; rawBaseSF(r35(group2),c35(group2))]; % * * * make vertical
                        curr35SF = [curr35SF; rawCurrSF(r35(group2),c35(group2))]; % * * * make vertical
                        elec1_35 = [elec1_35; rawElec1(r35(group2),c35(group2))]; % * * * added
                        elec2_35 = [elec2_35; rawElec2(r35(group2),c35(group2))]; % * * * added
                    end %for group2
                    elecData.(thisCond).(normDay)(thisCount).SF35.rawCleaned = base35SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF35.elec1 = elec1_35;
                    elecData.(thisCond).(normDay)(thisCount).SF35.elec2 = elec2_35;
                    
                    [r57,c57] = find(rawBaseSF>=lim3_3 & rawBaseSF<lim4_3);
                    base57SF = [];
                    curr57SF = [];
                    elec1_57 = [];
                    elec2_57 = [];
                    for group3=1:length(r57) % this finds which ones started between 0.1 and 0.4
                        base57SF = [base57SF; rawBaseSF(r57(group3),c57(group3))]; % * * * make vertical
                        curr57SF = [curr57SF; rawCurrSF(r57(group3),c57(group3))]; % * * * make vertical
                        elec1_57 = [elec1_57; rawElec1(r57(group3),c57(group3))]; % * * * added
                        elec2_57 = [elec2_57; rawElec2(r57(group3),c57(group3))]; % * * * added
                    end %for group3
                    elecData.(thisCond).(normDay)(thisCount).SF57.rawCleaned = base57SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF57.elec1 = elec1_57;
                    elecData.(thisCond).(normDay)(thisCount).SF57.elec2 = elec2_57;
                    
                    [r79,c79] = find(rawBaseSF>=lim4_3 & rawBaseSF<lim5_3);
                    base79SF = [];
                    curr79SF = [];
                    elec1_79 = [];
                    elec2_79 = [];
                    for group4=1:length(r79) % this finds which ones started between 0.1 and 0.4
                        base79SF = [base79SF; rawBaseSF(r79(group4),c79(group4))]; % * * * make vertical
                        curr79SF = [curr79SF; rawCurrSF(r79(group4),c79(group4))]; % * * * make vertical
                        elec1_79 = [elec1_79; rawElec1(r79(group4),c79(group4))]; % * * * added
                        elec2_79 = [elec2_79; rawElec2(r79(group4),c79(group4))]; % * * * added
                    end %for group4
                    elecData.(thisCond).(normDay)(thisCount).SF79.rawCleaned = base79SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF79.elec1 = elec1_79;
                    elecData.(thisCond).(normDay)(thisCount).SF79.elec2 = elec2_79;
                    
                    [r91,c91] = find(rawBaseSF>=lim5_3 & rawBaseSF<lim6_3);
                    base91SF = [];
                    curr91SF = [];
                    elec1_91 = [];
                    elec2_91 = [];
                    for group5=1:length(r91) % this finds which ones started between 0.1 and 0.4
                        base91SF = [base91SF; rawBaseSF(r91(group5),c91(group5))]; % * * * make vertical
                        curr91SF = [curr91SF; rawCurrSF(r91(group5),c91(group5))]; % * * * make vertical
                        elec1_91 = [elec1_91; rawElec1(r91(group5),c91(group5))]; % * * * added
                        elec2_91 = [elec2_91; rawElec2(r91(group5),c91(group5))]; % * * * added
                    end %for group5
                    elecData.(thisCond).(normDay)(thisCount).SF91.rawCleaned = base91SF; % is this here to make sure it gets set?
                    elecData.(thisCond).(normDay)(thisCount).SF91.elec1 = elec1_91;
                    elecData.(thisCond).(normDay)(thisCount).SF91.elec2 = elec2_91;
                    
                    if pp>1
                        elecData.(thisCond).(thisRecDay)(thisCount).SF13.rawCleaned = curr13SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF13.normCleaned = curr13SF./base13SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF13.elec1 = elec1_13;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF13.elec2 = elec2_13;
                        
                        elecData.(thisCond).(thisRecDay)(thisCount).SF35.rawCleaned = curr35SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF35.normCleaned = curr35SF./base35SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF35.elec1 = elec1_35;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF35.elec2 = elec2_35;
                        
                        elecData.(thisCond).(thisRecDay)(thisCount).SF57.rawCleaned = curr57SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF57.normCleaned = curr57SF./base57SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF57.elec1 = elec1_57;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF57.elec2 = elec2_57;
                        
                        elecData.(thisCond).(thisRecDay)(thisCount).SF79.rawCleaned = curr79SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF79.normCleaned = curr79SF./base79SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF79.elec1 = elec1_79;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF79.elec2 = elec2_79;
                        
                        elecData.(thisCond).(thisRecDay)(thisCount).SF91.rawCleaned = curr91SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF91.normCleaned = curr91SF./base91SF;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF91.elec1 = elec1_91;
                        elecData.(thisCond).(thisRecDay)(thisCount).SF91.elec2 = elec2_91;
                    end %if pp
                    
                end %if ~isempty
                
                count.(thisCond) = thisCount + 1;
                
            end %if isempty
            
            clear recDayData;
        end %for pp
        
    end %for nn
    
end %for mm

elecData.meaNormNotes = normNotes;
save([dataDir, 'pubData_RawNorm_sepByCond+Elec_final0Tracking.mat'],'elecData');


