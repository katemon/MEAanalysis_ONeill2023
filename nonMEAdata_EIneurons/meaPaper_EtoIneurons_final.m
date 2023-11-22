%% part 1 - concatenate data from excel

clc; clear all; close all;

overallFolder = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\submission materials\3_Comms Biol\2_revision\from Srini\';
resultsFolder = [overallFolder,'results_10x\'];

load([resultsFolder,'excelData.mat']);

theExps = {'A','B','C'};
theConds = {'0g0B','0g50B','30g0B','30g50B'};
numIms = 6; % # images per experiment

theVars = {'numMAP2', 'percE', 'percI', 'numE', 'numI', 'ratioEI'};

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
            
            expData = [];
            
            for mm=1:numIms
                
                thisIm = ['im',num2str(mm)];
                
                if ii<4
                    thisExpData = excelData.(thisCond).(expName)(mm,ii);
                elseif ii==4 % numE = percE * numMAP2
                    thisExpData = excelData.(thisCond).(expName)(mm,2).*excelData.(thisCond).(expName)(mm,1);
                elseif ii==5 % numI = percI * numMAP2
                    thisExpData = excelData.(thisCond).(expName)(mm,3).*excelData.(thisCond).(expName)(mm,1);
                elseif ii==6 % ratioEI = percE / percO=I
                    thisExpData = excelData.(thisCond).(expName)(mm,2)./excelData.(thisCond).(expName)(mm,3);
                end %if
                
                expData = [expData; thisExpData];
                
            end %for mm
            
            allData.(expName).(thisCond).(thisVar) = expData;
            
        end %for kk
        
        if ii<6
            expCombData.(thisCond).(thisVar) = [mean(allData.expA.(thisCond).(thisVar)); mean(allData.expB.(thisCond).(thisVar)); mean(allData.expC.(thisCond).(thisVar))];
        else
            expCombData.(thisCond).(thisVar) = [mean(excelData.(thisCond).expA(:,2))/mean(excelData.(thisCond).expA(:,3)); mean(excelData.(thisCond).expB(:,2))/mean(excelData.(thisCond).expB(:,3)); mean(excelData.(thisCond).expC(:,2))/mean(excelData.(thisCond).expC(:,3))];
        end %if ii
        
    end %for jj
    
end %for ii

save([resultsFolder,'concatData.mat'], 'allData', 'expCombData');


%% part 2 - plot data [ not for publication ]

clc; clear all; close all;

overallFolder = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\submission materials\3_Comms Biol\2_revision\from Srini\';
resultsFolder = [overallFolder, 'results_10x\'];
figsFolder = [resultsFolder, 'figures\'];

load([resultsFolder,'concatData.mat'], 'allData', 'expCombData');

theExps = {'A','B','C'};
theConds = {'0g0B','0g50B','30g0B','30g50B'};
numIms = 6; % # images per experiment

theVars = {'numMAP2', 'percE', 'percI', 'numE', 'numI', 'ratioEI'};

xLocs = [1:1:4];
expCode = ['k', 'r', 'b'];
sz = 0.25;
xJitt_allData = (sz*0.85)*rand(length(theExps)*numIms,1) - 0.5*(sz*0.85);
xJitt_combData = (sz*0.85)*rand(length(theExps),1) - 0.5*(sz*0.85);

% checking normality

theConds = {'0g0B','0g50B','30g0B','30g50B'};
theVars = {'numMAP2', 'percE', 'percI', 'numE', 'numI', 'ratioEI'};

for ii=1:length(theVars)
    
    allDataFig = figure('Position',[325.8,173,1000.8,420]);
    
    combDataFig = figure('Position',[325.8,173,1000.8,420]);
    
    thisVar = theVars{ii};
    disp('');
    disp(thisVar);
    
    theAllData_conds = [];
    theCombData_conds = [];
    
    for jj=1:length(theConds)
        allCount = 0;
        combCount = 0;
        
        theAllData = [];
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
            
            if ii<6
                thisExp = theExps{kk};
                expName = ['exp',thisExp];
                
                allCount = allCount + 1;
                
                allY = allData.(expName).(thisCond).(thisVar);
                [rAll,~] = find(allY==Inf);
                if ~isempty(rAll)
                    theRows = [1:rAll-1,rAll+1:length(allY)];
                    data4mean = theAllData(theRows);
                    allY(rAll) = nanmean(data4mean);
                end %If ~issempty
                theAllData = [theAllData; allY];
                
                figure(allDataFig); % allCount:allCount+numIms-1 might not be right ... need to account for numIms total
                scatter(xJitt_allData(allCount:allCount+numIms-1) + xLocs(jj), allY, 25, expCode(kk), 'filled');
                hold on;
                
                allCount = allCount+numIms-1;
            end %if ii
        end %for kk
        
        
        if ii<6
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
        
        end %if ii
        
        
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
    
    for jj=1:2
        if jj==1
            if ii<6
                figure(allDataFig);
                theMax = 1.2*max(max(theAllData_conds));
            end %if ii
        elseif jj==2
            figure(combDataFig);
            theMax = 1.2*max(max(theCombData_conds));
        end %if jj
        
        xlim([xLocs(1)-1, xLocs(end)+1]);
        xticks(xLocs);
        xticklabels({'0g 0B', '0g 50B', '30g 0B', '30g 50B'});
        title(thisVar);
        if ii<6
            ylim([0 theMax]);
        end %if ii
    end %for jj
    
    %     try
    saveas(allDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_allDataFig.png']);
    %     end
    saveas(allDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_allDataFig.fig']);
    
    close(allDataFig);
    
    if ii<6
        [p_allData.(thisVar),tbl_allData.(thisVar),stats_allData.(thisVar)] = ...
            kruskalwallis(theAllData_conds,{'cond0g0B','cond0g50B','cond30g0B','cond30g50B'},'off');
%         anova1(theAllData_conds,{'cond0g0B','cond0g50B','cond30g0B','cond30g50B'},'off');
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
    end %if ii
    
    
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

save([figsFolder,'stats_combData.mat'], 'p_combData', 'tbl_combData', 'stats_combData',...
    'c_combData','m_combData','h_combData','gnames_combData');

%% part 3 - plot data [ PUBLICATION WORTHY! ]

clc; clear all; close all;

overallFolder = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\submission materials\3_Comms Biol\2_revision\from Srini\';
resultsFolder = [overallFolder, 'results_10x\'];
figsFolder = [resultsFolder, 'figures\'];

load([resultsFolder,'concatData.mat'], 'allData', 'expCombData');

theExps = {'A','B','C'};
theConds = {'0g0B','0g50B','30g0B','30g50B'};
numIms = 6; % # images per experiment

theVars = {'numMAP2', 'percE', 'percI', 'numE', 'numI', 'ratioEI'};

xLocs = [1:1:4];
theColors = [0 0 0; 0 0 0; ...
    1 0 0; 1 0 0];
theShapes = {'o','d','o','d'};

sz = 0.25;
xJitt_allData = (sz*0.85)*rand(length(theExps)*numIms,1) - 0.5*(sz*0.85);
xJitt_combData = (sz*0.85)*rand(length(theExps),1) - 0.5*(sz*0.85);

% checking normality

theConds = {'0g0B','0g50B','30g0B','30g50B'};
theVars = {'numMAP2', 'percE', 'percI', 'numE', 'numI', 'ratioEI'};

for ii=1:length(theVars)
    
    allDataFig = figure('Position',[325.8,173,1000.8,420]);
    
    combDataFig = figure('Position',[325.8,173,1000.8,420]);
    
    thisVar = theVars{ii};
    disp('');
    disp(thisVar);
    
    theAllData_conds = [];
    theCombData_conds = [];
    
    for jj=1:length(theConds)
        allCount = 0;
        combCount = 0;
        
        theAllData = [];
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
            
            if ii<6
                thisExp = theExps{kk};
                expName = ['exp',thisExp];
                
                allCount = allCount + 1;
                
                allY = allData.(expName).(thisCond).(thisVar);
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
            end %if ii
        end %for kk
        
        
        if ii<6
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
        end %if ii
        
        
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
    
    for jj=1:2
        if jj==1
            if ii<6
                figure(allDataFig);
                theMax = 1.2*max(max(theAllData_conds));
            end %if ii
        elseif jj==2
            figure(combDataFig);
            theMax = 1.2*max(max(theCombData_conds));
        end %if jj
        
        xlim([xLocs(1)-1, xLocs(end)+1]);
        xticks(xLocs);
        xticklabels({'0g 0B', '0g 50B', '30g 0B', '30g 50B'});
        title(thisVar);
        if ii<6
            ylim([0 theMax]);
        end %if ii
    end %for jj
    
    %     try
    saveas(allDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_allDataFig_finalPub.png']);
    %     end
    saveas(allDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_allDataFig_finalPub.fig']);
    saveas(allDataFig, ['C:\Users\kmfo8\Desktop\',thisVar,'_allDataFig_finalPub.svg']);
    
    close(allDataFig);
    
    if ii<6
        [p_allData.(thisVar),tbl_allData.(thisVar),stats_allData.(thisVar)] = ...
            kruskalwallis(theAllData_conds,{'cond0g0B','cond0g50B','cond30g0B','cond30g50B'},'off');
%         anova1(theAllData_conds,{'cond0g0B','cond0g50B','cond30g0B','cond30g50B'},'off');
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
    end %if ii
    
    
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

save([figsFolder,'stats_combData.mat'], 'p_combData', 'tbl_combData', 'stats_combData',...
    'c_combData','m_combData','h_combData','gnames_combData');
