%plotWesternData_final.m

%% section 1 -- plot without outliers
clc; clear all; close all;

theDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\MEA papers -- addl experiments\EXP for BDNF dose response\final NEW results from Srini\';
figDir = [theDir,'final_forPaper\'];

theFile = ['bdnfWesternData_plotNoOutliers.mat'];
load([theDir,theFile]);

rawFig = figure('Position',[325.8,173,1000.8,420]);

xLocs = [1:1:7];
numSets = size(hippo.plot.raw,1);
sz = 0.25;
xJitt = (sz*0.75)*rand(numSets,1) - 0.5*(sz*0.75);

for ii=1:length(xLocs)
    Yhc = hippo.plot.raw(:,ii);

    theCI95hc = hippo.ci95.raw(1,ii);
    
    Xhc = xLocs(ii)-sz;
    RECThc = rectangle('Position', [Xhc mean(Yhc)-theCI95hc 2*sz 2*theCI95hc], 'FaceColor',[0.7 0.7 0.7], 'EdgeColor', 'none');
    hold on;
    
    if ii==1
        div07 = Yhc;
    elseif ii==2
        div10_0B = Yhc;
    elseif ii==3
        div17_0B = Yhc;
    elseif ii==4
        div10_25B = Yhc;
    elseif ii==5
        div17_25B = Yhc;
    elseif ii==6
        div10_50B = Yhc;
    elseif ii==7
        div17_50B = Yhc;
    end %if ii
end %for ii
for ii=1:length(xLocs)
    plot([xLocs(ii)-sz,xLocs(ii)+sz],[mean(hippo.plot.raw(:,ii)) mean(hippo.plot.raw(:,ii))],'color',[0 0 0],'linewidth',3);
    hold on;
end %for ii
for ii=1:numSets
    scatter(xLocs+xJitt(ii),hippo.plot.raw(ii,:),'filled');
    hold on;
end %for ii
xticks(xLocs);
xlim([xLocs(1)-1 xLocs(end)+1]);
xticklabels({'0 ng/ml', '0 ng/ml', '25 ng/ml', '50 ng/ml', '0 ng/ml', '25 ng/ml', '50 ng/ml'});
set(gca,'tickdir','out','fontweight','bold');
ylabel('p-TrkB/t-TrkB');
title('hippocampal data -- raw');

saveas(rawFig, [figDir,'rawData_elimOuts.fig']);
saveas(rawFig, [figDir,'rawData_elimOuts.svg']);
saveas(rawFig, [figDir,'rawData_elimOuts.png']);

close(rawFig);

% % % RM ANOVA
disp(['RM ANOVA RAW']);

dataMatrix = [ div07, div10_0B, div17_0B; ...
    div07, div10_25B, div17_25B; ...
    div07, div10_50B, div17_50B ];

condMatrix = [ ones(size(div10_0B)); ...
    2*ones(size(div10_25B)); ...
    3*ones(size(div10_50B)) ];

myTable = table(dataMatrix(:,1), dataMatrix(:,2), dataMatrix(:,3), categorical(condMatrix),...
    'VariableNames',{'div07','div10','div17','bdnfTreat'});

% Define the within subject parameter (pre, during, post)
Time = [1; 2; 3];
myTime = array2table(categorical(Time),'VariableNames',{'divGroup'});

rm = fitrm(myTable, 'div07-div17~bdnfTreat', ...
    'WithinDesign', myTime);

[tbl, btwnSubj, wthnSubj, hypVal] = ranova(rm, 'WithinModel', 'divGroup');

[cDIVbyBDNF] = multcompare(rm,'bdnfTreat','By','divGroup'); % * * * THIS IS IT ! ! ! * * * %
[cBDNFbyDIV] = multcompare(rm,'divGroup','By','bdnfTreat'); % * * * THIS IS IT ! ! ! * * * %

disp('')
for jj=1:size(cDIVbyBDNF,1)
    thisP = table2array(cDIVbyBDNF(jj,6));
    if thisP<0.10
        col1 = table2cell(cDIVbyBDNF(jj,1));
        temp1_1 = cellstr(col1{1});
        temp1_2 = temp1_1{1};
        if strcmp(temp1_2,'1')
            disp1 = 'div07raw';
        elseif strcmp(temp1_2,'2')
            disp1 = 'div10raw';
        elseif strcmp(temp1_2,'3')
            disp1 = 'div17raw';
        end %if strcmp
        
        col2 = table2cell(cDIVbyBDNF(jj,2));
        temp2_1 = cellstr(col2{1});
        temp2_2 = temp2_1{1};
        if strcmp(temp2_2,'1')
            disp2 = '0B';
        elseif strcmp(temp2_2,'2')
            disp2 = '25B';
        elseif strcmp(temp2_2,'3')
            disp2 = '50B';
        end %if strcmp
        
        col3 = table2cell(cDIVbyBDNF(jj,3));
        temp3_1 = cellstr(col3{1});
        temp3_2 = temp3_1{1};
        if strcmp(temp3_2,'1')
            disp3 = '0B';
        elseif strcmp(temp3_2,'2')
            disp3 = '25B';
        elseif strcmp(temp3_2,'3')
            disp3 = '50B';
        end %if strcmp
        
        disp('')
        %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
        %                 ' & ',cellstr(col3{1}),', p=',num2str(thisP)];
        %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
        %                 dispThis{5},dispThis{6},dispThis{7}]);
        disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thisP)]);
    end %if thisP
