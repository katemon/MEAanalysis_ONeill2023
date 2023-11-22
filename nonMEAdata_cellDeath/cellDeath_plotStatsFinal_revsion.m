clc; clear all; close all;

dataLoc = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\MEA papers -- addl experiments\EXP for BDNF + glu\Glutamate cell death, BDNF treatment\v3 (final) of analysis\';%D:\kate_dropbox\Dropbox
figDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\MEA papers -- addl experiments\EXP for BDNF + glu\Glutamate cell death, BDNF treatment\final_forPaper\';%D:\kate_dropbox\Dropbox

load([dataLoc,'cellDeathPixelData_blindUnblind.mat'], 'unblindedPixData','unblindedBranchData');
load([dataLoc,'correctNumCellData_final.mat'], 'numCells_all');

% the usual order
theConds = {'pre'; 'cond0g0b_0h'; 'cond30g0b_0h'; ...
    'cond0g0b_24h'; 'cond0g50b_24h'; 'cond30g0b_24h'; ...
    'cond30g50b_24h'; 'cond0g0b_72h'; 'cond0g50b_72h'; ...
    'cond30g0b_72h'; 'cond30g50b_72h' };

% % % % % organizing data - raw and various normalizations
for ii=1:3
    replName = ['repl',num2str(ii)];
    for jj=1:length(theConds)
        thisCond = theConds{jj};
        numRpts = length(fields(unblindedPixData.(replName).(thisCond)));
        
        theSubCond = thisCond(1:strfind(thisCond,'0g'));
        
        for kk=1:numRpts
            rptName = ['rpt',num2str(kk)];
            
            
            % % % normalize to "pre" and "0h" (all)
            
            % % numCells
            numCells.(replName).(thisCond).(rptName).raw = nanmean(numCells_all.(replName).(thisCond).(rptName).raw);
            
            numCells.(replName).(thisCond).(rptName).normPre = nanmean(numCells_all.(replName).(thisCond).(rptName).raw) ./ nanmean(numCells_all.(replName).pre.(rptName).raw);
            thisData = numCells.(replName).(thisCond).(rptName).normPre;
            thisData(thisData==Inf) = NaN;%0;
%             thisData(isnan(thisData)) = 0;
            numCells.(replName).(thisCond).(rptName).normPre = thisData;
            
            if ~isempty(theSubCond)
                if strcmp(theSubCond,'cond0')
                    numCells.(replName).(thisCond).(rptName).norm0h = nanmean(numCells_all.(replName).(thisCond).(rptName).raw) ./ nanmean(numCells_all.(replName).cond0g0b_0h.(rptName).raw);
                elseif strcmp(theSubCond,'cond30')
                    numCells.(replName).(thisCond).(rptName).norm0h = nanmean(numCells_all.(replName).(thisCond).(rptName).raw) ./ nanmean(numCells_all.(replName).cond30g0b_0h.(rptName).raw);
                end %if strcmp
                if ~strcmp(theSubCond,'pre')
                    thisData = numCells.(replName).(thisCond).(rptName).norm0h;
                    thisData(thisData==Inf) = NaN;%0;
                    %                 thisData(isnan(thisData)) = 0;
                    numCells.(replName).(thisCond).(rptName).norm0h = thisData;
                end %if ~strcmp
            end %if ~isempty
            
            % % pixel data
            pixData.(replName).(thisCond).(rptName).raw = nanmean(unblindedPixData.(replName).(thisCond).(rptName));
            
            pixData.(replName).(thisCond).(rptName).normPre = nanmean(unblindedPixData.(replName).(thisCond).(rptName)) ./ nanmean(unblindedPixData.(replName).pre.(rptName));
            thisData = pixData.(replName).(thisCond).(rptName).normPre;
            thisData(thisData==Inf) = NaN;%0;
%             thisData(isnan(thisData)) = 0;
            pixData.(replName).(thisCond).(rptName).normPre = thisData;
            
            if ~isempty(theSubCond)
                if strcmp(theSubCond,'cond0')
                    pixData.(replName).(thisCond).(rptName).norm0h = nanmean(unblindedPixData.(replName).(thisCond).(rptName)) ./ nanmean(unblindedPixData.(replName).cond0g0b_0h.(rptName));
                elseif strcmp(theSubCond,'cond30')
                    pixData.(replName).(thisCond).(rptName).norm0h = nanmean(unblindedPixData.(replName).(thisCond).(rptName)) ./ nanmean(unblindedPixData.(replName).cond30g0b_0h.(rptName));
                end %if strcmp
                if ~strcmp(theSubCond,'pre')
                    thisData = pixData.(replName).(thisCond).(rptName).norm0h;
                    thisData(thisData==Inf) = NaN;%0;
                    %                 thisData(isnan(thisData)) = 0;
                    pixData.(replName).(thisCond).(rptName).norm0h = thisData;
                end %if ~strcmp
            end %if ~isempty
            
            % % BP data
            bpData.(replName).(thisCond).(rptName).raw = nanmean(unblindedBranchData.(replName).(thisCond).(rptName));
            
            bpData.(replName).(thisCond).(rptName).normPre = nanmean(unblindedBranchData.(replName).(thisCond).(rptName)) ./ nanmean(unblindedBranchData.(replName).pre.(rptName));
            thisData = bpData.(replName).(thisCond).(rptName).normPre;
            thisData(thisData==Inf) = NaN;%0;
