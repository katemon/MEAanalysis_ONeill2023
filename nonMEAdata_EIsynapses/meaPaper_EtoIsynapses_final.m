%% part 1 - image processing

clc; clear all; close all;

overallFolder = 'D:\kate_dropbox\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\submission materials\3_Comms Biol\2_revision\from Srini\';
inputFolder = [overallFolder, 'exportedTIFs\'];
sumfigsFolder = [overallFolder,'results\summaryFigs\'];
imdataFolder = [overallFolder, 'results\imageData\'];

theExps = {'A','B','C'};
theConds = {'0g0B','0g50B','30g0B','30g50B'};
theCGs = [2, 2, 3]; % # coverglasses for each experiment
numIms = 4; % # images per coverglass

for ii=1:length(theExps)
    
    thisExp = theExps{ii};
    numCGs = theCGs(ii);
    
    for jj=1:length(theConds)
        
        thisCond = theConds{jj};
        
        for kk=1:numCGs
            
            thisCG = ['coverglass',num2str(kk)];
            
            for mm=1:numIms
                
                thisIm = ['im',num2str(mm)];
                
                tifName = [thisExp,'_',thisCond,'_',thisCG,'_',thisIm];
                disp(tifName);
                disp('');
                
                % load each channel
                ch1 = imread([inputFolder,'C1-',tifName,'.tif']); % dapi
                ch2 = imread([inputFolder,'C2-',tifName,'.tif']); % gad67
                ch3 = imread([inputFolder,'C3-',tifName,'.tif']); % map2
                ch4 = imread([inputFolder,'C4-',tifName,'.tif']); % vglut1
                
                % optional - view all channels
                figure; set(gcf, 'Position', get(0,'ScreenSize'));
                subplot(2,2,1); imagesc(ch1); colorbar; title('DAPI'); axis off; axis equal; axis tight;
                subplot(2,2,2); imagesc(ch2); colorbar; title('GAD67'); axis off; axis equal; axis tight;
                subplot(2,2,3); imagesc(ch3); colorbar; title('MAP2'); axis off; axis equal; axis tight;
                subplot(2,2,4); imagesc(ch4); colorbar; title('vGLUT1'); axis off; axis equal; axis tight;
                saveas(gcf, [sumfigsFolder,tifName,'.png']);
                close(gcf);
                
                
                %% % % % segment GAD67 channel (ch2)
                sig_ch2 = 1;
                params.sig_ch2 = sig_ch2;
                
                ch2_filt = imgaussfilt(ch2,sig_ch2); % gaussian filter
                ch2_bw = imbinarize(ch2_filt, 'adaptive');
                
                ch2_mask = bwareafilt(ch2_bw,[10 200]); % seems okay for now
                finalIms.ch2 = ch2_mask;
                
                
                %% % % % segment MAP2 channel (ch3)
                % filter parameters
                filSig = [12, 3];
                numSig = 3;
                numAng = 30;
                mult_ch3 = 0.05;
                params.filSig = filSig;
                params.numSig = numSig;
                params.numAng = numAng;
                params.mult_ch3 = mult_ch3;
                
                [ch3_prefAng, ch3_filIm, ~, ch3_mask] = fft_LoG(filSig, numSig, numAng, mult_ch3, ch3); %%%
                ch3_bwMask = bwareafilt(ch3_mask,[200 1376256]); % the upper limit is  arbitrary
                % % % could do below to get rid of badly segmented areas
                %                 figure;
                %                 stdFilIm = std(filIm,0,3);
                %                 subplot(1,2,1); imagesc(stdFilIm); colorbar;
                %                 theMask = stdFilIm<5 & stdFilIm>0.5;
                %                 newFilIm = filIm.*repmat(theMask,[1 1 size(filIm,3)]);
                %                 subplot(1,2,2); imagesc(max(newFilIm,[],3)); colorbar;
                % % % could do above to get rid of badly segmented areas
                
                sz_ch3 = 8;
                se_ch3 = strel('disk',sz_ch3);
                params.sz_ch3 = sz_ch3;
                params.se_ch3 = se_ch3;
                
                ch3_dilMask = imdilate(ch3_bwMask,se_ch3);
                finalIms.ch3 = ch3_dilMask;
                
                
                %% % % % segment VGLUT1 channel (ch4)
                sig1_ch4 = 5;
                params.sig1_ch4 = sig1_ch4;
                
                ch4_filt = imgaussfilt(ch4,sig1_ch4); % gaussian filter with large circle
                
                ch4_bgSub = ch4 - ch4_filt;
                
                sig2_ch4 = 1;
                params.sig2_ch4 = sig2_ch4;
                
                ch4_bgSub_filt = imgaussfilt(ch4_bgSub,sig2_ch4); % gaussian filter with small circle
                
                upperMult_ch4 = 20;
                lowerMult_ch4 = 10;
                params.upperMult_ch4 = upperMult_ch4;
                params.lowerMult_ch4 = lowerMult_ch4;
                
                upperThr_ch4 = upperMult_ch4*mean(mean(ch4_bgSub_filt));
                lowerThr_ch4 = lowerMult_ch4*mean(mean(ch4_bgSub_filt));
                params.upperThr_ch4 = upperThr_ch4;
                params.lowerThr_ch4 = lowerThr_ch4;
                
                ch4_bin = ch4_bgSub_filt>=lowerThr_ch4 & ch4_bgSub_filt<=upperThr_ch4;
                ch4_filled = imfill(ch4_bin,'holes');
                
                se_ch4 = strel('disk',1);
                params.se_ch4 = se_ch4;
                
                ch4_erd = imerode(ch4_filled,se_ch4);
                ch4_dil = imdilate(ch4_erd,se_ch4);
                ch4_bw = bwareafilt(ch4_dil,[6 61]);
                
                stats_ch4 = regionprops(ch4_bw,'eccentricity');
                params.stats_ch4 = stats_ch4;
                
                finalIms.ch4 = ch4_bw;
                
                
                %% % % % summary figures
                figure; set(gcf, 'Position', get(0,'ScreenSize'));
                subplot(1,3,1); imagesc(ch2); axis equal; axis tight; axis off; title('gad67 - raw'); xlim([0 1024]); ylim([0 1344]);
                subplot(1,3,2); imagesc(ch2_filt); axis equal; axis tight; axis off; title('filtered w/ small circle'); xlim([0 1024]); ylim([0 1344]);
                subplot(1,3,3); imagesc(ch2_mask); axis equal; axis tight; axis off; title('binarized - adaptive threshold + circles of certain size'); xlim([0 1024]); ylim([0 1344]);
                saveas(gcf, [sumfigsFolder,'segmentGAD67_',tifName,'.png']);
                close(gcf);
                
                figure; set(gcf, 'Position', get(0,'ScreenSize'));
                subplot(1,3,1); imagesc(ch4); axis equal; axis tight; axis off; title('vglut1 - raw'); xlim([0 1024]); ylim([0 1344]);
                subplot(1,3,2); imagesc(ch4_bgSub_filt); axis equal; axis tight; axis off; title('background subtracted + circles of certain size'); xlim([0 1024]); ylim([0 1344]);
                subplot(1,3,3); imagesc(ch4_bw); axis equal; axis tight; axis off; title('erode, dil, bin w/ max & min thr'); xlim([0 1024]); ylim([0 1344]);
                saveas(gcf, [sumfigsFolder,'segmentVGLUT1_',tifName,'.png']);
                close(gcf);
                
                figure; set(gcf, 'Position', get(0,'ScreenSize'));
                subplot(1,2,1); imshowpair(ch3_dilMask, finalIms.ch2); axis equal; axis tight; axis off; title('dilated MAP2 (green) + gad67 (pink)');
                subplot(1,2,2); imshowpair(ch3_dilMask, finalIms.ch4); axis equal; axis tight; axis off; title('dilated MAP2 (green) + vglut1 (pink)');
                saveas(gcf, [sumfigsFolder,'segmentALL_',tifName,'.png']);
                close(gcf);
                
                params.overallFolder = overallFolder;
                params.inputFolder = inputFolder;
                params.sumfigsFolder = sumfigsFolder;
                params.imdataFolder = imdataFolder;
                params.theExps = theExps;
                params.theConds = theConds;
                params.theCGs = theCGs;
                params.numIms = numIms;
                params.thisExp = thisExp;
                params.thisCond = thisCond;
                params.numCGs = numCGs;
                params.thisCG = thisCG;
                params.tifName = tifName;
                
                save([imdataFolder,tifName,'.mat'], 'ch1', 'ch2', 'ch3', 'ch4', 'params', ...
                    'ch2_filt', 'ch2_bw', 'ch2_mask', 'ch3_prefAng', 'ch3_filIm', ...
                    'ch3_mask', 'ch3_bwMask', 'ch3_dilMask', 'ch4_filt', 'ch4_bgSub', ...
                    'ch4_bgSub_filt', 'ch4_bin', 'ch4_filled', 'ch4_bw', 'ch4_erd', 'ch4_dil', 'finalIms', '-v7.3');
                
            end %for mm
        end %for kk
    end %for jj
end %for ii


%% part 2 - counting E and I synapses

clc; clear all; close all;

overallFolder = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\submission materials\3_Comms Biol\2_revision\from Srini\';
dataFolder = [overallFolder, 'results\imageData\'];

theExps = {'A','B','C'};
theConds = {'0g0B','0g50B','30g0B','30g50B'};
theCGs = [2, 2, 3]; % # coverglasses for each experiment
numIms = 4; % # images per coverglass

ppm = 14.4012; % # pixels per micron

for ii=1:length(theExps)
    
    thisExp = theExps{ii};
    numCGs = theCGs(ii);
    
    for jj=1:length(theConds)
        
        thisCond = theConds{jj};
        
        for kk=1:numCGs
            
            thisCG = ['coverglass',num2str(kk)];
            
            for mm=1:numIms
                
                thisIm = ['im',num2str(mm)];
                
                tifName = [thisExp,'_',thisCond,'_',thisCG,'_',thisIm];
                disp(tifName);
                disp('');
                
                load([dataFolder,tifName,'.mat'], 'finalIms', 'ch3_bwMask', 'params');
                
                params.ppm = ppm;
                
                Emask = finalIms.ch3 .* finalIms.ch4; % MAP2 channel * VGLUT1 channel
                Imask = finalIms.ch3 .* finalIms.ch2; % MAP2 channel * GAD67 channel
                
                ccE = bwconncomp(logical(Emask));
                ccI = bwconncomp(logical(Imask));
                
                numE = ccE.NumObjects;
                numI = ccI.NumObjects;
                
                ratioEI = numE/numI;
                
                percE = numE/(numE+numI);
                percI = numI/(numE+numI);
                
                ch3_skel = bwskel(ch3_bwMask);
                ch3_numPix = sum(sum(ch3_skel));
                ch3_um = ch3_numPix/ppm;
                
                numEperUM = numE/ch3_um;
                numIperUM = numI/ch3_um;
                
                EtoIdata.Emask = Emask;
                EtoIdata.ccE = ccE;
                EtoIdata.numE = numE;
                EtoIdata.percE = percE;
                EtoIdata.numEperUM = numEperUM;
                EtoIdata.Imask = Imask;
                EtoIdata.ccI = ccI;
                EtoIdata.numI = numI;
                EtoIdata.percI = percI;
                EtoIdata.numIperUM = numIperUM;
                EtoIdata.ratioEI = ratioEI;
                
                save([dataFolder,tifName,'.mat'], 'EtoIdata', 'ch3_skel', ...
                    'ch3_numPix', 'ch3_um', 'params', '-append');
                
            end %for mm
        end %for kk
    end %for jj
end %for ii


%% part 3 - concatenate data

clc; clear all; close all;

overallFolder = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\submission materials\3_Comms Biol\2_revision\from Srini\';
dataFolder = [overallFolder, 'results\imageData\'];
resultsFolder = [overallFolder, 'results\'];

theExps = {'A','B','C'};
theConds = {'0g0B','0g50B','30g0B','30g50B'};
theCGs = [2, 2, 3]; % # coverglasses for each experiment
numIms = 4; % # images per coverglass

theVars = {'numE', 'percE', 'numEperUM', 'numI', 'percI', 'numIperUM', 'ratioEI'};

for ii=1:length(theVars)
    
    thisVar = theVars{ii};
    
    disp(thisVar);
    disp('');
    
    for jj=1:length(theConds)
        
        fileCond = theConds{jj};
        thisCond = ['cond',theConds{jj}];
        
        for kk=1:length(theExps)
            
            thisExp = theExps{kk};
            expName = ['exp',thisExp];
            numCGs = theCGs(kk);
            
            for mm=1:numCGs
                
                thisCG = ['coverglass',num2str(mm)];
                
                cgData = [];
                for nn=1:numIms
                    
                    thisIm = ['im',num2str(nn)];
                    
                    tifName = [thisExp,'_',fileCond,'_',thisCG,'_',thisIm];
                    
                    load([dataFolder,tifName,'.mat'], 'EtoIdata');
                    
                    cgData = [cgData; EtoIdata.(thisVar)];
                    
                end %for nn
                
                allData.(expName).(thisCond).(thisCG).(thisVar) = cgData;
                
            end %for mm
            
            mean1 = mean(allData.(expName).(thisCond).coverglass1.(thisVar));
            mean2 = mean(allData.(expName).(thisCond).coverglass2.(thisVar));
            if strcmp(thisExp,'C')
                mean3 = mean(allData.(expName).(thisCond).coverglass3.(thisVar));
                expIndivData.(expName).(thisCond).(thisVar) = [mean1; mean2; mean3];
            else
                expIndivData.(expName).(thisCond).(thisVar) = [mean1; mean2];
            end %if strcmp
            
        end %for kk
        
        expCombData.(thisCond).(thisVar) = [mean(expIndivData.expA.(thisCond).(thisVar)); mean(expIndivData.expB.(thisCond).(thisVar)); mean(expIndivData.expC.(thisCond).(thisVar))];
        
    end %for jj
    
end %for ii

save([resultsFolder,'concatData.mat'], 'allData', 'expIndivData', 'expCombData');


%% part 4 - plot data [ not for publication ]

clc; clear all; close all;

overallFolder = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\submission materials\3_Comms Biol\2_revision\from Srini\';
resultsFolder = [overallFolder, 'results\'];
figsFolder = [resultsFolder, 'figures\'];

load([resultsFolder,'concatData.mat'], 'allData', 'expIndivData', 'expCombData');

theExps = {'A','B','C'};
theConds = {'0g0B','0g50B','30g0B','30g50B'};
theCGs = [2, 2, 3]; % # coverglasses for each experiment
numIms = 4; % # images per coverglass

theVars = {'numE', 'percE', 'numEperUM', 'numI', 'percI', 'numIperUM', 'ratioEI'};

xLocs = [1:1:4];
expCode = ['k', 'r', 'b'];
cgCode = ['o', 's', 'd'];
sz = 0.25;
xJitt_allData = (sz*0.85)*rand(length(theExps)*length(theCGs)*numIms,1) - 0.5*(sz*0.85);
xJitt_indivData = (sz*0.85)*rand(length(theExps)*length(theCGs),1) - 0.5*(sz*0.85);
xJitt_combData = (sz*0.85)*rand(length(theExps),1) - 0.5*(sz*0.85);

for ii=1:length(theVars)
    
    allDataFig = figure('Position',[325.8,173,1000.8,420]);
    
    indivDataFig = figure('Position',[325.8,173,1000.8,420]);
    
    combDataFig = figure('Position',[325.8,173,1000.8,420]);
    
    thisVar = theVars{ii};
    disp('');
    disp(thisVar);
    
    theAllData_conds = [];
    theIndivData_conds = [];
    theCombData_conds = [];
    
    for jj=1:length(theConds)
        allCount = 0;
        indivCount = 0;
        combCount = 0;
        
        theAllData = [];
        theIndivData = [];
        theCombData = [];
        
        fileCond = theConds{jj};
        thisCond = ['cond',theConds{jj}];
        
        combCount = combCount + 1;
        
        combY = expCombData.(thisCond).(thisVar);     
        [rComb,~] = find(combY==Inf);
        if ~isempty(rComb)
            theRows = [1:rComb-1,rComb+1:length(combY)];
            data4mean = combY(theRows);
            combY(rComb) = nanmean(data4mean);
        end %If
        theCombData = [theCombData; combY];
        
        figure(combDataFig);
        scatter(xJitt_combData(combCount:combCount+length(theExps)-1) + xLocs(jj), combY,  25, [0 0 0; 1 0 0; 0 0 1], 'filled');
        hold on;
        
        combCount = combCount+length(theExps)-1;
        
        for kk=1:length(theExps)
            indivCount = indivCount + 1;
            
            thisExp = theExps{kk};
            expName = ['exp',thisExp];
            numCGs = theCGs(kk);
            
            indivY = expIndivData.(expName).(thisCond).(thisVar);
            [rIndiv,~] = find(indivY==Inf);
            if ~isempty(rIndiv)
                theRows = [1:rIndiv-1,rIndiv+1:length(indivY)];
                data4mean = indivY(theRows);
                indivY(rIndiv) = nanmean(data4mean);
            end %If
            theIndivData = [theIndivData; indivY];
            
            figure(indivDataFig);
            scatter(xJitt_indivData(indivCount:indivCount+numCGs-1) + xLocs(jj), indivY, 25, expCode(kk), 'filled');
            hold on;
            
            indivCount = indivCount+numCGs-1;
            
            for mm=1:numCGs
                allCount = allCount + 1;
                
                thisCG = ['coverglass',num2str(mm)];
                
                allY = allData.(expName).(thisCond).(thisCG).(thisVar);
                [rAll,~] = find(allY==Inf);
                if ~isempty(rAll)
                    theRows = [1:rAll-1,rAll+1:length(allY)];
                    data4mean = theAllData(theRows);
                    allY(rAll) = nanmean(data4mean);
                end %If ~issempty
                theAllData = [theAllData; allY];
                
                figure(allDataFig); % allCount:allCount+numIms-1 might not be right ... need to account for numIms total
                scatter(xJitt_allData(allCount:allCount+numIms-1) + xLocs(jj), allY, 25, expCode(kk), 'filled', cgCode(mm));
                hold on;
                
                allCount = allCount+numIms-1;
            end %for mm
            
        end %for kk
        
        
        
        theAllData_conds = [theAllData_conds, theAllData];
        
        allN = length(theAllData);
        allEr = std(theAllData)/sqrt(allN);
        if allN>3
            [hAll,pAll] = adtest(theAllData);
        else
            hAll = 1;
        end %if N8
        if hAll==0
            ciVal_all = tinv([0.025 0.975], allN-1);
            ciVal_all = ciVal_all(2);
        else %if h==1
            ciVal_all = 1.96;
        end %if h
        theCI95_all = ciVal_all.*allEr;
        
        figure(allDataFig);
        plot([xLocs(jj) - sz, xLocs(jj) + sz],[mean(theAllData) mean(theAllData)], 'color', [0.5 0.5 0.5], 'linewidth', 3);
        hold on;
        plot([xLocs(jj), xLocs(jj)],[mean(theAllData)-theCI95_all(1) mean(theAllData)+theCI95_all(1)], 'color', [0.5 0.5 0.5], 'linewidth', 2);
        
        
        
        theIndivData_conds = [theIndivData_conds, theIndivData];
        
        indivN = length(theIndivData);
        indivEr = std(theIndivData)/sqrt(indivN);
        if indivN>3
            [hIndiv,pIndiv] = adtest(theIndivData);
        else
            hIndiv = 1;
        end %if N8
        if hIndiv==0
            ciVal_indiv = tinv([0.025 0.975], indivN-1);
            ciVal_indiv = ciVal_indiv(2);
        else %if h==1
            ciVal_indiv = 1.96;
        end %if h
        theCI95_indiv = ciVal_indiv.*indivEr;
        
        figure(indivDataFig);
        plot([xLocs(jj) - sz, xLocs(jj) + sz],[mean(theIndivData) mean(theIndivData)], 'color', [0.5 0.5 0.5], 'linewidth', 3);
        hold on;
        plot([xLocs(jj), xLocs(jj)],[mean(theIndivData)-theCI95_indiv(1) mean(theIndivData)+theCI95_indiv(1)], 'color', [0.5 0.5 0.5], 'linewidth', 2);
        
        
        
        [rComb,~] = find(theCombData==Inf);
        if ~isempty(rComb)
            theRows = [1:rComb-1,rComb+1:length(theCombData)];
            data4mean = theCombData(theRows);
            theCombData(rComb) = nanmean(data4mean);
        end %If

        theCombData_conds = [theCombData_conds, theCombData];
        
        combN = length(theCombData);
        combEr = std(theCombData)/sqrt(combN);
        if combN>3
            [hComb,pComb] = adtest(theCombData);
        else
            hComb = 1;
        end %if N8
        if hComb==0
            ciVal_comb = tinv([0.025 0.975], combN-1);
            ciVal_comb = ciVal_comb(2);
        else %if h==1
            ciVal_comb = 1.96;
        end %if h
        theCI95_comb = ciVal_comb.*combEr;
        
        figure(combDataFig);
        plot([xLocs(jj) - sz, xLocs(jj) + sz],[mean(theCombData) mean(theCombData)], 'color', [0.5 0.5 0.5], 'linewidth', 3);
        hold on;
        plot([xLocs(jj), xLocs(jj)],[mean(theCombData)-theCI95_comb(1) mean(theCombData)+theCI95_comb(1)], 'color', [0.5 0.5 0.5], 'linewidth', 2);
        
    end %for jj
    
    for jj=1:3
        if jj==1
            figure(allDataFig);
            theMax = 1.2*max(max(theAllData_conds));
        elseif jj==2
            figure(indivDataFig);
            theMax = 1.2*max(max(theIndivData_conds));
        elseif jj==3
            figure(combDataFig);
            theMax = 1.2*max(max(theCombData_conds));
        end %if jj
        
        xlim([xLocs(1)-1, xLocs(end)+1]);
        xticks(xLocs);
        xticklabels({'0g 0B', '0g 50B', '30g 0B', '30g 50B'});
        title(thisVar);
        ylim([0 theMax]);
    end %for jj
    
    %     try
    saveas(allDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_allDataFig.png']);
    %     end
    saveas(allDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_allDataFig.fig']);
    
    close(allDataFig);
    
    [p_allData.(thisVar),tbl_allData.(thisVar),stats_allData.(thisVar)] = ...
        anova1(theAllData_conds,{'cond0g0B','cond0g50B','cond30g0B','cond30g50B'},'off');
    [c_allData.(thisVar),m_allData.(thisVar),h_allData.(thisVar),gnames_allData.(thisVar)] = ...
        multcompare(stats_allData.(thisVar),'Display','off');
    
    disp('ALL DATA')
    for jj=1:size(c_allData.(thisVar),1)
        thisP = c_allData.(thisVar)(jj,6);
        if thisP<0.10
            col1 = num2str(c_allData.(thisVar)(jj,1));
            if strcmp(col1,'1')
                disp1 = 'cond0g0B';
            elseif strcmp(col1,'2')
                disp1 = 'cond0g50B';
            elseif strcmp(col1,'3')
                disp1 = 'cond30g0B';
            elseif strcmp(col1,'4')
                disp1 = 'cond30g50B';
            end %if strcmp
            
            col2 = num2str(c_allData.(thisVar)(jj,2));
            if strcmp(col2,'1')
                disp2 = 'cond0g0B';
            elseif strcmp(col2,'2')
                disp2 = 'cond0g50B';
            elseif strcmp(col2,'3')
                disp2 = 'cond30g0B';
            elseif strcmp(col2,'4')
                disp2 = 'cond30g50B';
            end %if strcmp
            
            disp([disp1,' & ', disp2, ', p=',num2str(thisP)]);
            disp('');
        end %if thisP
    end %for jj
    
    
    %     try
    saveas(indivDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_indivDataFig.png']);
    %     end
    saveas(indivDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_indivDataFig.fig']);
    
    close(indivDataFig);
    
    [p_indivData.(thisVar),tbl_indivData.(thisVar),stats_indivData.(thisVar)] = ...
        anova1(theIndivData_conds,{'cond0g0B','cond0g50B','cond30g0B','cond30g50B'},'off');
    [c_indivData.(thisVar),m_indivData.(thisVar),h_indivData.(thisVar),gnames_indivData.(thisVar)] = ...
        multcompare(stats_indivData.(thisVar),'Display','off');
    
    disp('INDIV DATA')
    for jj=1:size(c_indivData.(thisVar),1)
        thisP = c_indivData.(thisVar)(jj,6);
        if thisP<0.10
            col1 = num2str(c_indivData.(thisVar)(jj,1));
            if strcmp(col1,'1')
                disp1 = 'cond0g0B';
            elseif strcmp(col1,'2')
                disp1 = 'cond0g50B';
            elseif strcmp(col1,'3')
                disp1 = 'cond30g0B';
            elseif strcmp(col1,'4')
                disp1 = 'cond30g50B';
            end %if strcmp
            
            col2 = num2str(c_indivData.(thisVar)(jj,2));
            if strcmp(col2,'1')
                disp2 = 'cond0g0B';
            elseif strcmp(col2,'2')
                disp2 = 'cond0g50B';
            elseif strcmp(col2,'3')
                disp2 = 'cond30g0B';
            elseif strcmp(col2,'4')
                disp2 = 'cond30g50B';
            end %if strcmp
            
            disp([disp1,' & ', disp2, ', p=',num2str(thisP)]);
            disp('');
        end %if thisP
    end %for jj
    
    
    %     try
    saveas(combDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_combDataFig.png']);
    %     end
    saveas(combDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_combDataFig.fig']);
    
    close(combDataFig);
    
    [p_combData.(thisVar),tbl_combData.(thisVar),stats_combData.(thisVar)] = ...
        anova1(theCombData_conds,{'cond0g0B','cond0g50B','cond30g0B','cond30g50B'},'off');
    [c_combData.(thisVar),m_combData.(thisVar),h_combData.(thisVar),gnames_combData.(thisVar)] = ...
        multcompare(stats_combData.(thisVar),'Display','off');
    
    disp('COMB DATA')
    for jj=1:size(c_combData.(thisVar),1)
        thisP = c_combData.(thisVar)(jj,6);
        if thisP<0.10
            col1 = num2str(c_combData.(thisVar)(jj,1));
            if strcmp(col1,'1')
                disp1 = 'cond0g0B';
            elseif strcmp(col1,'2')
                disp1 = 'cond0g50B';
            elseif strcmp(col1,'3')
                disp1 = 'cond30g0B';
            elseif strcmp(col1,'4')
                disp1 = 'cond30g50B';
            end %if strcmp
            
            col2 = num2str(c_combData.(thisVar)(jj,2));
            if strcmp(col2,'1')
                disp2 = 'cond0g0B';
            elseif strcmp(col2,'2')
                disp2 = 'cond0g50B';
            elseif strcmp(col2,'3')
                disp2 = 'cond30g0B';
            elseif strcmp(col2,'4')
                disp2 = 'cond30g50B';
            end %if strcmp
            
            disp([disp1,' & ', disp2, ', p=',num2str(thisP)]);
            disp('');
        end %if thisP
    end %for jj
    
end %for ii

save([figsFolder,'stats_allData.mat'], 'p_allData', 'tbl_allData', 'stats_allData',...
    'c_allData','m_allData','h_allData','gnames_allData');

save([figsFolder,'stats_indivData.mat'], 'p_indivData', 'tbl_indivData', 'stats_indivData',...
    'c_indivData','m_indivData','h_indivData','gnames_indivData');

save([figsFolder,'stats_combData.mat'], 'p_combData', 'tbl_combData', 'stats_combData',...
    'c_combData','m_combData','h_combData','gnames_combData');

%% part 5 - plot data [ PUBLICATION WORTHY! ]

clc; clear all; close all;

overallFolder = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\submission materials\3_Comms Biol\2_revision\from Srini\';
resultsFolder = [overallFolder, 'results\'];
figsFolder = [resultsFolder, 'figures\'];

load([resultsFolder,'concatData.mat'], 'allData', 'expIndivData', 'expCombData');

theExps = {'A','B','C'};
theConds = {'0g0B','0g50B','30g0B','30g50B'};
theCGs = [2, 2, 3]; % # coverglasses for each experiment
numIms = 4; % # images per coverglass

theVars = {'numE', 'percE', 'numEperUM', 'numI', 'percI', 'numIperUM', 'ratioEI'};

xLocs = [1:1:4];
theColors = [0 0 0; 0 0 0; ...
    1 0 0; 1 0 0];
theShapes = {'o','d','o','d'};
sz = 0.25;
xJitt_allData = (sz*0.85)*rand(length(theExps)*length(theCGs)*numIms,1) - 0.5*(sz*0.85);
xJitt_indivData = (sz*0.85)*rand(length(theExps)*length(theCGs),1) - 0.5*(sz*0.85);
xJitt_combData = (sz*0.85)*rand(length(theExps),1) - 0.5*(sz*0.85);

for ii=1:length(theVars)
    
    allDataFig = figure('Position',[325.8,173,1000.8,420]);
    
    indivDataFig = figure('Position',[325.8,173,1000.8,420]);
    
    combDataFig = figure('Position',[325.8,173,1000.8,420]);
    
    thisVar = theVars{ii};
    disp('');
    disp(thisVar);
    
    theAllData_conds = [];
    theIndivData_conds = [];
    theCombData_conds = [];
    
    for jj=1:length(theConds)
        allCount = 0;
        indivCount = 0;
        combCount = 0;
        
        theAllData = [];
        theIndivData = [];
        theCombData = [];
        
        fileCond = theConds{jj};
        thisCond = ['cond',theConds{jj}];
        
        combCount = combCount + 1;
        
        combY = expCombData.(thisCond).(thisVar);     
        [rComb,~] = find(combY==Inf);
        if ~isempty(rComb)
            theRows = [1:rComb-1,rComb+1:length(combY)];
            data4mean = combY(theRows);
            combY(rComb) = nanmean(data4mean);
        end %If
        theCombData = [theCombData; combY];
        
        figure(combDataFig);
        scatter(xJitt_combData(combCount:combCount+length(theExps)-1) + xLocs(jj), combY,  25, theColors(jj,:), theShapes{jj});
        hold on;
        
        combCount = combCount+length(theExps)-1;
        
        for kk=1:length(theExps)
            indivCount = indivCount + 1;
            
            thisExp = theExps{kk};
            expName = ['exp',thisExp];
            numCGs = theCGs(kk);
            
            indivY = expIndivData.(expName).(thisCond).(thisVar);
            [rIndiv,~] = find(indivY==Inf);
            if ~isempty(rIndiv)
                theRows = [1:rIndiv-1,rIndiv+1:length(indivY)];
                data4mean = indivY(theRows);
                indivY(rIndiv) = nanmean(data4mean);
            end %If
            theIndivData = [theIndivData; indivY];
            
            figure(indivDataFig);
            scatter(xJitt_indivData(indivCount:indivCount+numCGs-1) + xLocs(jj), indivY, 25, theColors(jj,:), theShapes{jj});
            hold on;
            
            indivCount = indivCount+numCGs-1;
            
            for mm=1:numCGs
                allCount = allCount + 1;
                
                thisCG = ['coverglass',num2str(mm)];
                
                allY = allData.(expName).(thisCond).(thisCG).(thisVar);
                [rAll,~] = find(allY==Inf);
                if ~isempty(rAll)
                    theRows = [1:rAll-1,rAll+1:length(allY)];
                    data4mean = theAllData(theRows);
                    allY(rAll) = nanmean(data4mean);
                end %If ~issempty
                theAllData = [theAllData; allY];
                
                figure(allDataFig); % allCount:allCount+numIms-1 might not be right ... need to account for numIms total
                scatter(xJitt_allData(allCount:allCount+numIms-1) + xLocs(jj), allY, 25, theColors(jj,:), theShapes{jj});
                hold on;
                
                allCount = allCount+numIms-1;
            end %for mm
            
        end %for kk
        
        
        
        theAllData_conds = [theAllData_conds, theAllData];
        
        allN = length(theAllData);
        allEr = std(theAllData)/sqrt(allN);
        if allN>3
            [hAll,pAll] = adtest(theAllData);
        else
            hAll = 1;
        end %if N8
        if hAll==0
            ciVal_all = tinv([0.025 0.975], allN-1);
            ciVal_all = ciVal_all(2);
        else %if h==1
            ciVal_all = 1.96;
        end %if h
        theCI95_all = ciVal_all.*allEr;
        
        figure(allDataFig);
        theX = xLocs(jj) - sz;
        theRect = rectangle('Position', [theX mean(theAllData)-theCI95_all(1) 2*sz 2*theCI95_all(1)], 'FaceColor',[0.7 0.7 0.7], 'EdgeColor', 'none');
        hold on;
        plot([theX, theX + 2*sz],[mean(theAllData) mean(theAllData)], 'color', [0.5 0.5 0.5], 'linewidth', 3);
        hold on;
        
        
        theIndivData_conds = [theIndivData_conds, theIndivData];
        
        indivN = length(theIndivData);
        indivEr = std(theIndivData)/sqrt(indivN);
        if indivN>3
            [hIndiv,pIndiv] = adtest(theIndivData);
        else
            hIndiv = 1;
        end %if N8
        if hIndiv==0
            ciVal_indiv = tinv([0.025 0.975], indivN-1);
            ciVal_indiv = ciVal_indiv(2);
        else %if h==1
            ciVal_indiv = 1.96;
        end %if h
        theCI95_indiv = ciVal_indiv.*indivEr;
        
        figure(indivDataFig);
        theX = xLocs(jj) - sz;
        theRect = rectangle('Position', [theX mean(theIndivData)-theCI95_indiv(1) 2*sz 2*theCI95_indiv(1)], 'FaceColor',[0.7 0.7 0.7], 'EdgeColor', 'none');
        hold on;
        plot([theX, theX + 2*sz],[mean(theIndivData) mean(theIndivData)], 'color', [0.5 0.5 0.5], 'linewidth', 3);
        hold on;
        
        
        
        [rComb,~] = find(theCombData==Inf);
        if ~isempty(rComb)
            theRows = [1:rComb-1,rComb+1:length(theCombData)];
            data4mean = theCombData(theRows);
            theCombData(rComb) = nanmean(data4mean);
        end %If

        theCombData_conds = [theCombData_conds, theCombData];
        
        combN = length(theCombData);
        combEr = std(theCombData)/sqrt(combN);
        if combN>3
            [hComb,pComb] = adtest(theCombData);
        else
            hComb = 1;
        end %if N8
        if hComb==0
            ciVal_comb = tinv([0.025 0.975], combN-1);
            ciVal_comb = ciVal_comb(2);
        else %if h==1
            ciVal_comb = 1.96;
        end %if h
        theCI95_comb = ciVal_comb.*combEr;
        
        figure(combDataFig);
        theX = xLocs(jj) - sz;
        theRect = rectangle('Position', [theX mean(theCombData)-theCI95_comb(1) 2*sz 2*theCI95_comb(1)], 'FaceColor',[0.7 0.7 0.7], 'EdgeColor', 'none');
        hold on;
        plot([theX, theX + 2*sz],[mean(theCombData) mean(theCombData)], 'color', [0.5 0.5 0.5], 'linewidth', 3);
    end %for jj
    
    for jj=1:3
        if jj==1
            figure(allDataFig);
            theMax = 1.2*max(max(theAllData_conds));
        elseif jj==2
            figure(indivDataFig);
            theMax = 1.2*max(max(theIndivData_conds));
        elseif jj==3
            figure(combDataFig);
            theMax = 1.2*max(max(theCombData_conds));
        end %if jj
        
        xlim([xLocs(1)-1, xLocs(end)+1]);
        xticks(xLocs);
        xticklabels({'0g 0B', '0g 50B', '30g 0B', '30g 50B'});
        title(thisVar);
        ylim([0 theMax]);
    end %for jj
    
    %     try
    saveas(allDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_allDataFig_finalPub.png']);
    %     end
    saveas(allDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_allDataFig_finalPub.fig']);
    saveas(allDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_allDataFig_finalPub.svg']);
    
    close(allDataFig);
    
    [p_allData.(thisVar),tbl_allData.(thisVar),stats_allData.(thisVar)] = ...
        anova1(theAllData_conds,{'cond0g0B','cond0g50B','cond30g0B','cond30g50B'},'off');
    [c_allData.(thisVar),m_allData.(thisVar),h_allData.(thisVar),gnames_allData.(thisVar)] = ...
        multcompare(stats_allData.(thisVar),'Display','off');
    
    disp('ALL DATA')
    for jj=1:size(c_allData.(thisVar),1)
        thisP = c_allData.(thisVar)(jj,6);
        if thisP<0.10
            col1 = num2str(c_allData.(thisVar)(jj,1));
            if strcmp(col1,'1')
                disp1 = 'cond0g0B';
            elseif strcmp(col1,'2')
                disp1 = 'cond0g50B';
            elseif strcmp(col1,'3')
                disp1 = 'cond30g0B';
            elseif strcmp(col1,'4')
                disp1 = 'cond30g50B';
            end %if strcmp
            
            col2 = num2str(c_allData.(thisVar)(jj,2));
            if strcmp(col2,'1')
                disp2 = 'cond0g0B';
            elseif strcmp(col2,'2')
                disp2 = 'cond0g50B';
            elseif strcmp(col2,'3')
                disp2 = 'cond30g0B';
            elseif strcmp(col2,'4')
                disp2 = 'cond30g50B';
            end %if strcmp
            
            disp([disp1,' & ', disp2, ', p=',num2str(thisP)]);
            disp('');
        end %if thisP
    end %for jj
    
    
    %     try
    saveas(indivDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_indivDataFig_finalPub.png']);
    %     end
    saveas(indivDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_indivDataFig_finalPub.fig']);
    saveas(indivDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_indivDataFig_finalPub.svg']);
    
    close(indivDataFig);
    
    [p_indivData.(thisVar),tbl_indivData.(thisVar),stats_indivData.(thisVar)] = ...
        anova1(theIndivData_conds,{'cond0g0B','cond0g50B','cond30g0B','cond30g50B'},'off');
    [c_indivData.(thisVar),m_indivData.(thisVar),h_indivData.(thisVar),gnames_indivData.(thisVar)] = ...
        multcompare(stats_indivData.(thisVar),'Display','off');
    
    disp('INDIV DATA')
    for jj=1:size(c_indivData.(thisVar),1)
        thisP = c_indivData.(thisVar)(jj,6);
        if thisP<0.10
            col1 = num2str(c_indivData.(thisVar)(jj,1));
            if strcmp(col1,'1')
                disp1 = 'cond0g0B';
            elseif strcmp(col1,'2')
                disp1 = 'cond0g50B';
            elseif strcmp(col1,'3')
                disp1 = 'cond30g0B';
            elseif strcmp(col1,'4')
                disp1 = 'cond30g50B';
            end %if strcmp
            
            col2 = num2str(c_indivData.(thisVar)(jj,2));
            if strcmp(col2,'1')
                disp2 = 'cond0g0B';
            elseif strcmp(col2,'2')
                disp2 = 'cond0g50B';
            elseif strcmp(col2,'3')
                disp2 = 'cond30g0B';
            elseif strcmp(col2,'4')
                disp2 = 'cond30g50B';
            end %if strcmp
            
            disp([disp1,' & ', disp2, ', p=',num2str(thisP)]);
            disp('');
        end %if thisP
    end %for jj
    
    
    %     try
    saveas(combDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_combDataFig_finalPub.png']);
    %     end
    saveas(combDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_combDataFig_finalPub.fig']);
    saveas(combDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_combDataFig_finalPub.svg']);
    
    close(combDataFig);
    
    [p_combData.(thisVar),tbl_combData.(thisVar),stats_combData.(thisVar)] = ...
        anova1(theCombData_conds,{'cond0g0B','cond0g50B','cond30g0B','cond30g50B'},'off');
    [c_combData.(thisVar),m_combData.(thisVar),h_combData.(thisVar),gnames_combData.(thisVar)] = ...
        multcompare(stats_combData.(thisVar),'Display','off');
    
    disp('COMB DATA')
    for jj=1:size(c_combData.(thisVar),1)
        thisP = c_combData.(thisVar)(jj,6);
        if thisP<0.10
            col1 = num2str(c_combData.(thisVar)(jj,1));
            if strcmp(col1,'1')
                disp1 = 'cond0g0B';
            elseif strcmp(col1,'2')
                disp1 = 'cond0g50B';
            elseif strcmp(col1,'3')
                disp1 = 'cond30g0B';
            elseif strcmp(col1,'4')
                disp1 = 'cond30g50B';
            end %if strcmp
            
            col2 = num2str(c_combData.(thisVar)(jj,2));
            if strcmp(col2,'1')
                disp2 = 'cond0g0B';
            elseif strcmp(col2,'2')
                disp2 = 'cond0g50B';
            elseif strcmp(col2,'3')
                disp2 = 'cond30g0B';
            elseif strcmp(col2,'4')
                disp2 = 'cond30g50B';
            end %if strcmp
            
            disp([disp1,' & ', disp2, ', p=',num2str(thisP)]);
            disp('');
        end %if thisP
    end %for jj
    
end %for ii

save([figsFolder,'stats_allData.mat'], 'p_allData', 'tbl_allData', 'stats_allData',...
    'c_allData','m_allData','h_allData','gnames_allData');

save([figsFolder,'stats_indivData.mat'], 'p_indivData', 'tbl_indivData', 'stats_indivData',...
    'c_indivData','m_indivData','h_indivData','gnames_indivData');

save([figsFolder,'stats_combData.mat'], 'p_combData', 'tbl_combData', 'stats_combData',...
    'c_combData','m_combData','h_combData','gnames_combData');