end %for jj
for kk=1:size(cBDNFbyDIV,1)
    thatP = table2array(cBDNFbyDIV(kk,6));
    if thatP<0.10
        col1 = table2cell(cBDNFbyDIV(kk,1));
        temp1_1 = cellstr(col1{1});
        temp1_2 = temp1_1{1};
        if strcmp(temp1_2,'1')
            disp1 = '0B';
        elseif strcmp(temp1_2,'2')
            disp1 = '25B';
        elseif strcmp(temp1_2,'3')
            disp1 = '50B';
        end %if strcmp
        
        col2 = table2cell(cBDNFbyDIV(kk,2));
        temp2_1 = cellstr(col2{1});
        temp2_2 = temp2_1{1};
        if strcmp(temp2_2,'1')
            disp2 = 'div07';
        elseif strcmp(temp2_2,'2')
            disp2 = 'div10raw';
        elseif strcmp(temp2_2,'3')
            disp2 = 'div17raw';
        end %if strcmp
        
        col3 = table2cell(cBDNFbyDIV(kk,3));
        temp3_1 = cellstr(col3{1});
        temp3_2 = temp3_1{1};
        if strcmp(temp3_2,'1')
            disp3 = 'div07';
        elseif strcmp(temp3_2,'2')
            disp3 = 'div10raw';
        elseif strcmp(temp3_2,'3')
            disp3 = 'div17raw';
        end %if strcmp
        
        disp('')
        %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
        %                 ' & ',cellstr(col3{1}),', p=',num2str(thatP)];
        %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
        %                 dispThis{5},dispThis{6},dispThis{7}]);
        disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thatP)]);
    end %if thatP
end %for kk

% store everything
plotDataTable.hippo.raw = myTable;
theRM.hippo.raw = rm;
theTbl.hippo.raw = tbl;
theBtwnSubj.hippo.raw = btwnSubj;
theWthnSubj.hippo.raw = wthnSubj;
theHypVal.hippo.raw = hypVal;

theCDIVbyBDNF.hippo.raw = cDIVbyBDNF;
theCBDNFbyDIV.hippo.raw = cBDNFbyDIV;






normFig = figure('Position',[250.6,189.8,841.6,420]);

xLocs = [1:1:6];
numSets = size(hippo.plot.norm,1);
sz = 0.25;
xJitt = (sz*0.75)*rand(numSets,1) - 0.5*(sz*0.75);

for ii=1:length(xLocs)
    Yhc = hippo.plot.norm(:,ii);

    theCI95hc = hippo.ci95.norm(1,ii);
    
    Xhc = xLocs(ii)-sz;
    RECThc = rectangle('Position', [Xhc mean(Yhc)-theCI95hc 2*sz 2*theCI95hc], 'FaceColor',[0.7 0.7 0.7], 'EdgeColor', 'none');
    hold on;
    
    if ii==1
        div10_0B = Yhc;
    elseif ii==2
        div17_0B = Yhc;
    elseif ii==3
        div10_25B = Yhc;
    elseif ii==4
        div17_25B = Yhc;
    elseif ii==5
        div10_50B = Yhc;
    elseif ii==6
        div17_50B = Yhc;
    end %if ii

end %for ii
for ii=1:length(xLocs)
    plot([xLocs(ii)-sz,xLocs(ii)+sz],[mean(hippo.plot.norm(:,ii)) mean(hippo.plot.norm(:,ii))],'color',[0 0 0],'linewidth',3);
    hold on;
end %for ii
for ii=1:numSets
    scatter(xLocs+xJitt(ii),hippo.plot.norm(ii,:),'filled');
    hold on;
end %for ii
xticks(xLocs);
xlim([xLocs(1)-1 xLocs(end)+1]);
xticklabels({'0 ng/ml', '25 ng/ml', '50 ng/ml', '0 ng/ml', '25 ng/ml', '50 ng/ml'});
set(gca,'tickdir','out','fontweight','bold');
ylabel(sprintf('p-TrkB/t-TrkB \n(norm. to DIV 07)'));
title('hippocampal data -- norm');

saveas(normFig, [figDir,'normData_elimOuts.fig']);
saveas(normFig, [figDir,'normData_elimOuts.svg']);
saveas(normFig, [figDir,'normData_elimOuts.png']);
close(normFig);


% % % RM ANOVA
disp(['RM ANOVA NORM']);