%             thisData(isnan(thisData)) = 0;
            bpData.(replName).(thisCond).(rptName).normPre = thisData;
            
            if ~isempty(theSubCond)
                if strcmp(theSubCond,'cond0')
                    bpData.(replName).(thisCond).(rptName).norm0h = nanmean(unblindedBranchData.(replName).(thisCond).(rptName)) ./ nanmean(unblindedBranchData.(replName).cond0g0b_0h.(rptName));
                elseif strcmp(theSubCond,'cond30')
                    bpData.(replName).(thisCond).(rptName).norm0h = nanmean(unblindedBranchData.(replName).(thisCond).(rptName)) ./ nanmean(unblindedBranchData.(replName).cond30g0b_0h.(rptName));
                end %if strcmp
                if ~strcmp(theSubCond,'pre')
                    thisData = bpData.(replName).(thisCond).(rptName).norm0h;
                    thisData(thisData==Inf) = NaN;%0;
                    %                 thisData(isnan(thisData)) = 0;
                    bpData.(replName).(thisCond).(rptName).norm0h = thisData;
                end %if ~strcmp
            end %if ~isempty
            
            
            % % % normalize to numCells (branchData and pixData only)
            
            % % pixel data - normNumCells and normPreNumCells
            pixData.(replName).(thisCond).(rptName).normNumCells = nanmean(unblindedPixData.(replName).(thisCond).(rptName)) ./ nanmean(numCells_all.(replName).(thisCond).(rptName).raw);
            thisData = pixData.(replName).(thisCond).(rptName).normNumCells;
            thisData(thisData==Inf) = NaN;%0;
%             thisData(isnan(thisData)) = 0;
            pixData.(replName).(thisCond).(rptName).normNumCells = thisData;
            
            pixData.(replName).(thisCond).(rptName).normPreNumCells = nanmean(unblindedPixData.(replName).(thisCond).(rptName)) ./ nanmean(numCells_all.(replName).pre.(rptName).raw);
            thisData = pixData.(replName).(thisCond).(rptName).normPreNumCells;
            thisData(thisData==Inf) = NaN;%0;
%             thisData(isnan(thisData)) = 0;
            pixData.(replName).(thisCond).(rptName).normPreNumCells = thisData;
            
            if ~isempty(theSubCond)
                if strcmp(theSubCond,'cond0')
                    pixData.(replName).(thisCond).(rptName).norm0hNumCells = nanmean(unblindedPixData.(replName).(thisCond).(rptName)) ./ nanmean(numCells_all.(replName).cond0g0b_0h.(rptName).raw);
                elseif strcmp(theSubCond,'cond30')
                    pixData.(replName).(thisCond).(rptName).norm0hNumCells = nanmean(unblindedPixData.(replName).(thisCond).(rptName)) ./ nanmean(numCells_all.(replName).cond30g0b_0h.(rptName).raw);
                end %if strcmp
                if ~strcmp(theSubCond,'pre')
                    thisData = pixData.(replName).(thisCond).(rptName).norm0hNumCells;
                    thisData(thisData==Inf) = NaN;%0;
                    %                 thisData(isnan(thisData)) = 0;
                    pixData.(replName).(thisCond).(rptName).norm0hNumCells = thisData;
                end %if ~strcmp
            end %if ~isempty
            
            % % BP data - normNumCells and normPreNumCells
            bpData.(replName).(thisCond).(rptName).normNumCells = nanmean(unblindedBranchData.(replName).(thisCond).(rptName)) ./ nanmean(numCells_all.(replName).(thisCond).(rptName).raw);
            thisData = bpData.(replName).(thisCond).(rptName).normNumCells;
            thisData(thisData==Inf) = NaN;%0;
%             thisData(isnan(thisData)) = 0;
            bpData.(replName).(thisCond).(rptName).normNumCells = thisData;
            
            bpData.(replName).(thisCond).(rptName).normPreNumCells = nanmean(unblindedBranchData.(replName).(thisCond).(rptName)) ./ nanmean(numCells_all.(replName).pre.(rptName).raw);
            thisData = bpData.(replName).(thisCond).(rptName).normPreNumCells;
            thisData(thisData==Inf) = NaN;%0;
%             thisData(isnan(thisData)) = 0;
            bpData.(replName).(thisCond).(rptName).normPreNumCells = thisData;
            
            if ~isempty(theSubCond)
                if strcmp(theSubCond,'cond0')
                    bpData.(replName).(thisCond).(rptName).norm0hNumCells = nanmean(unblindedBranchData.(replName).(thisCond).(rptName)) ./ nanmean(numCells_all.(replName).cond0g0b_0h.(rptName).raw);
                elseif strcmp(theSubCond,'cond30')
                    bpData.(replName).(thisCond).(rptName).norm0hNumCells = nanmean(unblindedBranchData.(replName).(thisCond).(rptName)) ./ nanmean(numCells_all.(replName).cond30g0b_0h.(rptName).raw);
                end %if strcmp
                if ~strcmp(theSubCond,'pre')
                    thisData = bpData.(replName).(thisCond).(rptName).norm0hNumCells;
                    thisData(thisData==Inf) = NaN;%0;
                    %                 thisData(isnan(thisData)) = 0;
                    bpData.(replName).(thisCond).(rptName).norm0hNumCells = thisData;
                end %if ~strcmp
            end %if ~isempty
            
            
            % % % normalize to numBPs (pixData only)
            
            % % pixel data
            pixData.(replName).(thisCond).(rptName).normNumBPs = nanmean(unblindedPixData.(replName).(thisCond).(rptName)) ./ nanmean(unblindedBranchData.(replName).(thisCond).(rptName));
            thisData = pixData.(replName).(thisCond).(rptName).normNumBPs;
            thisData(thisData==Inf) = NaN;%0;
%             thisData(isnan(thisData)) = 0;
            pixData.(replName).(thisCond).(rptName).normNumBPs = thisData;
            
            pixData.(replName).(thisCond).(rptName).normPreNumBPs = nanmean(unblindedPixData.(replName).(thisCond).(rptName)) ./ nanmean(unblindedBranchData.(replName).pre.(rptName));
            thisData = pixData.(replName).(thisCond).(rptName).normPreNumBPs;
            thisData(thisData==Inf) = NaN;%0;
%             thisData(isnan(thisData)) = 0;
            pixData.(replName).(thisCond).(rptName).normPreNumBPs = thisData;
            
            if ~isempty(theSubCond)
                if strcmp(theSubCond,'cond0')
                    pixData.(replName).(thisCond).(rptName).norm0hNumBPs = nanmean(unblindedPixData.(replName).(thisCond).(rptName)) ./ nanmean(unblindedBranchData.(replName).cond0g0b_0h.(rptName));
                elseif strcmp(theSubCond,'cond30')
                    pixData.(replName).(thisCond).(rptName).norm0hNumBPs = nanmean(unblindedPixData.(replName).(thisCond).(rptName)) ./ nanmean(unblindedBranchData.(replName).cond30g0b_0h.(rptName));
                end %if strcmp
                if ~strcmp(theSubCond,'pre')
                    thisData = pixData.(replName).(thisCond).(rptName).norm0hNumBPs;
                    thisData(thisData==Inf) = NaN;%0;
                    %                 thisData(isnan(thisData)) = 0;
                    pixData.(replName).(thisCond).(rptName).norm0hNumBPs = thisData;
                end %if ~strcmp
            end %if ~isempty
            
        end %for kk
        
    end %for jj
    
end %for ii

for ii=1:length(theConds)
    
    tempCellData = [];
    tempPixData = [];
    tempBPData = [];
    for jj=1:3
        replName = ['repl',num2str(jj)];
        
        thisCond = theConds{ii};
        numRpts = length(fields(unblindedPixData.(replName).(thisCond)));
        
        rptCellData = [];
        rptPixData = [];
        rptBPData = [];
        for kk=1:numRpts
            rptName = ['rpt',num2str(kk)];
            
            rptCellData = [rptCellData; numCells.(replName).(thisCond).(rptName)];
            rptPixData = [rptPixData; pixData.(replName).(thisCond).(rptName)];
            rptBPData = [rptBPData; bpData.(replName).(thisCond).(rptName)];
        end %for kk
        
        theFields1 = fields(rptCellData);
        for kk=1:length(theFields1)
            
            concatCell = [];
            for mm=1:size(rptCellData,1)
                concatCell = [concatCell; rptCellData(mm).(theFields1{kk})];
            end %for mm
            
            tempCellData.(theFields1{kk})(jj) = nanmean(concatCell);
        end %for kk
        theFields2 = fields(rptPixData);
        for kk=1:length(theFields2)
            
            concatPix = [];
            for mm=1:size(rptCellData,1)
                concatPix = [concatPix; rptPixData(mm).(theFields2{kk})];
            end %for mm
            
            tempPixData.(theFields2{kk})(jj) = nanmean(concatPix);
        end %for kk
        theFields3 = fields(rptBPData);
        for kk=1:length(theFields3)
            
            concatBP = [];
            for mm=1:size(rptCellData,1)
                concatBP = [concatBP; rptBPData(mm).(theFields3{kk})];
            end %for mm
            
            tempBPData.(theFields3{kk})(jj) = nanmean(concatBP);
        end %for kk
        
    end %for jj
    theCellData.(thisCond) = tempCellData;
    thePixData.(thisCond) = tempPixData;
    theBPData.(thisCond) = tempBPData;
    