dataMatrix = [ div10_0B, div17_0B; ...
    div10_25B, div17_25B; ...
    div10_50B, div17_50B ];

condMatrix = [ ones(size(div10_0B)); ...
    2*ones(size(div10_25B)); ...
    3*ones(size(div10_50B)) ];

myTable = table(dataMatrix(:,1), dataMatrix(:,2), categorical(condMatrix),...
    'VariableNames',{'div10','div17','bdnfTreat'});

% Define the within subject parameter (pre, during, post)
Time = [1; 2];
myTime = array2table(categorical(Time),'VariableNames',{'divGroup'});

rm = fitrm(myTable, 'div10-div17~bdnfTreat', ...
    'WithinDesign', myTime);

[tbl, btwnSubj, wthnSubj, hypVal] = ranova(rm, 'WithinModel', 'divGroup');

[cDIVbyBDNF] = multcompare(rm,'bdnfTreat','By','divGroup'); % * * * THIS IS IT ! ! ! * * * %
[cBDNFbyDIV] = multcompare(rm,'divGroup','By','bdnfTreat'); % * * * THIS IS IT ! ! ! * * * %

disp('')
for jj=1:size(cDIVbyBDNF,1)
    thisP = table2array(cDIVbyBDNF(jj,6));
    if thisP<0.10
        col1 = table2cell(cDIVbyBDNF(jj,1));
        temp1_1 = cellstr(col1{1});
        temp1_2 = temp1_1{1};
        if strcmp(temp1_2,'1')
            disp1 = 'div10norm';
        elseif strcmp(temp1_2,'2')
            disp1 = 'div17norm';
        end %if strcmp
        
        col2 = table2cell(cDIVbyBDNF(jj,2));
        temp2_1 = cellstr(col2{1});
        temp2_2 = temp2_1{1};
        if strcmp(temp2_2,'1')
            disp2 = '0B';
        elseif strcmp(temp2_2,'2')
            disp2 = '25B';
        elseif strcmp(temp2_2,'3')
            disp2 = '50B';
        end %if strcmp
        
        col3 = table2cell(cDIVbyBDNF(jj,3));
        temp3_1 = cellstr(col3{1});
        temp3_2 = temp3_1{1};
        if strcmp(temp3_2,'1')
            disp3 = '0B';
        elseif strcmp(temp3_2,'2')
            disp3 = '25B';
        elseif strcmp(temp3_2,'3')
            disp3 = '50B';
        end %if strcmp
        
        disp('')
        %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
        %                 ' & ',cellstr(col3{1}),', p=',num2str(thisP)];
        %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
        %                 dispThis{5},dispThis{6},dispThis{7}]);
        disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thisP)]);
    end %if thisP
end %for jj
for kk=1:size(cBDNFbyDIV,1)
    thatP = table2array(cBDNFbyDIV(kk,6));
    if thatP<0.10
        col1 = table2cell(cBDNFbyDIV(kk,1));
        temp1_1 = cellstr(col1{1});
        temp1_2 = temp1_1{1};
        if strcmp(temp1_2,'1')
            disp1 = '0B';
        elseif strcmp(temp1_2,'2')
            disp1 = '25B';
        elseif strcmp(temp1_2,'3')
            disp1 = '50B';
        end %if strcmp
        
        col2 = table2cell(cBDNFbyDIV(kk,2));
        temp2_1 = cellstr(col2{1});
        temp2_2 = temp2_1{1};
        if strcmp(temp2_2,'1')
            disp2 = 'div10norm';
        elseif strcmp(temp2_2,'2')
            disp2 = 'div17norm';
        end %if strcmp
        
        col3 = table2cell(cBDNFbyDIV(kk,3));
        temp3_1 = cellstr(col3{1});
        temp3_2 = temp3_1{1};
        if strcmp(temp3_2,'1')
            disp3 = 'div10norm';
        elseif strcmp(temp3_2,'2')
            disp3 = 'div17norm';
        end %if strcmp
        
        disp('')
        %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
        %                 ' & ',cellstr(col3{1}),', p=',num2str(thatP)];
        %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
        %                 dispThis{5},dispThis{6},dispThis{7}]);
        disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thatP)]);
    end %if thatP
end %for kk

% store everything
plotDataTable.hippo.norm = myTable;
theRM.hippo.norm = rm;
theTbl.hippo.norm = tbl;
theBtwnSubj.hippo.norm = btwnSubj;
theWthnSubj.hippo.norm = wthnSubj;
theHypVal.hippo.norm = hypVal;

theCDIVbyBDNF.hippo.norm = cDIVbyBDNF;
theCBDNFbyDIV.hippo.norm = cBDNFbyDIV;


save([figDir,'bdnfWesternData_plottingFinal.mat'],'hippo',...
    'plotDataTable','theRM','theTbl','theBtwnSubj','theWthnSubj',...
    'theHypVal','theCDIVbyBDNF','theCBDNFbyDIV');