end %for ii

% % % % % plotting data - raw and various normalizations
vars2plot = 3;
sz = 0.25;
for ii=1:vars2plot
    if ii==1
        plottingVar = theCellData;
        figName = 'numCell';
    elseif ii==2
        plottingVar = thePixData;
        figName = 'pixData';
    elseif ii==3
        plottingVar = theBPData;
        figName = 'bpData';
    end %if ii
    disp(figName);
    
    thePlotTypes = fields(plottingVar.cond30g50b_24h);
    for jj=1:length(thePlotTypes) % raw, norm, etc
        myFig = figure('Position',[21, 181.67, 1185.33, 426.67]);
        
        xJitt = (sz*0.75)*rand(3,1) - 0.5*(sz*0.75);
        
        thisField = thePlotTypes{jj};
        
        if strcmp(thisField,'raw') || strcmp(thisField(1:5),'normN')
            xLocs = [1:1:11];
            theConds = {'pre'; 'cond0g0b_0h'; 'cond30g0b_0h'; ...
                'cond0g0b_24h'; 'cond0g50b_24h'; 'cond30g0b_24h'; ...
                'cond30g50b_24h'; 'cond0g0b_72h'; 'cond0g50b_72h'; ...
                'cond30g0b_72h'; 'cond30g50b_72h' };
            theColors = [0 0 0; 0 0 0; 1 0 0; ...
                0 0 0; 0 0 0; 1 0 0; ...
                1 0 0; 0 0 0; 0 0 0; ...
                1 0 0; 1 0 0];
            theShapes = {'o','o','o',...
                'o','d','o',...
                'd','o','d',...
                'o','d',};
        elseif strcmp(thisField(1:6),'norm0h')
            xLocs = [1:1:8];
            theConds = {'cond0g0b_24h'; 'cond0g50b_24h'; 'cond30g0b_24h'; ...
                'cond30g50b_24h'; 'cond0g0b_72h'; 'cond0g50b_72h'; ...
                'cond30g0b_72h'; 'cond30g50b_72h' };
            theColors = [0 0 0; 0 0 0; 1 0 0; ...
                1 0 0; 0 0 0; 0 0 0; ...
                1 0 0; 1 0 0 ];
            theShapes = {'o','d','o',...
                'd','o','d',...
                'o','d'};
        elseif strcmp(thisField(1:7),'normPre')
            xLocs = [1:1:10];
            theConds = {'cond0g0b_0h'; 'cond30g0b_0h'; 'cond0g0b_24h'; ...
                'cond0g50b_24h'; 'cond30g0b_24h'; 'cond30g50b_24h'; ...
                'cond0g0b_72h'; 'cond0g50b_72h'; 'cond30g0b_72h'; ...
                'cond30g50b_72h' };
            theColors = [0 0 0; 1 0 0; 0 0 0; ...
                0 0 0; 1 0 0; 1 0 0; ...
                0 0 0; 0 0 0; 1 0 0; ...
                1 0 0];
            theShapes = {'o','o','o',...
                'd','o','d',...
                'o','d','o',...
                'd'};
        end %if strcmp
        
        for kk=1:length(theConds)
            thisCond = theConds{kk};
            
            theY = plottingVar.(thisCond).(thisField);
            theMean = nanmean(theY);
            N = length(theY);
            theSEM = nanstd(theY)/sqrt(N);
            ciVal = 1.96;
            theCI95 = ciVal.*theSEM;
            
            theX = xLocs(kk)-sz;
            theRect = rectangle('Position', [theX theMean-theCI95 2*sz 2*theCI95], 'FaceColor',[0.7 0.7 0.7], 'EdgeColor', 'none');
            hold on;
            plot([xLocs(kk)-sz, xLocs(kk)+sz],[theMean, theMean],'color',[1 0 0],'linewidth',2);
            
            xJitt = (sz*0.75)*rand(N,1) - 0.5*(sz*0.75);
            thisScatter = scatter(xJitt + xLocs(kk),theY,40,theShapes{kk},'markeredgecolor',theColors(kk,:));
            hold on;
            
            if strcmp(thisCond,'pre')
                pre = theY;
            elseif strcmp(thisCond,'cond0g0b_0h')
                cond0g0b_0h = theY;
            elseif strcmp(thisCond,'cond30g0b_0h')
                cond30g0b_0h = theY;
            elseif strcmp(thisCond,'cond0g0b_24h')
                cond0g0b_24h = theY;
            elseif strcmp(thisCond,'cond0g50b_24h')
                cond0g50b_24h = theY;
            elseif strcmp(thisCond,'cond30g0b_24h')
                cond30g0b_24h = theY;
            elseif strcmp(thisCond,'cond30g50b_24h')
                cond30g50b_24h = theY;
            elseif strcmp(thisCond,'cond0g0b_72h')
                cond0g0b_72h = theY;
            elseif strcmp(thisCond,'cond0g50b_72h')
                cond0g50b_72h = theY;
            elseif strcmp(thisCond,'cond30g0b_72h')
                cond30g0b_72h = theY;
            elseif strcmp(thisCond,'cond30g50b_72h')
                cond30g50b_72h = theY;
            end %if strcmp
            
        end %for kk
        xlim([xLocs(1)-1 xLocs(end)+1]);
        xticks(xLocs);
        ylim([-Inf Inf]);
        
        disp(['RM ANOVA ',thisField]);
        if strcmp(thisField,'raw') || strcmp(thisField(1:5),'normN')
            % % % RM ANOVA
            
            dataMatrix = [ pre', cond0g0b_0h', cond0g0b_24h', cond0g0b_72h'; ...
                pre', cond0g0b_0h', cond0g50b_24h', cond0g50b_72h'; ...
                pre', cond30g0b_0h', cond30g0b_24h', cond30g0b_72h'; ...
                pre', cond30g0b_0h', cond30g50b_24h', cond30g50b_72h' ];
            
            condMatrix = [ ones(size(cond0g0b_24h))'; ...
                2*ones(size(cond0g50b_24h))'; ...
                3*ones(size(cond30g0b_24h))'; ...
                4*ones(size(cond30g50b_24h))' ];
            
            myTable = table(dataMatrix(:,1), dataMatrix(:,2), dataMatrix(:,3), dataMatrix(:,4), categorical(condMatrix),...
                'VariableNames',{'pre','post0h','post24h','post72h','bgluTreat'});
            
            % Define the within subject parameter (pre, during, post)
            Time = [1; 2; 3; 4];
            myTime = array2table(categorical(Time),'VariableNames',{'divGroup'});
            
            rm = fitrm(myTable, 'pre-post72h~bgluTreat', ...
                'WithinDesign', myTime);
            
            [tbl, btwnSubj, wthnSubj, hypVal] = ranova(rm, 'WithinModel', 'divGroup');
            
            [cDIVbyBGLU] = multcompare(rm,'bgluTreat','By','divGroup'); % * * * THIS IS IT ! ! ! * * * %
            [cBGLUbyDIV] = multcompare(rm,'divGroup','By','bgluTreat'); % * * * THIS IS IT ! ! ! * * * %
            
            disp('')
            for kk=1:size(cDIVbyBGLU,1)
                thisP = table2array(cDIVbyBGLU(kk,6));
                if thisP<0.10
                    col1 = table2cell(cDIVbyBGLU(kk,1));
                    temp1_1 = cellstr(col1{1});
                    temp1_2 = temp1_1{1};
                    if strcmp(temp1_2,'1')
                        disp1 = 'pre';
                    elseif strcmp(temp1_2,'2')
                        disp1 = '0h';
                    elseif strcmp(temp1_2,'3')
                        disp1 = '24h';
                    elseif strcmp(temp1_2,'4')
                        disp1 = '72h';
                    end %if strcmp
                    
                    col2 = table2cell(cDIVbyBGLU(kk,2));
                    temp2_1 = cellstr(col2{1});
                    temp2_2 = temp2_1{1};
                    if strcmp(temp2_2,'1')
                        disp2 = 'cond0g0b';
                    elseif strcmp(temp2_2,'2')
                        disp2 = 'cond0g50b';
                    elseif strcmp(temp2_2,'3')
                        disp2 = 'cond30g0b';
                    elseif strcmp(temp2_2,'4')
                        disp2 = 'cond30g50b';
                    end %if strcmp
                    
                    col3 = table2cell(cDIVbyBGLU(kk,3));
                    temp3_1 = cellstr(col3{1});
                    temp3_2 = temp3_1{1};
                    if strcmp(temp3_2,'1')
                        disp3 = 'cond0g0b';
                    elseif strcmp(temp3_2,'2')
                        disp3 = 'cond0g50b';
                    elseif strcmp(temp3_2,'3')
                        disp3 = 'cond30g0b';
                    elseif strcmp(temp3_2,'4')
                        disp3 = 'cond30g50b';
                    end %if strcmp
                    
                    disp('')
                    %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
                    %                 ' & ',cellstr(col3{1}),', p=',num2str(thisP)];
                    %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
                    %                 dispThis{5},dispThis{6},dispThis{7}]);
                    disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thisP)]);
                end %if thisP
            end %for kk
            for kk=1:size(cBGLUbyDIV,1)
                thatP = table2array(cBGLUbyDIV(kk,6));
                if thatP<0.10
                    col1 = table2cell(cBGLUbyDIV(kk,1));
                    temp1_1 = cellstr(col1{1});
                    temp1_2 = temp1_1{1};
                    if strcmp(temp1_2,'1')
                        disp1 = 'cond0g0b';
                    elseif strcmp(temp1_2,'2')
                        disp1 = 'cond0g50b';
                    elseif strcmp(temp1_2,'3')
                        disp1 = 'cond30g0b';
                    elseif strcmp(temp1_2,'4')
                        disp1 = 'cond30g50b';
                    end %if strcmp
                    
                    col2 = table2cell(cBGLUbyDIV(kk,2));
                    temp2_1 = cellstr(col2{1});
                    temp2_2 = temp2_1{1};
                    if strcmp(temp2_2,'1')
                        disp2 = 'pre';
                    elseif strcmp(temp2_2,'2')
                        disp2 = '0h';
                    elseif strcmp(temp2_2,'3')
                        disp2 = '24h';
                    elseif strcmp(temp2_2,'4')
                        disp2 = '72h';
                    end %if strcmp
                    
                    col3 = table2cell(cBGLUbyDIV(kk,3));
                    temp3_1 = cellstr(col3{1});
                    temp3_2 = temp3_1{1};
                    if strcmp(temp3_2,'1')
                        disp3 = 'pre';
                    elseif strcmp(temp3_2,'2')
                        disp3 = '0h';
                    elseif strcmp(temp3_2,'3')
                        disp3 = '24h';
                    elseif strcmp(temp3_2,'4')
                        disp3 = '72h';
                    end %if strcmp
                    
                    disp('')
                    %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
                    %                 ' & ',cellstr(col3{1}),', p=',num2str(thatP)];
                    %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
                    %                 dispThis{5},dispThis{6},dispThis{7}]);
                    disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thatP)]);
                end %if thatP
            end %for kk
            
        elseif strcmp(thisField(1:6),'norm0h')
            % % % RM ANOVA
            
            dataMatrix = [ cond0g0b_24h', cond0g0b_72h'; ...
                cond0g50b_24h', cond0g50b_72h'; ...
                cond30g0b_24h', cond30g0b_72h'; ...
                cond30g50b_24h', cond30g50b_72h' ];
            
            condMatrix = [ ones(size(cond0g0b_24h))'; ...
                2*ones(size(cond0g50b_24h))'; ...
                3*ones(size(cond30g0b_24h))'; ...
                4*ones(size(cond30g50b_24h))' ];
            
            myTable = table(dataMatrix(:,1), dataMatrix(:,2), categorical(condMatrix),...
                'VariableNames',{'post24h','post72h','bgluTreat'});
            
            % Define the within subject parameter (pre, during, post)
            Time = [1; 2];
            myTime = array2table(categorical(Time),'VariableNames',{'divGroup'});
            
            rm = fitrm(myTable, 'post24h-post72h~bgluTreat', ...
                'WithinDesign', myTime);
            
            [tbl, btwnSubj, wthnSubj, hypVal] = ranova(rm, 'WithinModel', 'divGroup');
            
            [cDIVbyBGLU] = multcompare(rm,'bgluTreat','By','divGroup'); % * * * THIS IS IT ! ! ! * * * %
            [cBGLUbyDIV] = multcompare(rm,'divGroup','By','bgluTreat'); % * * * THIS IS IT ! ! ! * * * %
            
            disp('')
            for kk=1:size(cDIVbyBGLU,1)
                thisP = table2array(cDIVbyBGLU(kk,6));
                if thisP<0.10
                    col1 = table2cell(cDIVbyBGLU(kk,1));
                    temp1_1 = cellstr(col1{1});
                    temp1_2 = temp1_1{1};
                    if strcmp(temp1_2,'1')
                        disp1 = '24h';
                    elseif strcmp(temp1_2,'2')
                        disp1 = '72h';
                    end %if strcmp
                    
                    col2 = table2cell(cDIVbyBGLU(kk,2));
                    temp2_1 = cellstr(col2{1});
                    temp2_2 = temp2_1{1};
                    if strcmp(temp2_2,'1')
                        disp2 = 'cond0g0b';
                    elseif strcmp(temp2_2,'2')
                        disp2 = 'cond0g50b';
                    elseif strcmp(temp2_2,'3')
                        disp2 = 'cond30g0b';
                    elseif strcmp(temp2_2,'4')
                        disp2 = 'cond30g50b';
                    end %if strcmp
                    
                    col3 = table2cell(cDIVbyBGLU(kk,3));
                    temp3_1 = cellstr(col3{1});
                    temp3_2 = temp3_1{1};
                    if strcmp(temp3_2,'1')
                        disp3 = 'cond0g0b';
                    elseif strcmp(temp3_2,'2')
                        disp3 = 'cond0g50b';
                    elseif strcmp(temp3_2,'3')
                        disp3 = 'cond30g0b';
                    elseif strcmp(temp3_2,'4')
                        disp3 = 'cond30g50b';
                    end %if strcmp
                    
                    disp('')
                    %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
                    %                 ' & ',cellstr(col3{1}),', p=',num2str(thisP)];
                    %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
                    %                 dispThis{5},dispThis{6},dispThis{7}]);
                    disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thisP)]);
                end %if thisP
            end %for kk
            for kk=1:size(cBGLUbyDIV,1)
                thatP = table2array(cBGLUbyDIV(kk,6));
                if thatP<0.10
                    col1 = table2cell(cBGLUbyDIV(kk,1));
                    temp1_1 = cellstr(col1{1});
                    temp1_2 = temp1_1{1};
                    if strcmp(temp1_2,'1')
                        disp1 = 'cond0g0b';
                    elseif strcmp(temp1_2,'2')
                        disp1 = 'cond0g50b';
                    elseif strcmp(temp1_2,'3')
                        disp1 = 'cond30g0b';
                    elseif strcmp(temp1_2,'4')
                        disp1 = 'cond30g50b';
                    end %if strcmp
                    
                    col2 = table2cell(cBGLUbyDIV(kk,2));
                    temp2_1 = cellstr(col2{1});
                    temp2_2 = temp2_1{1};
                    if strcmp(temp2_2,'1')
                        disp2 = '24h';
                    elseif strcmp(temp2_2,'2')
                        disp2 = '72h';
                    end %if strcmp
                    
                    col3 = table2cell(cBGLUbyDIV(kk,3));
                    temp3_1 = cellstr(col3{1});
                    temp3_2 = temp3_1{1};
                    if strcmp(temp3_2,'1')
                        disp3 = '24h';
                    elseif strcmp(temp3_2,'2')
                        disp3 = '72h';
                    end %if strcmp
                    
                    disp('')
                    %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
                    %                 ' & ',cellstr(col3{1}),', p=',num2str(thatP)];
                    %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
                    %                 dispThis{5},dispThis{6},dispThis{7}]);
                    disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thatP)]);
                end %if thatP
            end %for kk
            
        elseif strcmp(thisField(1:7),'normPre')
            % % % RM ANOVA
            
            dataMatrix = [ cond0g0b_0h', cond0g0b_24h', cond0g0b_72h'; ...
                cond0g0b_0h', cond0g50b_24h', cond0g50b_72h'; ...
                cond30g0b_0h', cond30g0b_24h', cond30g0b_72h'; ...
                cond30g0b_0h', cond30g50b_24h', cond30g50b_72h' ];
            
            condMatrix = [ ones(size(cond0g0b_24h))'; ...
                2*ones(size(cond0g50b_24h))'; ...
                3*ones(size(cond30g0b_24h))'; ...
                4*ones(size(cond30g50b_24h))' ];
            
            myTable = table(dataMatrix(:,1), dataMatrix(:,2), dataMatrix(:,3), categorical(condMatrix),...
                'VariableNames',{'post0h','post24h','post72h','bgluTreat'});
            
            % Define the within subject parameter (pre, during, post)
            Time = [1; 2; 3];
            myTime = array2table(categorical(Time),'VariableNames',{'divGroup'});
            
            rm = fitrm(myTable, 'post0h-post72h~bgluTreat', ...
                'WithinDesign', myTime);
            
            [tbl, btwnSubj, wthnSubj, hypVal] = ranova(rm, 'WithinModel', 'divGroup');
            
            [cDIVbyBGLU] = multcompare(rm,'bgluTreat','By','divGroup'); % * * * THIS IS IT ! ! ! * * * %
            [cBGLUbyDIV] = multcompare(rm,'divGroup','By','bgluTreat'); % * * * THIS IS IT ! ! ! * * * %
            
            disp('')
            for kk=1:size(cDIVbyBGLU,1)
                thisP = table2array(cDIVbyBGLU(kk,6));
                if thisP<0.10
                    col1 = table2cell(cDIVbyBGLU(kk,1));
                    temp1_1 = cellstr(col1{1});
                    temp1_2 = temp1_1{1};
                    if strcmp(temp1_2,'1')
                        disp1 = '0h';
                    elseif strcmp(temp1_2,'2')
                        disp1 = '24h';
                    elseif strcmp(temp1_2,'3')
                        disp1 = '72h';
                    end %if strcmp
                    
                    col2 = table2cell(cDIVbyBGLU(kk,2));
                    temp2_1 = cellstr(col2{1});
                    temp2_2 = temp2_1{1};
                    if strcmp(temp2_2,'1')
                        disp2 = 'cond0g0b';
                    elseif strcmp(temp2_2,'2')
                        disp2 = 'cond0g50b';
                    elseif strcmp(temp2_2,'3')
                        disp2 = 'cond30g0b';
                    elseif strcmp(temp2_2,'4')
                        disp2 = 'cond30g50b';
                    end %if strcmp
                    
                    col3 = table2cell(cDIVbyBGLU(kk,3));
                    temp3_1 = cellstr(col3{1});
                    temp3_2 = temp3_1{1};
                    if strcmp(temp3_2,'1')
                        disp3 = 'cond0g0b';
                    elseif strcmp(temp3_2,'2')
                        disp3 = 'cond0g50b';
                    elseif strcmp(temp3_2,'3')
                        disp3 = 'cond30g0b';
                    elseif strcmp(temp3_2,'4')
                        disp3 = 'cond30g50b';
                    end %if strcmp
                    
                    disp('')
                    %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
                    %                 ' & ',cellstr(col3{1}),', p=',num2str(thisP)];
                    %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
                    %                 dispThis{5},dispThis{6},dispThis{7}]);
                    disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thisP)]);
                end %if thisP
            end %for kk
            for kk=1:size(cBGLUbyDIV,1)
                thatP = table2array(cBGLUbyDIV(kk,6));
                if thatP<0.10
                    col1 = table2cell(cBGLUbyDIV(kk,1));
                    temp1_1 = cellstr(col1{1});
                    temp1_2 = temp1_1{1};
                    if strcmp(temp1_2,'1')
                        disp1 = 'cond0g0b';
                    elseif strcmp(temp1_2,'2')
                        disp1 = 'cond0g50b';
                    elseif strcmp(temp1_2,'3')
                        disp1 = 'cond30g0b';
                    elseif strcmp(temp1_2,'4')
                        disp1 = 'cond30g50b';
                    end %if strcmp
                    
                    col2 = table2cell(cBGLUbyDIV(kk,2));
                    temp2_1 = cellstr(col2{1});
                    temp2_2 = temp2_1{1};
                    if strcmp(temp2_2,'1')
                        disp2 = '0h';
                    elseif strcmp(temp2_2,'2')
                        disp2 = '24h';
                    elseif strcmp(temp2_2,'3')
                        disp2 = '72h';
                    end %if strcmp
                    
                    col3 = table2cell(cBGLUbyDIV(kk,3));
                    temp3_1 = cellstr(col3{1});
                    temp3_2 = temp3_1{1};
                    if strcmp(temp3_2,'1')
                        disp3 = '0h';
                    elseif strcmp(temp3_2,'2')
                        disp3 = '24h';
                    elseif strcmp(temp3_2,'3')
                        disp3 = '72h';
                    end %if strcmp
                    
                    disp('')
                    %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
                    %                 ' & ',cellstr(col3{1}),', p=',num2str(thatP)];
                    %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
                    %                 dispThis{5},dispThis{6},dispThis{7}]);
                    disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thatP)]);
                end %if thatP
            end %for kk
            
        end %if strcmp
        
        % store everything
        plotDataTable.(figName).(thisField) = myTable;
        theRM.(figName).(thisField) = rm;
        theTbl.(figName).(thisField) = tbl;
        theBtwnSubj.(figName).(thisField) = btwnSubj;
        theWthnSubj.(figName).(thisField) = wthnSubj;
        theHypVal.(figName).(thisField) = hypVal;
        
        theCDIVbyBGLU.(figName).(thisField) = cDIVbyBGLU;
        theBGLUbyDIV.(figName).(thisField) = cBGLUbyDIV;
        
        saveas(myFig,[figDir,figName,thisField,'.fig']);
        saveas(myFig,[figDir,figName,thisField,'.svg']);
        try
            saveas(myFig,[figDir,figName,thisField,'.png']);
        catch
            disp('could not save this fig as *.png');
        end %try
        close(myFig);
    end %for jj
    
end %for ii

save([figDir, 'cellDeath_final_revision.mat'],'numCells', 'pixData', 'bpData', ...
    'plotDataTable', 'theRM', 'theTbl', 'theBtwnSubj', 'theWthnSubj', ...
    'theHypVal', 'theCDIVbyBGLU', 'theBGLUbyDIV');

