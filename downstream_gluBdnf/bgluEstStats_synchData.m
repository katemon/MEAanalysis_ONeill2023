% trialEstStats_bgluSynchData.m
% 
% some taken from bgluSynchData_forRM.m
% some taken from trialEstStats_plot_stats.m

%% ESTIMATION STATS METHOD

%% PART 0 (est) - set colors and load data
clc; clear all; close all;

addpath('C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\');%D:\kate_dropbox\Dropbox

myColors(1,:) = [0 0 0]; % black
myColors(2,:) = [0 0 0]; % black
myColors(3,:) = [1 0 0]; % red
myColors(4,:) = [1 0 0]; % red

rawDays = {'div14';'div15';'div17'};

theXlabels = { {'0.1-0.4','0.4-0.7','0.7-1.0'} };

markerSize = 8;

theDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF GLU injury recovery\revision_0g30gonly_newPlots\data\';%D:\kate_dropbox\Dropbox
figDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF GLU injury recovery\revision_0g30gonly_newPlots\data\figs_estStats\';%D:\kate_dropbox\Dropbox

% RAW DATA
load([theDir, 'bgluSynchData_forRM.mat'],'bgluRawSynchData');

%% PART 1 (est) - plot and do stats 

theVars = {'SF147'};
theConds = {'cond0g_0b', 'cond0g_50b', 'cond30g_0b', 'cond30g_50b'};
theSubVars.cat1 = {'SF14','SF47','SF71'};

nIterations = 500;
scattSz = 10;
alpha = 0.05;
jittAmt = 0.5;
xLocs1 = [0.5 1.5 2.5 3.5 5.5 6.5 7.5];
xLocs2 = [0.5 1.5 2.5 3.5];
gMax = 0.5;

markerSize = 8;

ready2save = 0;

% yL1 = [-1.2 -1.2 -1.2];
% yL2 = [ 1.2  1.2  1.2];
% yR1 = [-0.2 -0.4 -0.6];
% yR2 = [ 0.2  0.4  0.6];
% yLtl1 = [-0.25 -0.6 -0.9];
% yLtl2 = [0.05 0.1 0.1];
%
for ii=1:length(theSubVars.cat1)
    
    thisVar = theSubVars.cat1{ii};
    
    div14_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div14.(thisVar).rawCleaned;
    div15_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div15.(thisVar).rawCleaned;
    div17_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div17.(thisVar).rawCleaned;
    
    div14_0g_0b_old = div14_0g_0b;
    div14_0g_0b(isnan(div14_0g_0b_old)) = [];
    div15_0g_0b(isnan(div14_0g_0b_old)) = [];
    div17_0g_0b(isnan(div14_0g_0b_old)) = [];
    div15_0g_0b_old = div15_0g_0b;
    div14_0g_0b(isnan(div15_0g_0b_old)) = [];
    div15_0g_0b(isnan(div15_0g_0b_old)) = [];
    div17_0g_0b(isnan(div15_0g_0b_old)) = [];
    div17_0g_0b_old = div17_0g_0b;
    div14_0g_0b(isnan(div17_0g_0b_old)) = [];
    div15_0g_0b(isnan(div17_0g_0b_old)) = [];
    div17_0g_0b(isnan(div17_0g_0b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_0g_0b_other = div15_0g_0b;
    div17_0g_0b_other = div17_0g_0b;
    [r15_0g_0b,~] = find(div15_0g_0b==0);
    div15_0g_0b_other(r15_0g_0b) = [];
    div17_0g_0b_other(r15_0g_0b) = [];
    
    
    div14_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div14.(thisVar).rawCleaned;
    div15_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div15.(thisVar).rawCleaned;
    div17_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div17.(thisVar).rawCleaned;
    
    div14_0g_50b_old = div14_0g_50b;
    div14_0g_50b(isnan(div14_0g_50b_old)) = [];
    div15_0g_50b(isnan(div14_0g_50b_old)) = [];
    div17_0g_50b(isnan(div14_0g_50b_old)) = [];
    div15_0g_50b_old = div15_0g_50b;
    div14_0g_50b(isnan(div15_0g_50b_old)) = [];
    div15_0g_50b(isnan(div15_0g_50b_old)) = [];
    div17_0g_50b(isnan(div15_0g_50b_old)) = [];
    div17_0g_50b_old = div17_0g_50b;
    div14_0g_50b(isnan(div17_0g_50b_old)) = [];
    div15_0g_50b(isnan(div17_0g_50b_old)) = [];
    div17_0g_50b(isnan(div17_0g_50b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_0g_50b_other = div15_0g_50b;
    div17_0g_50b_other = div17_0g_50b;
    [r15_0g_50b,~] = find(div15_0g_50b==0);
    div15_0g_50b_other(r15_0g_50b) = [];
    div17_0g_50b_other(r15_0g_50b) = [];
    
    
    div14_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div14.(thisVar).rawCleaned;
    div15_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div15.(thisVar).rawCleaned;
    div17_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div17.(thisVar).rawCleaned;
    
    div14_30g_0b_old = div14_30g_0b;
    div14_30g_0b(isnan(div14_30g_0b_old)) = [];
    div15_30g_0b(isnan(div14_30g_0b_old)) = [];
    div17_30g_0b(isnan(div14_30g_0b_old)) = [];
    div15_30g_0b_old = div15_30g_0b;
    div14_30g_0b(isnan(div15_30g_0b_old)) = [];
    div15_30g_0b(isnan(div15_30g_0b_old)) = [];
    div17_30g_0b(isnan(div15_30g_0b_old)) = [];
    div17_30g_0b_old = div17_30g_0b;
    div14_30g_0b(isnan(div17_30g_0b_old)) = [];
    div15_30g_0b(isnan(div17_30g_0b_old)) = [];
    div17_30g_0b(isnan(div17_30g_0b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_30g_0b_other = div15_30g_0b;
    div17_30g_0b_other = div17_30g_0b;
    [r15_30g_0b,~] = find(div15_30g_0b==0);
    div15_30g_0b_other(r15_30g_0b) = [];
    div17_30g_0b_other(r15_30g_0b) = [];
    
    
    div14_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div14.(thisVar).rawCleaned;
    div15_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div15.(thisVar).rawCleaned;
    div17_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div17.(thisVar).rawCleaned;
    
    div14_30g_50b_old = div14_30g_50b;
    div14_30g_50b(isnan(div14_30g_50b_old)) = [];
    div15_30g_50b(isnan(div14_30g_50b_old)) = [];
    div17_30g_50b(isnan(div14_30g_50b_old)) = [];
    div15_30g_50b_old = div15_30g_50b;
    div14_30g_50b(isnan(div15_30g_50b_old)) = [];
    div15_30g_50b(isnan(div15_30g_50b_old)) = [];
    div17_30g_50b(isnan(div15_30g_50b_old)) = [];
    div17_30g_50b_old = div17_30g_50b;
    div14_30g_50b(isnan(div17_30g_50b_old)) = [];
    div15_30g_50b(isnan(div17_30g_50b_old)) = [];
    div17_30g_50b(isnan(div17_30g_50b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_30g_50b_other = div15_30g_50b;
    div17_30g_50b_other = div17_30g_50b;
    [r15_30g_50b,~] = find(div15_30g_50b==0);
    div15_30g_50b_other(r15_30g_50b) = [];
    div17_30g_50b_other(r15_30g_50b) = [];
    
    
    fig1 = figure('Position', [1,41,1280,607.33]);
    left_color = [0 0 0];
    right_color = [0 0 0];
    set(fig1,'defaultAxesColorOrder',[left_color; right_color]);
    fig2 = figure('Position', [480.33,289.67,558.67,288]);
    fig3 = figure('Position', [480.33,289.67,558.67,288]);
    fig4 = figure('Position', [480.33,289.67,558.67,288]);
    
    
    figure(fig2); % inset1
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs2(end)+0.5]);
    xJitt = jittAmt*rand(length(div14_0g_0b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(1),div15_0g_0b-div14_0g_0b,scattSz,'ko');
    xJitt = jittAmt*rand(length(div14_0g_50b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(2),div15_0g_50b-div14_0g_50b,scattSz,'kd');
    xJitt = jittAmt*rand(length(div14_30g_0b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(3),div15_30g_0b-div14_30g_0b,scattSz,'ro');
    xJitt = jittAmt*rand(length(div14_30g_50b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(4),div15_30g_50b-div14_30g_50b,scattSz,'rd');
    %     ylim([yR1(ii) yR2(ii)]);
    
    figure(fig3); % inset2
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs2(end)+0.5]);
    xJitt = jittAmt*rand(length(div14_0g_0b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(1),div17_0g_0b-div14_0g_0b,scattSz,'ko');
    xJitt = jittAmt*rand(length(div14_0g_50b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(2),div17_0g_50b-div14_0g_50b,scattSz,'kd');
    xJitt = jittAmt*rand(length(div14_30g_0b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(3),div17_30g_0b-div14_30g_0b,scattSz,'ro');
    xJitt = jittAmt*rand(length(div14_30g_50b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(4),div17_30g_50b-div14_30g_50b,scattSz,'rd');
    %     ylim([yR1(ii) yR2(ii)]);
    
    figure(fig4); % inset3
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs2(end)+0.5]);
    xJitt = jittAmt*rand(length(div15_0g_0b_other),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(1),div17_0g_0b_other-div15_0g_0b_other,scattSz,'ko');
    xJitt = jittAmt*rand(length(div15_0g_50b_other),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(2),div17_0g_50b_other-div15_0g_50b_other,scattSz,'kd');
    xJitt = jittAmt*rand(length(div15_30g_0b_other),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(3),div17_30g_0b_other-div15_30g_0b_other,scattSz,'ro');
    xJitt = jittAmt*rand(length(div15_30g_50b_other),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(4),div17_30g_50b_other-div15_30g_50b_other,scattSz,'rd');
    %     ylim([yR1(ii) yR2(ii)]);

    
    figure(fig1);
    subplot(3,1,1);
    yyaxis left;
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs1(end)+1]);
    subplot(3,1,2);
    yyaxis left;
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs1(end)+1]);
    subplot(3,1,3);
    yyaxis left;
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs1(end)+1]);
    
    
    figure(fig1);
    subplot(3,1,1); yyaxis left;
    y = (div15_0g_0b./div14_0g_0b).*100;
    x = (div14_0g_0b./div14_0g_0b).*100;
    myFun = @(y,x) mean(y-x);
    ci1_0g_0b = bootci(nIterations,myFun,y,x);
    y = (div15_0g_50b./div14_0g_50b).*100;
    x = (div14_0g_50b./div14_0g_50b).*100;
    myFun = @(y,x) mean(y-x);
    ci1_0g_50b = bootci(nIterations,myFun,y,x);
    y = (div15_30g_0b./div14_30g_0b).*100;
    x = (div14_30g_0b./div14_30g_0b).*100;
    myFun = @(y,x) mean(y-x);
    ci1_30g_0b = bootci(nIterations,myFun,y,x);
    y = (div15_30g_50b./div14_30g_50b).*100;
    x = (div14_30g_50b./div14_30g_50b).*100;
    myFun = @(y,x) mean(y-x);
    ci1_30g_50b = bootci(nIterations,myFun,y,x);
    
    
    plot([xLocs2(1) xLocs2(1)], [ci1_0g_0b(1) ci1_0g_0b(2)],'k-','linewidth',1.25);
    plot([xLocs2(2) xLocs2(2)], [ci1_0g_50b(1) ci1_0g_50b(2)],'k-','linewidth',1.25);
    plot([xLocs2(3) xLocs2(3)], [ci1_30g_0b(1) ci1_30g_0b(2)],'r-','linewidth',1.25);
    plot([xLocs2(4) xLocs2(4)], [ci1_30g_50b(1) ci1_30g_50b(2)],'r-','linewidth',1.25);
    
    % *** *** *** %
    disp([thisVar, ' 24h post vs pre mean % change']);
    disp(['0g 0B: ',num2str(mean(100.*((div15_0g_0b-div14_0g_0b)./div14_0g_0b)))]);
    disp(['0g 50B: ',num2str(mean(100.*((div15_0g_50b-div14_0g_50b)./div14_0g_50b)))]);
    disp(['30g 0B: ',num2str(mean(100.*((div15_30g_0b-div14_30g_0b)./div14_30g_0b)))]);
    disp(['30g 50B: ',num2str(mean(100.*((div15_30g_50b-div14_30g_50b)./div14_30g_50b)))]);
    % *** *** *** %
    plot(xLocs2(1), mean(100.*((div15_0g_0b-div14_0g_0b)./div14_0g_0b)),'ko','markersize',markerSize,'markerfacecolor','k','linewidth',1.75);
    plot(xLocs2(2), mean(100.*((div15_0g_50b-div14_0g_50b)./div14_0g_50b)),'kd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    plot(xLocs2(3), mean(100.*((div15_30g_0b-div14_30g_0b)./div14_30g_0b)),'ro','markersize',markerSize,'markerfacecolor','r','linewidth',1.75);
    plot(xLocs2(4), mean(100.*((div15_30g_50b-div14_30g_50b)./div14_30g_50b)),'rd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    % ylim([yR1(ii) yR2(ii)]); %ylim([yLtl1(ii) yLtl2(ii)]);
    set(gca,'box','off','tickdir','out');
    
    
    % % % differences WITHIN conditions -- bdnfGlu
    disp(thisVar);
    
    dataMatrix = 100.*[ ((div14_0g_0b-div14_0g_0b)./div14_0g_0b), ((div15_0g_0b-div14_0g_0b)./div14_0g_0b), ((div17_0g_0b-div14_0g_0b)./div14_0g_0b); ...
        ((div14_0g_50b-div14_0g_50b)./div14_0g_50b), ((div15_0g_50b-div14_0g_50b)./div14_0g_50b), ((div17_0g_50b-div14_0g_50b)./div14_0g_50b); ...
        ((div14_30g_0b-div14_30g_0b)./div14_30g_0b), ((div15_30g_0b-div14_30g_0b)./div14_30g_0b), ((div17_30g_0b-div14_30g_0b)./div14_30g_0b); ...
        ((div14_30g_50b-div14_30g_50b)./div14_30g_50b), ((div15_30g_50b-div14_30g_50b)./div14_30g_50b), ((div17_30g_50b-div14_30g_50b)./div14_30g_50b) ];
    
    condMatrix = [ ones(size(div14_0g_0b)); ...
        2*ones(size(div14_0g_50b)); ...
        3*ones(size(div14_30g_0b)); ...
        4*ones(size(div14_30g_50b)) ];
    
    myTable = table(dataMatrix(:,1), dataMatrix(:,2), dataMatrix(:,3), categorical(condMatrix),...
        'VariableNames',{'div14','div15','div17','bgluTreat'});
    
    % Define the within subject parameter (pre, during, post)
    Time = [1; 2; 3];
    myTime = array2table(categorical(Time),'VariableNames',{'divGroup'});
    
    rm = fitrm(myTable, 'div14-div17~bgluTreat', ...
        'WithinDesign', myTime);
    
    [tbl, btwnSubj, wthnSubj, hypVal] = ranova(rm, 'WithinModel', 'divGroup');
    
    [cDIVbyBGLU] = multcompare(rm,'bgluTreat','By','divGroup'); % * * * THIS IS IT ! ! ! * * * %
    [cBGLUbyDIV] = multcompare(rm,'divGroup','By','bgluTreat'); % * * * THIS IS IT ! ! ! * * * %
    
    disp('')
    disp('GLU injury + BDNF recovery')
    for jj=1:size(cDIVbyBGLU,1)
        thisP = table2array(cDIVbyBGLU(jj,6));
        if thisP<0.10
            col1 = table2cell(cDIVbyBGLU(jj,1));
            temp1_1 = cellstr(col1{1});
            temp1_2 = temp1_1{1};
            if strcmp(temp1_2,'1')
                disp1 = 'pre';
            elseif strcmp(temp1_2,'2')
                disp1 = '24h post';
            elseif strcmp(temp1_2,'3')
                disp1 = '72h post';
            end %if strcmp
            
            col2 = table2cell(cDIVbyBGLU(jj,2));
            temp2_1 = cellstr(col2{1});
            temp2_2 = temp2_1{1};
            if strcmp(temp2_2,'1')
                disp2 = '0g_0B';
            elseif strcmp(temp2_2,'2')
                disp2 = '0g_50B';
            elseif strcmp(temp2_2,'3')
                disp2 = '30g_0B';
            elseif strcmp(temp2_2,'4')
                disp2 = '30g_50B';
            end %if strcmp
            
            col3 = table2cell(cDIVbyBGLU(jj,3));
            temp3_1 = cellstr(col3{1});
            temp3_2 = temp3_1{1};
            if strcmp(temp3_2,'1')
                disp3 = '0g_0B';
            elseif strcmp(temp3_2,'2')
                disp3 = '0g_50B';
            elseif strcmp(temp3_2,'3')
                disp3 = '30g_0B';
            elseif strcmp(temp3_2,'4')
                disp3 = '30g_50B';
            end %if strcmp
            
            disp('')
            %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
            %                 ' & ',cellstr(col3{1}),', p=',num2str(thisP)];
            %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
            %                 dispThis{5},dispThis{6},dispThis{7}]);
            disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thisP)]);
        end %if thisP
    end %for jj
    for kk=1:size(cBGLUbyDIV,1)
        thatP = table2array(cBGLUbyDIV(kk,6));
        if thatP<0.10
            col1 = table2cell(cBGLUbyDIV(kk,1));
            temp1_1 = cellstr(col1{1});
            temp1_2 = temp1_1{1};
            if strcmp(temp1_2,'1')
                disp1 = '0g_0B';
            elseif strcmp(temp1_2,'2')
                disp1 = '0g_50B';
            elseif strcmp(temp1_2,'3')
                disp1 = '30g_0B';
            elseif strcmp(temp1_2,'4')
                disp1 = '30g_50B';
            end %if strcmp
            
            col2 = table2cell(cBGLUbyDIV(kk,2));
            temp2_1 = cellstr(col2{1});
            temp2_2 = temp2_1{1};
            if strcmp(temp2_2,'1')
                disp2 = 'pre';
            elseif strcmp(temp2_2,'2')
                disp2 = '24h post';
            elseif strcmp(temp2_2,'3')
                disp2 = '72h post';
            end %if strcmp
            
            col3 = table2cell(cBGLUbyDIV(kk,3));
            temp3_1 = cellstr(col3{1});
            temp3_2 = temp3_1{1};
            if strcmp(temp3_2,'1')
                disp3 = 'pre';
            elseif strcmp(temp3_2,'2')
                disp3 = '24h post';
            elseif strcmp(temp3_2,'3')
                disp3 = '72h post';
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
    theDataTable.(thisVar) = myTable;
    theRM.(thisVar) = rm;
    theTbl.(thisVar) = tbl;
    theBtwnSubj.(thisVar) = btwnSubj;
    theWthnSubj.(thisVar) = wthnSubj;
    theHypVal.(thisVar) = hypVal;
    
    theCDIVbyBGLU.(thisVar) = cDIVbyBGLU;
    theCBGLUbyDIV.(thisVar) = cBGLUbyDIV;
    % % % differences WITHIN conditions -- bdnfGlu
    
    
    figure(fig1);
    subplot(3,1,2); yyaxis left;
    y = (div17_0g_0b./div14_0g_0b).*100;
    x = (div14_0g_0b./div14_0g_0b).*100;
    myFun = @(y,x) mean(y-x);
    ci2_0g_0b = bootci(nIterations,myFun,y,x);
    y = (div17_0g_50b./div14_0g_50b).*100;
    x = (div14_0g_50b./div14_0g_50b).*100;
    myFun = @(y,x) mean(y-x);
    ci2_0g_50b = bootci(nIterations,myFun,y,x);
    y = (div17_30g_0b./div14_30g_0b).*100;
    x = (div14_30g_0b./div14_30g_0b).*100;
    myFun = @(y,x) mean(y-x);
    ci2_30g_0b = bootci(nIterations,myFun,y,x);
    y = (div17_30g_50b./div14_30g_50b).*100;
    x = (div14_30g_50b./div14_30g_50b).*100;
    myFun = @(y,x) mean(y-x);
    ci2_30g_50b = bootci(nIterations,myFun,y,x);
    
    
    plot([xLocs2(1) xLocs2(1)], [ci2_0g_0b(1) ci2_0g_0b(2)],'k-','linewidth',1.25);
    plot([xLocs2(2) xLocs2(2)], [ci2_0g_50b(1) ci2_0g_50b(2)],'k-','linewidth',1.25);
    plot([xLocs2(3) xLocs2(3)], [ci2_30g_0b(1) ci2_30g_0b(2)],'r-','linewidth',1.25);
    plot([xLocs2(4) xLocs2(4)], [ci2_30g_50b(1) ci2_30g_50b(2)],'r-','linewidth',1.25);
    
    % *** *** *** %
    disp([thisVar, ' 72h post vs pre mean % change']);
    disp(['0g 0B: ',num2str(mean(100.*((div17_0g_0b-div14_0g_0b)./div14_0g_0b)))]);
    disp(['0g 50B: ',num2str(mean(100.*((div17_0g_50b-div14_0g_50b)./div14_0g_50b)))]);
    disp(['30g 0B: ',num2str(mean(100.*((div17_30g_0b-div14_30g_0b)./div14_30g_0b)))]);
    disp(['30g 50B: ',num2str(mean(100.*((div17_30g_50b-div14_30g_50b)./div14_30g_50b)))]);
    % *** *** *** %
    plot(xLocs2(1), mean(100.*((div17_0g_0b-div14_0g_0b)./div14_0g_0b)),'ko','markersize',markerSize,'markerfacecolor','k','linewidth',1.75);
    plot(xLocs2(2), mean(100.*((div17_0g_50b-div14_0g_50b)./div14_0g_50b)),'kd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    plot(xLocs2(3), mean(100.*((div17_30g_0b-div14_30g_0b)./div14_30g_0b)),'ro','markersize',markerSize,'markerfacecolor','r','linewidth',1.75);
    plot(xLocs2(4), mean(100.*((div17_30g_50b-div14_30g_50b)./div14_30g_50b)),'rd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    %     ylim([yR1(ii) yR2(ii)]); %ylim([yLtl1(ii) yLtl2(ii)]);
    set(gca,'box','off','tickdir','out');
    
    
    figure(fig1);
    subplot(3,1,3); yyaxis left;
    y = (div17_0g_0b_other./div15_0g_0b_other).*100;
    x = (div15_0g_0b_other./div15_0g_0b_other).*100;
    myFun = @(y,x) mean(y-x);
    ci3_0g_0b = bootci(nIterations,myFun,y,x);
    y = (div17_0g_50b_other./div15_0g_50b_other).*100;
    x = (div15_0g_50b_other./div15_0g_50b_other).*100;
    myFun = @(y,x) mean(y-x);
    ci3_0g_50b = bootci(nIterations,myFun,y,x);
    y = (div17_30g_0b_other./div15_30g_0b_other).*100;
    x = (div15_30g_0b_other./div15_30g_0b_other).*100;
    myFun = @(y,x) mean(y-x);
    ci3_30g_0b = bootci(nIterations,myFun,y,x);
    y = (div17_30g_50b_other./div15_30g_50b_other).*100;
    x = (div15_30g_50b_other./div15_30g_50b_other).*100;
    myFun = @(y,x) mean(y-x);
    ci3_30g_50b = bootci(nIterations,myFun,y,x);
    
    plot([xLocs2(1) xLocs2(1)], [ci3_0g_0b(1) ci3_0g_0b(2)],'k-','linewidth',1.25);
    plot([xLocs2(2) xLocs2(2)], [ci3_0g_50b(1) ci3_0g_50b(2)],'k-','linewidth',1.25);
    plot([xLocs2(3) xLocs2(3)], [ci3_30g_0b(1) ci3_30g_0b(2)],'r-','linewidth',1.25);
    plot([xLocs2(4) xLocs2(4)], [ci3_30g_50b(1) ci3_30g_50b(2)],'r-','linewidth',1.25);
    
    % *** *** *** %
    disp([thisVar, ' 72h post vs 24h post mean % change']);
    disp(['0g 0B: ',num2str(mean(100.*((div17_0g_0b_other-div15_0g_0b_other)./div15_0g_0b_other)))]);
    disp(['0g 50B: ',num2str(mean(100.*((div17_0g_50b_other-div15_0g_50b_other)./div15_0g_50b_other)))]);
    disp(['30g 0B: ',num2str(mean(100.*((div17_30g_0b_other-div15_30g_0b_other)./div15_30g_0b_other)))]);
    disp(['30g 50B: ',num2str(mean(100.*((div17_30g_50b_other-div15_30g_50b_other)./div15_30g_50b_other)))]);
    % *** *** *** %
    plot(xLocs2(1), mean(100.*((div17_0g_0b_other-div15_0g_0b_other)./div15_0g_0b_other)),'ko','markersize',markerSize,'markerfacecolor','k','linewidth',1.75);
    plot(xLocs2(2), mean(100.*((div17_0g_50b_other-div15_0g_50b_other)./div15_0g_50b_other)),'kd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    plot(xLocs2(3), mean(100.*((div17_30g_0b_other-div15_30g_0b_other)./div15_30g_0b_other)),'ro','markersize',markerSize,'markerfacecolor','r','linewidth',1.75);
    plot(xLocs2(4), mean(100.*((div17_30g_50b_other-div15_30g_50b_other)./div15_30g_50b_other)),'rd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    %     ylim([yR1(ii) yR2(ii)]); %ylim([yLtl1(ii) yLtl2(ii)]);
    set(gca,'box','off','tickdir','out');
    
    
    figure(fig1);
    subplot(3,1,1);
    yyaxis right;
    % from https://courses.washington.edu/matlab1/Bootstrap_examples.html
%     ylim([yR1(ii) yR2(ii)]);
    plot([xLocs1(5)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    
    
    % 0g0B vs 0g50B
    X1 = ((div15_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div15_0g_50b - div14_0g_50b)./div14_0g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
    disp([thisVar, ' 24h post vs pre, diff in % change']);
    disp(['0g 50B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci1_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(5) xLocs1(5)], [ci1_Diff1(1) ci1_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(5), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi1_Diff1,xi1_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi1_Diff1)/gMax;
    plot(xLocs1(5)+fi1_Diff1/normG, xi1_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond0g50Bvs0g0B';
    thisDiff = 'div15VSdiv14';
    se = (ci1_Diff1(2) - ci1_Diff1(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci1_Diff1;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci1_Diff1(1)<0 && ci1_Diff1(2)<0) || (ci1_Diff1(1)>0 && ci1_Diff1(2)>0) 
        disp(['CIs = [',num2str(ci1_Diff1(1)),', ',num2str(ci1_Diff1(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    
    % 0g0B vs 30g0B
    X1 = ((div15_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div15_30g_0b - div14_30g_0b)./div14_30g_0b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
%     disp([thisVar, ' 24h post vs pre, diff in % change']);
    disp(['30g 0B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci1_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(6) xLocs1(6)], [ci1_Diff2(1) ci1_Diff2(2)],'k-','linewidth',1.25);
    plot(xLocs1(6), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi1_Diff2,xi1_Diff2] = ksdensity(bootstrapStat);
    normG = max(fi1_Diff2)/gMax;
    plot(xLocs1(6)+fi1_Diff2/normG, xi1_Diff2,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g0Bvs0g0B';
    thisDiff = 'div15VSdiv14';
    se = (ci1_Diff2(2) - ci1_Diff2(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci1_Diff2;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci1_Diff2(1)<0 && ci1_Diff2(2)<0) || (ci1_Diff2(1)>0 && ci1_Diff2(2)>0) 
        disp(['CIs = [',num2str(ci1_Diff2(1)),', ',num2str(ci1_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % 0g0B vs 30g50B
    X1 = ((div15_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div15_30g_50b - div14_30g_50b)./div14_30g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
%     disp([thisVar, ' 24h post vs pre, diff in % change']);
    disp(['30g 50B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci1_Diff3 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(7) xLocs1(7)], [ci1_Diff3(1) ci1_Diff3(2)],'k-','linewidth',1.25);
    plot(xLocs1(7), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi1_Diff3,xi1_Diff3] = ksdensity(bootstrapStat);
    normG = max(fi1_Diff3)/gMax;
    plot(xLocs1(7)+fi1_Diff3/normG, xi1_Diff3,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g50Bvs0g0B';
    thisDiff = 'div15VSdiv14';
    se = (ci1_Diff3(2) - ci1_Diff3(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci1_Diff3;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci1_Diff3(1)<0 && ci1_Diff3(2)<0) || (ci1_Diff3(1)>0 && ci1_Diff3(2)>0) 
        disp(['CIs = [',num2str(ci1_Diff3(1)),', ',num2str(ci1_Diff3(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
%     % 30g0B vs 30g50B
%     X1 = ((div15_30g_0b - div14_30g_0b)./div14_30g_0b).*100;
%     n1 = length(X1);
%     X2 = ((div15_30g_50b - div14_30g_50b)./div14_30g_50b).*100;
%     n2 = length(X2);
%     myStatistic = @(X1,X2) mean(X2)-mean(X1);
%     bootstrapStat = zeros(nIterations,1);
%     for jj=1:nIterations
%         sampX1 = X1(ceil(rand(n1,1)*n1));
%         sampX2 = X2(ceil(rand(n2,1)*n2));
%         bootstrapStat(jj) = myStatistic(sampX1,sampX2);
%     end %for jj
%     ci1_Diff4 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
%     plot([xLocs1(10) xLocs1(10)], [ci1_Diff4(1) ci1_Diff4(2)],'k-','linewidth',1.25);
%     plot(xLocs1(10), mean(X2)-mean(X1),'ko','markersize',markerSize,'markerfacecolor',[0.7 0.7 0.7],'linewidth',1.75);
%     [fi1_Diff4,xi1_Diff4] = ksdensity(bootstrapStat);
%     normG = max(fi1_Diff4)/gMax;
%     plot(xLocs1(10)+fi1_Diff4/normG, xi1_Diff4,'k-','linewidth',1.5);

 
    subplot(3,1,2);
    yyaxis right;
%     ylim([yR1(ii) yR2(ii)]);
    plot([xLocs1(5)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    
    % 0g0B vs 0g50B
    X1 = ((div17_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div17_0g_50b - div14_0g_50b)./div14_0g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
    disp([thisVar, ' 72h post vs pre, diff in % change']);
    disp(['0g 50B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci2_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(5) xLocs1(5)], [ci2_Diff1(1) ci2_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(5), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi2_Diff1,xi2_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi2_Diff1)/gMax;
    plot(xLocs1(5)+fi2_Diff1/normG, xi2_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond0g50Bvs0g0B';
    thisDiff = 'div17VSdiv14';
    se = (ci2_Diff1(2) - ci2_Diff1(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci2_Diff1;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci2_Diff1(1)<0 && ci2_Diff1(2)<0) || (ci2_Diff1(1)>0 && ci2_Diff1(2)>0) 
        disp(['CIs = [',num2str(ci2_Diff1(1)),', ',num2str(ci2_Diff1(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % 0g0B vs 30g0B
    X1 = ((div17_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div17_30g_0b - div14_30g_0b)./div14_30g_0b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
%     disp([thisVar, ' 72h post vs pre, diff in % change']);
    disp(['30g 0B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci2_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(6) xLocs1(6)], [ci2_Diff2(1) ci2_Diff2(2)],'k-','linewidth',1.25);
    plot(xLocs1(6), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi2_Diff2,xi2_Diff2] = ksdensity(bootstrapStat);
    normG = max(fi2_Diff2)/gMax;
    plot(xLocs1(6)+fi2_Diff2/normG, xi2_Diff2,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g0Bvs0g0B';
    thisDiff = 'div17VSdiv14';
    se = (ci2_Diff2(2) - ci2_Diff2(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci2_Diff2;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci2_Diff2(1)<0 && ci2_Diff2(2)<0) || (ci2_Diff2(1)>0 && ci2_Diff2(2)>0) 
        disp(['CIs = [',num2str(ci2_Diff2(1)),', ',num2str(ci2_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % 0g0B vs 30g50B
    X1 = ((div17_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div17_30g_50b - div14_30g_50b)./div14_30g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
%     disp([thisVar, ' 72h post vs pre, diff in % change']);
    disp(['30g 50B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci2_Diff3 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(7) xLocs1(7)], [ci2_Diff3(1) ci2_Diff3(2)],'k-','linewidth',1.25);
    plot(xLocs1(7), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi2_Diff3,xi2_Diff3] = ksdensity(bootstrapStat);
    normG = max(fi2_Diff3)/gMax;
    plot(xLocs1(7)+fi2_Diff3/normG, xi2_Diff3,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g50Bvs0g0B';
    thisDiff = 'div17VSdiv14';
    se = (ci2_Diff3(2) - ci2_Diff3(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci2_Diff3;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci2_Diff3(1)<0 && ci2_Diff3(2)<0) || (ci2_Diff3(1)>0 && ci2_Diff3(2)>0) 
        disp(['CIs = [',num2str(ci2_Diff3(1)),', ',num2str(ci2_Diff3(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
%     % 30g0B vs 30g50B
%     X1 = ((div17_30g_0b - div14_30g_0b)./div14_30g_0b).*100;
%     n1 = length(X1);
%     X2 = ((div17_30g_50b - div14_30g_50b)./div14_30g_50b).*100;
%     n2 = length(X2);
%     myStatistic = @(X1,X2) mean(X2)-mean(X1);
%     bootstrapStat = zeros(nIterations,1);
%     for jj=1:nIterations
%         sampX1 = X1(ceil(rand(n1,1)*n1));
%         sampX2 = X2(ceil(rand(n2,1)*n2));
%         bootstrapStat(jj) = myStatistic(sampX1,sampX2);
%     end %for jj
%     ci2_Diff4 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
%     plot([xLocs1(10) xLocs1(10)], [ci2_Diff4(1) ci2_Diff4(2)],'k-','linewidth',1.25);
%     plot(xLocs1(10), mean(X2)-mean(X1),'ko','markersize',markerSize,'markerfacecolor',[0.7 0.7 0.7],'linewidth',1.75);
%     [fi2_Diff4,xi2_Diff4] = ksdensity(bootstrapStat);
%     normG = max(fi2_Diff4)/gMax;
%     plot(xLocs1(10)+fi2_Diff4/normG, xi2_Diff4,'k-','linewidth',1.5);
    
    
    subplot(3,1,3);
    yyaxis right;
%     ylim([yR1(ii) yR2(ii)]);
    plot([xLocs1(5)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    
    
    % 0g0B vs 0g50B
    X2 = ((div17_0g_50b_other - div15_0g_50b_other)./div15_0g_50b_other).*100;
    X1 = ((div17_0g_0b_other - div15_0g_0b_other)./div15_0g_0b_other).*100;
    n1 = length(X1);
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
    disp([thisVar, ' 72h post vs 24h post, diff in % change']);
    disp(['0g 50B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci3_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(5) xLocs1(5)], [ci3_Diff1(1) ci3_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(5), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi3_Diff1,xi3_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi3_Diff1)/gMax;
    plot(xLocs1(5)+fi3_Diff1/normG, xi3_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond0g50Bvs0g0B';
    thisDiff = 'div17VSdiv15';
    se = (ci3_Diff1(2) - ci3_Diff1(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci3_Diff1;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci3_Diff1(1)<0 && ci3_Diff1(2)<0) || (ci3_Diff1(1)>0 && ci3_Diff1(2)>0) 
        disp(['CIs = [',num2str(ci3_Diff1(1)),', ',num2str(ci3_Diff1(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % 0g0B vs 30g0B
    X2 = ((div17_30g_0b_other - div15_30g_0b_other)./div15_30g_0b_other).*100;
    X1 = ((div17_0g_0b_other - div15_0g_0b_other)./div15_0g_0b_other).*100;
    n1 = length(X1);
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
%     disp([thisVar, ' 72h post vs 24h post, diff in % change']);
    disp(['30g 0B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci3_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(6) xLocs1(6)], [ci3_Diff2(1) ci3_Diff2(2)],'k-','linewidth',1.25);
    plot(xLocs1(6), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi3_Diff2,xi3_Diff2] = ksdensity(bootstrapStat);
    normG = max(fi3_Diff2)/gMax;
    plot(xLocs1(6)+fi3_Diff2/normG, xi3_Diff2,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g0Bvs0g0B';
    thisDiff = 'div17VSdiv15';
    se = (ci3_Diff2(2) - ci3_Diff2(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci3_Diff2;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci3_Diff2(1)<0 && ci3_Diff2(2)<0) || (ci3_Diff2(1)>0 && ci3_Diff2(2)>0) 
        disp(['CIs = [',num2str(ci3_Diff2(1)),', ',num2str(ci3_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % 0g0B vs 30g50B
    X2 = ((div17_30g_50b_other - div15_30g_50b_other)./div15_30g_50b_other).*100;
    X1 = ((div17_0g_0b_other - div15_0g_0b_other)./div15_0g_0b_other).*100;
    n1 = length(X1);
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
%     disp([thisVar, ' 72h post vs 24h post, diff in % change']);
    disp(['30g 50B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci3_Diff3 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(7) xLocs1(7)], [ci3_Diff3(1) ci3_Diff3(2)],'k-','linewidth',1.25);
    plot(xLocs1(7), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi3_Diff3,xi3_Diff3] = ksdensity(bootstrapStat);
    normG = max(fi3_Diff3)/gMax;
    plot(xLocs1(7)+fi3_Diff3/normG, xi3_Diff3,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g50Bvs0g0B';
    thisDiff = 'div17VSdiv15';
    se = (ci3_Diff3(2) - ci3_Diff3(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci3_Diff3;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci3_Diff3(1)<0 && ci3_Diff3(2)<0) || (ci3_Diff3(1)>0 && ci3_Diff3(2)>0) 
        disp(['CIs = [',num2str(ci3_Diff3(1)),', ',num2str(ci3_Diff3(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
%     % 30g0B vs 30g50B
%     X1 = ((div17_30g_0b - div15_30g_0b)./div15_30g_0b).*100;
%     n1 = length(X1);
%     X2 = ((div17_30g_50b - div15_30g_50b)./div15_30g_50b).*100;
%     n2 = length(X2);
%     myStatistic = @(X1,X2) mean(X2)-mean(X1);
%     bootstrapStat = zeros(nIterations,1);
%     for jj=1:nIterations
%         sampX1 = X1(ceil(rand(n1,1)*n1));
%         sampX2 = X2(ceil(rand(n2,1)*n2));
%         bootstrapStat(jj) = myStatistic(sampX1,sampX2);
%     end %for jj
%     ci3_Diff4 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
%     plot([xLocs1(10) xLocs1(10)], [ci3_Diff4(1) ci3_Diff4(2)],'k-','linewidth',1.25);
%     plot(xLocs1(10), mean(X2)-mean(X1),'ko','markersize',markerSize,'markerfacecolor',[0.7 0.7 0.7],'linewidth',1.75);
%     [fi3_Diff4,xi3_Diff4] = ksdensity(bootstrapStat);
%     normG = max(fi3_Diff4)/gMax;
%     plot(xLocs1(10)+fi3_Diff4/normG, xi3_Diff4,'k-','linewidth',1.5);
 
    
    for jj=1:3
        subplot(3,1,jj);
        xticks(xLocs1);
        xticklabels({'','','','','',''});
        set(gca,'box','off','tickdir','out');
        set(fig1,'defaultAxesColorOrder',[0 0 0; 0 0 0]);
    end %for jj
    
    for jj=1:3
        subplot(3,1,jj);
        xticks(xLocs1);
        xticklabels({'','','','','',''});
        set(gca,'box','off','tickdir','out');
        set(fig1,'defaultAxesColorOrder',[0 0 0; 0 0 0]);
    end %for jj
    
    if ready2save
        try
            saveas(fig1,[figDir,thisVar,'.png']);
        catch
            disp(['could not save fig1 ',thisVar,'as *.png']);
        end
        saveas(fig1,[figDir,thisVar,'.fig']);
        saveas(fig1,[figDir,thisVar,'.svg']);
        
        try
            saveas(fig2,[figDir,thisVar,'_div15div14.png']);
        catch
            disp(['could not save fig2 ',thisVar,'as *.png']);
        end
        saveas(fig2,[figDir,thisVar,'_div15div14.fig']);
        saveas(fig2,[figDir,thisVar,'_div15div14.svg']);
        
        try
            saveas(fig3,[figDir,thisVar,'_div17div14.png']);
        catch
            disp(['could not save fig3 ',thisVar,'as *.png']);
        end
        saveas(fig3,[figDir,thisVar,'_div17div14.fig']);
        saveas(fig3,[figDir,thisVar,'_div17div14.svg']);
        
        try
            saveas(fig4,[figDir,thisVar,'_div17div15.png']);
        catch
            disp(['could not save fig4 ',thisVar,'as *.png']);
        end
        saveas(fig4,[figDir,thisVar,'_div17div15.fig']);
        saveas(fig4,[figDir,thisVar,'_div17div15.svg']);
    end %if ready2save
    
    close(fig1);
    close(fig2);
    close(fig3);
    close(fig4);
    
end %for ii

wthnStats.theDataTable = theDataTable;
wthnStats.theRM = theRM;
wthnStats.theTbl = theTbl;
wthnStats.theBtwnSubj = theBtwnSubj;
wthnStats.theWthnSubj = theWthnSubj;
wthnStats.theHypVal = theHypVal;
wthnStats.theCDIVbyBGLU = theCDIVbyBGLU;
wthnStats.theCBGLUbyDIV = theCBGLUbyDIV;

btwnStats.theSE = theSE;
btwnStats.theEst = theEst;
btwnStats.theZ = theZ;
btwnStats.theP = theP;
btwnStats.theBootStat = theBootStat;
btwnStats.theCIs = theCIs;

% save([figDir, 'estStats_bgluSynch.mat'], 'wthnStats','btwnStats');

%% PART 2 (est) - plot and do stats - SUBTRACT WITHIN INJURY CONDITIONS 
clc;

theVars = {'SF147'};
theConds = {'cond0g_0b', 'cond0g_50b', 'cond30g_0b', 'cond30g_50b'};
theSubVars.cat1 = {'SF14','SF47','SF71'};

nIterations = 500;
scattSz = 10;
alpha = 0.05;
jittAmt = 0.4;
xLocs1 = [0.5 1.25 2 2.75 4.25 5.25];
xLocs2 = [0.5 1.25 2 2.75];
gMax = 0.5;

markerSize = 8;

ready2save = 0;

% yL1 = [-1.2 -1.2 -1.2];
% yL2 = [ 1.2  1.2  1.2];
% yR1 = [-0.2 -0.4 -0.6];
% yR2 = [ 0.2  0.4  0.6];
% yLtl1 = [-0.25 -0.6 -0.9];
% yLtl2 = [0.05 0.1 0.1];

for ii=1:length(theSubVars.cat1)
    
    thisVar = theSubVars.cat1{ii};
    
    div14_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div14.(thisVar).rawCleaned;
    div15_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div15.(thisVar).rawCleaned;
    div17_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div17.(thisVar).rawCleaned;
    
    div14_0g_0b_old = div14_0g_0b;
    div14_0g_0b(isnan(div14_0g_0b_old)) = [];
    div15_0g_0b(isnan(div14_0g_0b_old)) = [];
    div17_0g_0b(isnan(div14_0g_0b_old)) = [];
    div15_0g_0b_old = div15_0g_0b;
    div14_0g_0b(isnan(div15_0g_0b_old)) = [];
    div15_0g_0b(isnan(div15_0g_0b_old)) = [];
    div17_0g_0b(isnan(div15_0g_0b_old)) = [];
    div17_0g_0b_old = div17_0g_0b;
    div14_0g_0b(isnan(div17_0g_0b_old)) = [];
    div15_0g_0b(isnan(div17_0g_0b_old)) = [];
    div17_0g_0b(isnan(div17_0g_0b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_0g_0b_other = div15_0g_0b;
    div17_0g_0b_other = div17_0g_0b;
    [r15_0g_0b,~] = find(div15_0g_0b==0);
    div15_0g_0b_other(r15_0g_0b) = [];
    div17_0g_0b_other(r15_0g_0b) = [];
    
    
    div14_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div14.(thisVar).rawCleaned;
    div15_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div15.(thisVar).rawCleaned;
    div17_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div17.(thisVar).rawCleaned;
    
    div14_0g_50b_old = div14_0g_50b;
    div14_0g_50b(isnan(div14_0g_50b_old)) = [];
    div15_0g_50b(isnan(div14_0g_50b_old)) = [];
    div17_0g_50b(isnan(div14_0g_50b_old)) = [];
    div15_0g_50b_old = div15_0g_50b;
    div14_0g_50b(isnan(div15_0g_50b_old)) = [];
    div15_0g_50b(isnan(div15_0g_50b_old)) = [];
    div17_0g_50b(isnan(div15_0g_50b_old)) = [];
    div17_0g_50b_old = div17_0g_50b;
    div14_0g_50b(isnan(div17_0g_50b_old)) = [];
    div15_0g_50b(isnan(div17_0g_50b_old)) = [];
    div17_0g_50b(isnan(div17_0g_50b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_0g_50b_other = div15_0g_50b;
    div17_0g_50b_other = div17_0g_50b;
    [r15_0g_50b,~] = find(div15_0g_50b==0);
    div15_0g_50b_other(r15_0g_50b) = [];
    div17_0g_50b_other(r15_0g_50b) = [];
    
    
    div14_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div14.(thisVar).rawCleaned;
    div15_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div15.(thisVar).rawCleaned;
    div17_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div17.(thisVar).rawCleaned;
    
    div14_30g_0b_old = div14_30g_0b;
    div14_30g_0b(isnan(div14_30g_0b_old)) = [];
    div15_30g_0b(isnan(div14_30g_0b_old)) = [];
    div17_30g_0b(isnan(div14_30g_0b_old)) = [];
    div15_30g_0b_old = div15_30g_0b;
    div14_30g_0b(isnan(div15_30g_0b_old)) = [];
    div15_30g_0b(isnan(div15_30g_0b_old)) = [];
    div17_30g_0b(isnan(div15_30g_0b_old)) = [];
    div17_30g_0b_old = div17_30g_0b;
    div14_30g_0b(isnan(div17_30g_0b_old)) = [];
    div15_30g_0b(isnan(div17_30g_0b_old)) = [];
    div17_30g_0b(isnan(div17_30g_0b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_30g_0b_other = div15_30g_0b;
    div17_30g_0b_other = div17_30g_0b;
    [r15_30g_0b,~] = find(div15_30g_0b==0);
    div15_30g_0b_other(r15_30g_0b) = [];
    div17_30g_0b_other(r15_30g_0b) = [];
    
    
    div14_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div14.(thisVar).rawCleaned;
    div15_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div15.(thisVar).rawCleaned;
    div17_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div17.(thisVar).rawCleaned;
    
    div14_30g_50b_old = div14_30g_50b;
    div14_30g_50b(isnan(div14_30g_50b_old)) = [];
    div15_30g_50b(isnan(div14_30g_50b_old)) = [];
    div17_30g_50b(isnan(div14_30g_50b_old)) = [];
    div15_30g_50b_old = div15_30g_50b;
    div14_30g_50b(isnan(div15_30g_50b_old)) = [];
    div15_30g_50b(isnan(div15_30g_50b_old)) = [];
    div17_30g_50b(isnan(div15_30g_50b_old)) = [];
    div17_30g_50b_old = div17_30g_50b;
    div14_30g_50b(isnan(div17_30g_50b_old)) = [];
    div15_30g_50b(isnan(div17_30g_50b_old)) = [];
    div17_30g_50b(isnan(div17_30g_50b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_30g_50b_other = div15_30g_50b;
    div17_30g_50b_other = div17_30g_50b;
    [r15_30g_50b,~] = find(div15_30g_50b==0);
    div15_30g_50b_other(r15_30g_50b) = [];
    div17_30g_50b_other(r15_30g_50b) = [];
    
    
    fig1 = figure('Position', [1,41,1280,607.33]);
    left_color = [0 0 0];
    right_color = [0 0 0];
    set(fig1,'defaultAxesColorOrder',[left_color; right_color]);
    fig2 = figure('Position', [480.33,289.67,558.67,288]);
    fig3 = figure('Position', [480.33,289.67,558.67,288]);
    fig4 = figure('Position', [480.33,289.67,558.67,288]);
    
    
    figure(fig2); % inset1
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs2(end)+0.5]);
    xJitt = jittAmt*rand(length(div14_0g_0b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(1),div15_0g_0b-div14_0g_0b,scattSz,'ko');
    xJitt = jittAmt*rand(length(div14_0g_50b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(2),div15_0g_50b-div14_0g_50b,scattSz,'kd');
    xJitt = jittAmt*rand(length(div14_30g_0b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(3),div15_30g_0b-div14_30g_0b,scattSz,'ro');
    xJitt = jittAmt*rand(length(div14_30g_50b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(4),div15_30g_50b-div14_30g_50b,scattSz,'rd');
    %     ylim([yR1(ii) yR2(ii)]);
    
    figure(fig3); % inset2
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs2(end)+0.5]);
    xJitt = jittAmt*rand(length(div14_0g_0b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(1),div17_0g_0b-div14_0g_0b,scattSz,'ko');
    xJitt = jittAmt*rand(length(div14_0g_50b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(2),div17_0g_50b-div14_0g_50b,scattSz,'kd');
    xJitt = jittAmt*rand(length(div14_30g_0b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(3),div17_30g_0b-div14_30g_0b,scattSz,'ro');
    xJitt = jittAmt*rand(length(div14_30g_50b),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(4),div17_30g_50b-div14_30g_50b,scattSz,'rd');
    %     ylim([yR1(ii) yR2(ii)]);
    
    figure(fig4); % inset3
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs2(end)+0.5]);
    xJitt = jittAmt*rand(length(div15_0g_0b_other),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(1),div17_0g_0b_other-div15_0g_0b_other,scattSz,'ko');
    xJitt = jittAmt*rand(length(div15_0g_50b_other),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(2),div17_0g_50b_other-div15_0g_50b_other,scattSz,'kd');
    xJitt = jittAmt*rand(length(div15_30g_0b_other),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(3),div17_30g_0b_other-div15_30g_0b_other,scattSz,'ro');
    xJitt = jittAmt*rand(length(div15_30g_50b_other),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(4),div17_30g_50b_other-div15_30g_50b_other,scattSz,'rd');
    %     ylim([yR1(ii) yR2(ii)]);
    

    figure(fig1);
    subplot(3,1,1);
    yyaxis left;
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs1(end)+1]);
    subplot(3,1,2);
    yyaxis left;
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs1(end)+1]);
    subplot(3,1,3);
    yyaxis left;
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs1(end)+1]);
    
    
    figure(fig1);
    subplot(3,1,1); yyaxis left;
    y = (div15_0g_0b./div14_0g_0b).*100;
    x = (div14_0g_0b./div14_0g_0b).*100;
    myFun = @(y,x) mean(y-x);
    ci1_0g_0b = bootci(nIterations,myFun,y,x);
    y = (div15_0g_50b./div14_0g_50b).*100;
    x = (div14_0g_50b./div14_0g_50b).*100;
    myFun = @(y,x) mean(y-x);
    ci1_0g_50b = bootci(nIterations,myFun,y,x);
    y = (div15_30g_0b./div14_30g_0b).*100;
    x = (div14_30g_0b./div14_30g_0b).*100;
    myFun = @(y,x) mean(y-x);
    ci1_30g_0b = bootci(nIterations,myFun,y,x);
    y = (div15_30g_50b./div14_30g_50b).*100;
    x = (div14_30g_50b./div14_30g_50b).*100;
    myFun = @(y,x) mean(y-x);
    ci1_30g_50b = bootci(nIterations,myFun,y,x);
    
    
    plot([xLocs2(1) xLocs2(1)], [ci1_0g_0b(1) ci1_0g_0b(2)],'k-','linewidth',1.25);
    plot([xLocs2(2) xLocs2(2)], [ci1_0g_50b(1) ci1_0g_50b(2)],'k-','linewidth',1.25);
    plot([xLocs2(3) xLocs2(3)], [ci1_30g_0b(1) ci1_30g_0b(2)],'r-','linewidth',1.25);
    plot([xLocs2(4) xLocs2(4)], [ci1_30g_50b(1) ci1_30g_50b(2)],'r-','linewidth',1.25);
    
    % *** *** *** %
    disp([thisVar, ' 24h post vs pre mean % change']);
    disp(['0g 0B: ',num2str(mean(100.*((div15_0g_0b-div14_0g_0b)./div14_0g_0b)))]);
    disp(['0g 50B: ',num2str(mean(100.*((div15_0g_50b-div14_0g_50b)./div14_0g_50b)))]);
    disp(['30g 0B: ',num2str(mean(100.*((div15_30g_0b-div14_30g_0b)./div14_30g_0b)))]);
    disp(['30g 50B: ',num2str(mean(100.*((div15_30g_50b-div14_30g_50b)./div14_30g_50b)))]);
    % *** *** *** %
    plot(xLocs2(1), mean(100.*((div15_0g_0b-div14_0g_0b)./div14_0g_0b)),'ko','markersize',markerSize,'markerfacecolor','k','linewidth',1.75);
    plot(xLocs2(2), mean(100.*((div15_0g_50b-div14_0g_50b)./div14_0g_50b)),'kd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    plot(xLocs2(3), mean(100.*((div15_30g_0b-div14_30g_0b)./div14_30g_0b)),'ro','markersize',markerSize,'markerfacecolor','r','linewidth',1.75);
    plot(xLocs2(4), mean(100.*((div15_30g_50b-div14_30g_50b)./div14_30g_50b)),'rd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    % ylim([yR1(ii) yR2(ii)]); %ylim([yLtl1(ii) yLtl2(ii)]);
    set(gca,'box','off','tickdir','out');
    
    
    % % % differences WITHIN conditions -- bdnfGlu
    disp(thisVar);
    
    dataMatrix = 100.*[ ((div14_0g_0b-div14_0g_0b)./div14_0g_0b), ((div15_0g_0b-div14_0g_0b)./div14_0g_0b), ((div17_0g_0b-div14_0g_0b)./div14_0g_0b); ...
        ((div14_0g_50b-div14_0g_50b)./div14_0g_50b), ((div15_0g_50b-div14_0g_50b)./div14_0g_50b), ((div17_0g_50b-div14_0g_50b)./div14_0g_50b); ...
        ((div14_30g_0b-div14_30g_0b)./div14_30g_0b), ((div15_30g_0b-div14_30g_0b)./div14_30g_0b), ((div17_30g_0b-div14_30g_0b)./div14_30g_0b); ...
        ((div14_30g_50b-div14_30g_50b)./div14_30g_50b), ((div15_30g_50b-div14_30g_50b)./div14_30g_50b), ((div17_30g_50b-div14_30g_50b)./div14_30g_50b) ];
    
    condMatrix = [ ones(size(div14_0g_0b)); ...
        2*ones(size(div14_0g_50b)); ...
        3*ones(size(div14_30g_0b)); ...
        4*ones(size(div14_30g_50b)) ];
    
    myTable = table(dataMatrix(:,1), dataMatrix(:,2), dataMatrix(:,3), categorical(condMatrix),...
        'VariableNames',{'div14','div15','div17','bgluTreat'});
    
    % Define the within subject parameter (pre, during, post)
    Time = [1; 2; 3];
    myTime = array2table(categorical(Time),'VariableNames',{'divGroup'});
    
    rm = fitrm(myTable, 'div14-div17~bgluTreat', ...
        'WithinDesign', myTime);
    
    [tbl, btwnSubj, wthnSubj, hypVal] = ranova(rm, 'WithinModel', 'divGroup');
    
    [cDIVbyBGLU] = multcompare(rm,'bgluTreat','By','divGroup'); % * * * THIS IS IT ! ! ! * * * %
    [cBGLUbyDIV] = multcompare(rm,'divGroup','By','bgluTreat'); % * * * THIS IS IT ! ! ! * * * %
    
    disp('')
    disp('GLU injury + BDNF recovery')
    for jj=1:size(cDIVbyBGLU,1)
        thisP = table2array(cDIVbyBGLU(jj,6));
        if thisP<0.10
            col1 = table2cell(cDIVbyBGLU(jj,1));
            temp1_1 = cellstr(col1{1});
            temp1_2 = temp1_1{1};
            if strcmp(temp1_2,'1')
                disp1 = 'pre';
            elseif strcmp(temp1_2,'2')
                disp1 = '24h post';
            elseif strcmp(temp1_2,'3')
                disp1 = '72h post';
            end %if strcmp
            
            col2 = table2cell(cDIVbyBGLU(jj,2));
            temp2_1 = cellstr(col2{1});
            temp2_2 = temp2_1{1};
            if strcmp(temp2_2,'1')
                disp2 = '0g_0B';
            elseif strcmp(temp2_2,'2')
                disp2 = '0g_50B';
            elseif strcmp(temp2_2,'3')
                disp2 = '30g_0B';
            elseif strcmp(temp2_2,'4')
                disp2 = '30g_50B';
            end %if strcmp
            
            col3 = table2cell(cDIVbyBGLU(jj,3));
            temp3_1 = cellstr(col3{1});
            temp3_2 = temp3_1{1};
            if strcmp(temp3_2,'1')
                disp3 = '0g_0B';
            elseif strcmp(temp3_2,'2')
                disp3 = '0g_50B';
            elseif strcmp(temp3_2,'3')
                disp3 = '30g_0B';
            elseif strcmp(temp3_2,'4')
                disp3 = '30g_50B';
            end %if strcmp
            
            disp('')
            %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
            %                 ' & ',cellstr(col3{1}),', p=',num2str(thisP)];
            %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
            %                 dispThis{5},dispThis{6},dispThis{7}]);
            disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thisP)]);
        end %if thisP
    end %for jj
    for kk=1:size(cBGLUbyDIV,1)
        thatP = table2array(cBGLUbyDIV(kk,6));
        if thatP<0.10
            col1 = table2cell(cBGLUbyDIV(kk,1));
            temp1_1 = cellstr(col1{1});
            temp1_2 = temp1_1{1};
            if strcmp(temp1_2,'1')
                disp1 = '0g_0B';
            elseif strcmp(temp1_2,'2')
                disp1 = '0g_50B';
            elseif strcmp(temp1_2,'3')
                disp1 = '30g_0B';
            elseif strcmp(temp1_2,'4')
                disp1 = '30g_50B';
            end %if strcmp
            
            col2 = table2cell(cBGLUbyDIV(kk,2));
            temp2_1 = cellstr(col2{1});
            temp2_2 = temp2_1{1};
            if strcmp(temp2_2,'1')
                disp2 = 'pre';
            elseif strcmp(temp2_2,'2')
                disp2 = '24h post';
            elseif strcmp(temp2_2,'3')
                disp2 = '72h post';
            end %if strcmp
            
            col3 = table2cell(cBGLUbyDIV(kk,3));
            temp3_1 = cellstr(col3{1});
            temp3_2 = temp3_1{1};
            if strcmp(temp3_2,'1')
                disp3 = 'pre';
            elseif strcmp(temp3_2,'2')
                disp3 = '24h post';
            elseif strcmp(temp3_2,'3')
                disp3 = '72h post';
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
    theDataTable.(thisVar) = myTable;
    theRM.(thisVar) = rm;
    theTbl.(thisVar) = tbl;
    theBtwnSubj.(thisVar) = btwnSubj;
    theWthnSubj.(thisVar) = wthnSubj;
    theHypVal.(thisVar) = hypVal;
    
    theCDIVbyBGLU.(thisVar) = cDIVbyBGLU;
    theCBGLUbyDIV.(thisVar) = cBGLUbyDIV;
    % % % differences WITHIN conditions -- bdnfGlu

    
    figure(fig1);
    subplot(3,1,2); yyaxis left;
    y = (div17_0g_0b./div14_0g_0b).*100;
    x = (div14_0g_0b./div14_0g_0b).*100;
    myFun = @(y,x) mean(y-x);
    ci2_0g_0b = bootci(nIterations,myFun,y,x);
    y = (div17_0g_50b./div14_0g_50b).*100;
    x = (div14_0g_50b./div14_0g_50b).*100;
    myFun = @(y,x) mean(y-x);
    ci2_0g_50b = bootci(nIterations,myFun,y,x);
    y = (div17_30g_0b./div14_30g_0b).*100;
    x = (div14_30g_0b./div14_30g_0b).*100;
    myFun = @(y,x) mean(y-x);
    ci2_30g_0b = bootci(nIterations,myFun,y,x);
    y = (div17_30g_50b./div14_30g_50b).*100;
    x = (div14_30g_50b./div14_30g_50b).*100;
    myFun = @(y,x) mean(y-x);
    ci2_30g_50b = bootci(nIterations,myFun,y,x);
    
    
    plot([xLocs2(1) xLocs2(1)], [ci2_0g_0b(1) ci2_0g_0b(2)],'k-','linewidth',1.25);
    plot([xLocs2(2) xLocs2(2)], [ci2_0g_50b(1) ci2_0g_50b(2)],'k-','linewidth',1.25);
    plot([xLocs2(3) xLocs2(3)], [ci2_30g_0b(1) ci2_30g_0b(2)],'r-','linewidth',1.25);
    plot([xLocs2(4) xLocs2(4)], [ci2_30g_50b(1) ci2_30g_50b(2)],'r-','linewidth',1.25);
    
    % *** *** *** %
    disp([thisVar, ' 72h post vs pre mean % change']);
    disp(['0g 0B: ',num2str(mean(100.*((div17_0g_0b-div14_0g_0b)./div14_0g_0b)))]);
    disp(['0g 50B: ',num2str(mean(100.*((div17_0g_50b-div14_0g_50b)./div14_0g_50b)))]);
    disp(['30g 0B: ',num2str(mean(100.*((div17_30g_0b-div14_30g_0b)./div14_30g_0b)))]);
    disp(['30g 50B: ',num2str(mean(100.*((div17_30g_50b-div14_30g_50b)./div14_30g_50b)))]);
    % *** *** *** %
    plot(xLocs2(1), mean(100.*((div17_0g_0b-div14_0g_0b)./div14_0g_0b)),'ko','markersize',markerSize,'markerfacecolor','k','linewidth',1.75);
    plot(xLocs2(2), mean(100.*((div17_0g_50b-div14_0g_50b)./div14_0g_50b)),'kd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    plot(xLocs2(3), mean(100.*((div17_30g_0b-div14_30g_0b)./div14_30g_0b)),'ro','markersize',markerSize,'markerfacecolor','r','linewidth',1.75);
    plot(xLocs2(4), mean(100.*((div17_30g_50b-div14_30g_50b)./div14_30g_50b)),'rd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    %     ylim([yR1(ii) yR2(ii)]); %ylim([yLtl1(ii) yLtl2(ii)]);
    set(gca,'box','off','tickdir','out');
    
    
    figure(fig1);
    subplot(3,1,3); yyaxis left;
    y = (div17_0g_0b_other./div15_0g_0b_other).*100;
    x = (div15_0g_0b_other./div15_0g_0b_other).*100;
    myFun = @(y,x) mean(y-x);
    ci3_0g_0b = bootci(nIterations,myFun,y,x);
    y = (div17_0g_50b_other./div15_0g_50b_other).*100;
    x = (div15_0g_50b_other./div15_0g_50b_other).*100;
    myFun = @(y,x) mean(y-x);
    ci3_0g_50b = bootci(nIterations,myFun,y,x);
    y = (div17_30g_0b_other./div15_30g_0b_other).*100;
    x = (div15_30g_0b_other./div15_30g_0b_other).*100;
    myFun = @(y,x) mean(y-x);
    ci3_30g_0b = bootci(nIterations,myFun,y,x);
    y = (div17_30g_50b_other./div15_30g_50b_other).*100;
    x = (div15_30g_50b_other./div15_30g_50b_other).*100;
    myFun = @(y,x) mean(y-x);
    ci3_30g_50b = bootci(nIterations,myFun,y,x);
    
    plot([xLocs2(1) xLocs2(1)], [ci3_0g_0b(1) ci3_0g_0b(2)],'k-','linewidth',1.25);
    plot([xLocs2(2) xLocs2(2)], [ci3_0g_50b(1) ci3_0g_50b(2)],'k-','linewidth',1.25);
    plot([xLocs2(3) xLocs2(3)], [ci3_30g_0b(1) ci3_30g_0b(2)],'r-','linewidth',1.25);
    plot([xLocs2(4) xLocs2(4)], [ci3_30g_50b(1) ci3_30g_50b(2)],'r-','linewidth',1.25);
    
    % *** *** *** %
    disp([thisVar, ' 72h post 24h post mean % change']);
    disp(['0g 0B: ',num2str(mean(100.*((div17_0g_0b_other-div15_0g_0b_other)./div15_0g_0b_other)))]);
    disp(['0g 50B: ',num2str(mean(100.*((div17_0g_50b_other-div15_0g_50b_other)./div15_0g_50b_other)))]);
    disp(['30g 0B: ',num2str(mean(100.*((div17_30g_0b_other-div15_30g_0b_other)./div15_30g_0b_other)))]);
    disp(['30g 50B: ',num2str(mean(100.*((div17_30g_50b_other-div15_30g_50b_other)./div15_30g_50b_other)))]);
    % *** *** *** %
    plot(xLocs2(1), mean(100.*((div17_0g_0b_other-div15_0g_0b_other)./div15_0g_0b_other)),'ko','markersize',markerSize,'markerfacecolor','k','linewidth',1.75);
    plot(xLocs2(2), mean(100.*((div17_0g_50b_other-div15_0g_50b_other)./div15_0g_50b_other)),'kd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    plot(xLocs2(3), mean(100.*((div17_30g_0b_other-div15_30g_0b_other)./div15_30g_0b_other)),'ro','markersize',markerSize,'markerfacecolor','r','linewidth',1.75);
    plot(xLocs2(4), mean(100.*((div17_30g_50b_other-div15_30g_50b_other)./div15_30g_50b_other)),'rd','markersize',markerSize,'markerfacecolor',[1 1 1],'linewidth',1.75);
    %     ylim([yR1(ii) yR2(ii)]); %ylim([yLtl1(ii) yLtl2(ii)]);
    set(gca,'box','off','tickdir','out');
    
    
    figure(fig1);
    subplot(3,1,1);
    yyaxis right;
    % from https://courses.washington.edu/matlab1/Bootstrap_examples.html
%     ylim([yR1(ii) yR2(ii)]);
    plot([xLocs1(5)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    
    
    % 0g0B vs 0g50B
    X1 = ((div15_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div15_0g_50b - div14_0g_50b)./div14_0g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
    disp([thisVar, ' 24h post vs pre, diff in % change']);
    disp(['0g 50B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci1_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(5) xLocs1(5)], [ci1_Diff1(1) ci1_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(5), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi1_Diff1,xi1_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi1_Diff1)/gMax;
    plot(xLocs1(5)+fi1_Diff1/normG, xi1_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond0g50Bvs0g0B';
    thisDiff = 'div15VSdiv14';
    se = (ci1_Diff1(2) - ci1_Diff1(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci1_Diff1;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci1_Diff1(1)<0 && ci1_Diff1(2)<0) || (ci1_Diff1(1)>0 && ci1_Diff1(2)>0) 
        disp(['CIs = [',num2str(ci1_Diff1(1)),', ',num2str(ci1_Diff1(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    
%     % 0g0B vs 30g0B
%     X1 = ((div15_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
%     n1 = length(X1);
%     X2 = ((div15_30g_0b - div14_30g_0b)./div14_30g_0b).*100;
%     n2 = length(X2);
%     myStatistic = @(X1,X2) mean(X2)-mean(X1);
%     bootstrapStat = zeros(nIterations,1);
%     for jj=1:nIterations
%         sampX1 = X1(ceil(rand(n1,1)*n1));
%         sampX2 = X2(ceil(rand(n2,1)*n2));
%         bootstrapStat(jj) = myStatistic(sampX1,sampX2);
%     end %for jj
%     ci1_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
%     plot([xLocs1(8) xLocs1(8)], [ci1_Diff2(1) ci1_Diff2(2)],'k-','linewidth',1.25);
%     plot(xLocs1(8), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
%     [fi1_Diff2,xi1_Diff2] = ksdensity(bootstrapStat);
%     normG = max(fi1_Diff2)/gMax;
%     plot(xLocs1(8)+fi1_Diff2/normG, xi1_Diff2,'k-','linewidth',1.5);
%     % STATS %
%     thisComp = 'cond30g0Bvs0g0B';
%     thisDiff = 'div15VSdiv14';
%     se = (ci1_Diff2(2) - ci1_Diff2(1))/(2*1.96);
%     est = mean(bootstrapStat);
%     z = est/se;
%     if z>0
%         p = exp((-0.717*z)-(0.416*(z*z)));
%     elseif z<0
%         p = exp((0.717*z)-(0.416*(z*z)));
%     end %if z 
%     theCIs.(thisVar).(thisComp).(thisDiff) = ci1_Diff2;
%     theSE.(thisVar).(thisComp).(thisDiff) = se;
%     theEst.(thisVar).(thisComp).(thisDiff) = est;
%     theZ.(thisVar).(thisComp).(thisDiff) = z;
%     theP.(thisVar).(thisComp).(thisDiff) = p;
%     theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
%     if (ci1_Diff2(1)<0 && ci1_Diff2(2)<0) || (ci1_Diff2(1)>0 && ci1_Diff2(2)>0) 
%         disp(['CIs = [',num2str(ci1_Diff2(1)),', ',num2str(ci1_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
%     end% if
%     if p<0.10
%         disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
%     end %if p
%     % STATS %
    
%     % 0g0B vs 30g50B
%     X1 = ((div15_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
%     n1 = length(X1);
%     X2 = ((div15_30g_50b - div14_30g_50b)./div14_30g_50b).*100;
%     n2 = length(X2);
%     myStatistic = @(X1,X2) mean(X2)-mean(X1);
%     bootstrapStat = zeros(nIterations,1);
%     for jj=1:nIterations
%         sampX1 = X1(ceil(rand(n1,1)*n1));
%         sampX2 = X2(ceil(rand(n2,1)*n2));
%         bootstrapStat(jj) = myStatistic(sampX1,sampX2);
%     end %for jj
%     ci1_Diff3 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
%     plot([xLocs1(9) xLocs1(9)], [ci1_Diff3(1) ci1_Diff3(2)],'k-','linewidth',1.25);
%     plot(xLocs1(9), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
%     [fi1_Diff3,xi1_Diff3] = ksdensity(bootstrapStat);
%     normG = max(fi1_Diff3)/gMax;
%     plot(xLocs1(9)+fi1_Diff3/normG, xi1_Diff3,'k-','linewidth',1.5);
%     % STATS %
%     thisComp = 'cond30g50Bvs0g0B';
%     thisDiff = 'div15VSdiv14';
%     se = (ci1_Diff3(2) - ci1_Diff3(1))/(2*1.96);
%     est = mean(bootstrapStat);
%     z = est/se;
%     if z>0
%         p = exp((-0.717*z)-(0.416*(z*z)));
%     elseif z<0
%         p = exp((0.717*z)-(0.416*(z*z)));
%     end %if z 
%     theCIs.(thisVar).(thisComp).(thisDiff) = ci1_Diff3;
%     theSE.(thisVar).(thisComp).(thisDiff) = se;
%     theEst.(thisVar).(thisComp).(thisDiff) = est;
%     theZ.(thisVar).(thisComp).(thisDiff) = z;
%     theP.(thisVar).(thisComp).(thisDiff) = p;
%     theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
%     if (ci1_Diff3(1)<0 && ci1_Diff3(2)<0) || (ci1_Diff3(1)>0 && ci1_Diff3(2)>0) 
%         disp(['CIs = [',num2str(ci1_Diff3(1)),', ',num2str(ci1_Diff3(2)),']',' for ', thisComp, ' and ', thisDiff]);
%     end% if
%     if p<0.10
%         disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
%     end %if p
%     % STATS %
    
    % 30g0B vs 30g50B
    X1 = ((div15_30g_0b - div14_30g_0b)./div14_30g_0b).*100;
    n1 = length(X1);
    X2 = ((div15_30g_50b - div14_30g_50b)./div14_30g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
%     disp([thisVar, ' 24h post vs pre, diff in % change']);
    disp(['30g 50B vs 30g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci1_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(6) xLocs1(6)], [ci1_Diff2(1) ci1_Diff2(2)],'k-','linewidth',1.25);
    plot(xLocs1(6), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi1_Diff2,xi1_Diff2] = ksdensity(bootstrapStat);
    normG = max(fi1_Diff2)/gMax;
    plot(xLocs1(6)+fi1_Diff2/normG, xi1_Diff2,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g50Bvs30g0B';
    thisDiff = 'div15VSdiv14';
    se = (ci1_Diff2(2) - ci1_Diff2(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci1_Diff2;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci1_Diff2(1)<0 && ci1_Diff2(2)<0) || (ci1_Diff2(1)>0 && ci1_Diff2(2)>0) 
        disp(['CIs = [',num2str(ci1_Diff2(1)),', ',num2str(ci1_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    
    subplot(3,1,2);
    yyaxis right;
%     ylim([yR1(ii) yR2(ii)]);
    plot([xLocs1(5)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    
    % 0g0B vs 0g50B
    X1 = ((div17_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div17_0g_50b - div14_0g_50b)./div14_0g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
    disp([thisVar, ' 72h post vs pre, diff in % change']);
    disp(['0g 50B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci2_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(5) xLocs1(5)], [ci2_Diff1(1) ci2_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(5), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi2_Diff1,xi2_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi2_Diff1)/gMax;
    plot(xLocs1(5)+fi2_Diff1/normG, xi2_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond0g50Bvs0g0B';
    thisDiff = 'div17VSdiv14';
    se = (ci2_Diff1(2) - ci2_Diff1(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci2_Diff1;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci2_Diff1(1)<0 && ci2_Diff1(2)<0) || (ci2_Diff1(1)>0 && ci2_Diff1(2)>0) 
        disp(['CIs = [',num2str(ci2_Diff1(1)),', ',num2str(ci2_Diff1(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
%     % 0g0B vs 30g0B
%     X1 = ((div17_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
%     n1 = length(X1);
%     X2 = ((div17_30g_0b - div14_30g_0b)./div14_30g_0b).*100;
%     n2 = length(X2);
%     myStatistic = @(X1,X2) mean(X2)-mean(X1);
%     bootstrapStat = zeros(nIterations,1);
%     for jj=1:nIterations
%         sampX1 = X1(ceil(rand(n1,1)*n1));
%         sampX2 = X2(ceil(rand(n2,1)*n2));
%         bootstrapStat(jj) = myStatistic(sampX1,sampX2);
%     end %for jj
%     ci2_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
%     plot([xLocs1(8) xLocs1(8)], [ci2_Diff2(1) ci2_Diff2(2)],'k-','linewidth',1.25);
%     plot(xLocs1(8), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
%     [fi2_Diff2,xi2_Diff2] = ksdensity(bootstrapStat);
%     normG = max(fi2_Diff2)/gMax;
%     plot(xLocs1(8)+fi2_Diff2/normG, xi2_Diff2,'k-','linewidth',1.5);
%     % STATS %
%     thisComp = 'cond30g0Bvs0g0B';
%     thisDiff = 'div17VSdiv14';
%     se = (ci2_Diff2(2) - ci2_Diff2(1))/(2*1.96);
%     est = mean(bootstrapStat);
%     z = est/se;
%     if z>0
%         p = exp((-0.717*z)-(0.416*(z*z)));
%     elseif z<0
%         p = exp((0.717*z)-(0.416*(z*z)));
%     end %if z 
%     theCIs.(thisVar).(thisComp).(thisDiff) = ci2_Diff2;
%     theSE.(thisVar).(thisComp).(thisDiff) = se;
%     theEst.(thisVar).(thisComp).(thisDiff) = est;
%     theZ.(thisVar).(thisComp).(thisDiff) = z;
%     theP.(thisVar).(thisComp).(thisDiff) = p;
%     theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
%     if (ci2_Diff2(1)<0 && ci2_Diff2(2)<0) || (ci2_Diff2(1)>0 && ci2_Diff2(2)>0) 
%         disp(['CIs = [',num2str(ci2_Diff2(1)),', ',num2str(ci2_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
%     end% if
%     if p<0.10
%         disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
%     end %if p
%     % STATS %
    
%     % 0g0B vs 30g50B
%     X1 = ((div17_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
%     n1 = length(X1);
%     X2 = ((div17_30g_50b - div14_30g_50b)./div14_30g_50b).*100;
%     n2 = length(X2);
%     myStatistic = @(X1,X2) mean(X2)-mean(X1);
%     bootstrapStat = zeros(nIterations,1);
%     for jj=1:nIterations
%         sampX1 = X1(ceil(rand(n1,1)*n1));
%         sampX2 = X2(ceil(rand(n2,1)*n2));
%         bootstrapStat(jj) = myStatistic(sampX1,sampX2);
%     end %for jj
%     ci2_Diff3 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
%     plot([xLocs1(9) xLocs1(9)], [ci2_Diff3(1) ci2_Diff3(2)],'k-','linewidth',1.25);
%     plot(xLocs1(9), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
%     [fi2_Diff3,xi2_Diff3] = ksdensity(bootstrapStat);
%     normG = max(fi2_Diff3)/gMax;
%     plot(xLocs1(9)+fi2_Diff3/normG, xi2_Diff3,'k-','linewidth',1.5);
%     % STATS %
%     thisComp = 'cond30g50Bvs0g0B';
%     thisDiff = 'div17VSdiv14';
%     se = (ci2_Diff3(2) - ci2_Diff3(1))/(2*1.96);
%     est = mean(bootstrapStat);
%     z = est/se;
%     if z>0
%         p = exp((-0.717*z)-(0.416*(z*z)));
%     elseif z<0
%         p = exp((0.717*z)-(0.416*(z*z)));
%     end %if z 
%     theCIs.(thisVar).(thisComp).(thisDiff) = ci2_Diff3;
%     theSE.(thisVar).(thisComp).(thisDiff) = se;
%     theEst.(thisVar).(thisComp).(thisDiff) = est;
%     theZ.(thisVar).(thisComp).(thisDiff) = z;
%     theP.(thisVar).(thisComp).(thisDiff) = p;
%     theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
%     if (ci2_Diff3(1)<0 && ci2_Diff3(2)<0) || (ci2_Diff3(1)>0 && ci2_Diff3(2)>0) 
%         disp(['CIs = [',num2str(ci2_Diff3(1)),', ',num2str(ci2_Diff3(2)),']',' for ', thisComp, ' and ', thisDiff]);
%     end% if
%     if p<0.10
%         disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
%     end %if p
%     % STATS %
    
    % 30g0B vs 30g50B
    X1 = ((div17_30g_0b - div14_30g_0b)./div14_30g_0b).*100;
    n1 = length(X1);
    X2 = ((div17_30g_50b - div14_30g_50b)./div14_30g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
%     disp([thisVar, ' 72h post vs pre, diff in % change']);
    disp(['30g 50B vs 30g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci2_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(6) xLocs1(6)], [ci2_Diff2(1) ci2_Diff2(2)],'k-','linewidth',1.25);
    plot(xLocs1(6), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi2_Diff2,xi2_Diff2] = ksdensity(bootstrapStat);
    normG = max(fi2_Diff2)/gMax;
    plot(xLocs1(6)+fi2_Diff2/normG, xi2_Diff2,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g50Bvs30g0B';
    thisDiff = 'div17VSdiv14';
    se = (ci2_Diff2(2) - ci2_Diff2(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci2_Diff2;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci2_Diff2(1)<0 && ci2_Diff2(2)<0) || (ci2_Diff2(1)>0 && ci2_Diff2(2)>0) 
        disp(['CIs = [',num2str(ci2_Diff2(1)),', ',num2str(ci2_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
  
    
    subplot(3,1,3);
    yyaxis right;
%     ylim([yR1(ii) yR2(ii)]);
    plot([xLocs1(5)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    
    % 0g0B vs 0g50B
    X2 = ((div17_0g_50b_other - div15_0g_50b_other)./div15_0g_50b_other).*100;
    X1 = ((div17_0g_0b_other - div15_0g_0b_other)./div15_0g_0b_other).*100;
    n1 = length(X1);
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
    disp([thisVar, ' 72h post vs 24h post, diff in % change']);
    disp(['0g 50B vs 0g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci3_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(5) xLocs1(5)], [ci3_Diff1(1) ci3_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(5), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi3_Diff1,xi3_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi3_Diff1)/gMax;
    plot(xLocs1(5)+fi3_Diff1/normG, xi3_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond0g50Bvs0g0B';
    thisDiff = 'div17VSdiv15';
    se = (ci3_Diff1(2) - ci3_Diff1(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci3_Diff1;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci3_Diff1(1)<0 && ci3_Diff1(2)<0) || (ci3_Diff1(1)>0 && ci3_Diff1(2)>0) 
        disp(['CIs = [',num2str(ci3_Diff1(1)),', ',num2str(ci3_Diff1(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
%     % 0g0B vs 30g0B
%     X2 = ((div17_30g_0b_other - div15_30g_0b_other)./div15_30g_0b_other).*100;
%     X1 = ((div17_0g_0b_other - div15_0g_0b_other)./div15_0g_0b_other).*100;
%     n1 = length(X1);
%     n2 = length(X2);
%     myStatistic = @(X1,X2) mean(X2)-mean(X1);
%     bootstrapStat = zeros(nIterations,1);
%     for jj=1:nIterations
%         sampX1 = X1(ceil(rand(n1,1)*n1));
%         sampX2 = X2(ceil(rand(n2,1)*n2));
%         bootstrapStat(jj) = myStatistic(sampX1,sampX2);
%     end %for jj
%     ci3_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
%     plot([xLocs1(8) xLocs1(8)], [ci3_Diff2(1) ci3_Diff2(2)],'k-','linewidth',1.25);
%     plot(xLocs1(8), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
%     [fi3_Diff2,xi3_Diff2] = ksdensity(bootstrapStat);
%     normG = max(fi3_Diff2)/gMax;
%     plot(xLocs1(8)+fi3_Diff2/normG, xi3_Diff2,'k-','linewidth',1.5);
%     % STATS %
%     thisComp = 'cond30g0Bvs0g0B';
%     thisDiff = 'div17VSdiv15';
%     se = (ci3_Diff2(2) - ci3_Diff2(1))/(2*1.96);
%     est = mean(bootstrapStat);
%     z = est/se;
%     if z>0
%         p = exp((-0.717*z)-(0.416*(z*z)));
%     elseif z<0
%         p = exp((0.717*z)-(0.416*(z*z)));
%     end %if z 
%     theCIs.(thisVar).(thisComp).(thisDiff) = ci3_Diff2;
%     theSE.(thisVar).(thisComp).(thisDiff) = se;
%     theEst.(thisVar).(thisComp).(thisDiff) = est;
%     theZ.(thisVar).(thisComp).(thisDiff) = z;
%     theP.(thisVar).(thisComp).(thisDiff) = p;
%     theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
%     if (ci3_Diff2(1)<0 && ci3_Diff2(2)<0) || (ci3_Diff2(1)>0 && ci3_Diff2(2)>0) 
%         disp(['CIs = [',num2str(ci3_Diff2(1)),', ',num2str(ci3_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
%     end% if
%     if p<0.10
%         disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
%     end %if p
%     % STATS %
    
%     % 0g0B vs 30g50B
%     X2 = ((div17_30g_50b_other - div15_30g_50b_other)./div15_30g_50b_other).*100;
%     X1 = ((div17_0g_0b_other - div15_0g_0b_other)./div15_0g_0b_other).*100;
%     n1 = length(X1);
%     n2 = length(X2);
%     myStatistic = @(X1,X2) mean(X2)-mean(X1);
%     bootstrapStat = zeros(nIterations,1);
%     for jj=1:nIterations
%         sampX1 = X1(ceil(rand(n1,1)*n1));
%         sampX2 = X2(ceil(rand(n2,1)*n2));
%         bootstrapStat(jj) = myStatistic(sampX1,sampX2);
%     end %for jj
%     ci3_Diff3 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
%     plot([xLocs1(9) xLocs1(9)], [ci3_Diff3(1) ci3_Diff3(2)],'k-','linewidth',1.25);
%     plot(xLocs1(9), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
%     [fi3_Diff3,xi3_Diff3] = ksdensity(bootstrapStat);
%     normG = max(fi3_Diff3)/gMax;
%     plot(xLocs1(9)+fi3_Diff3/normG, xi3_Diff3,'k-','linewidth',1.5);
%     % STATS %
%     thisComp = 'cond30g50Bvs0g0B';
%     thisDiff = 'div17VSdiv15';
%     se = (ci3_Diff3(2) - ci3_Diff3(1))/(2*1.96);
%     est = mean(bootstrapStat);
%     z = est/se;
%     if z>0
%         p = exp((-0.717*z)-(0.416*(z*z)));
%     elseif z<0
%         p = exp((0.717*z)-(0.416*(z*z)));
%     end %if z 
%     theCIs.(thisVar).(thisComp).(thisDiff) = ci3_Diff3;
%     theSE.(thisVar).(thisComp).(thisDiff) = se;
%     theEst.(thisVar).(thisComp).(thisDiff) = est;
%     theZ.(thisVar).(thisComp).(thisDiff) = z;
%     theP.(thisVar).(thisComp).(thisDiff) = p;
%     theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
%     if (ci3_Diff3(1)<0 && ci3_Diff3(2)<0) || (ci3_Diff3(1)>0 && ci3_Diff3(2)>0) 
%         disp(['CIs = [',num2str(ci3_Diff3(1)),', ',num2str(ci3_Diff3(2)),']',' for ', thisComp, ' and ', thisDiff]);
%     end% if
%     if p<0.10
%         disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
%     end %if p
%     % STATS %
    
    % 30g0B vs 30g50B
    X1 = ((div17_30g_0b_other - div15_30g_0b_other)./div15_30g_0b_other).*100;
    n1 = length(X1);
    X2 = ((div17_30g_50b_other - div15_30g_50b_other)./div15_30g_50b_other).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    % *** *** *** %
%     disp([thisVar, ' 72h post vs 24h post, diff in % change']);
    disp(['30g 50B vs 30g 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci3_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(6) xLocs1(6)], [ci3_Diff2(1) ci3_Diff2(2)],'k-','linewidth',1.25);
    plot(xLocs1(6), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi3_Diff2,xi3_Diff2] = ksdensity(bootstrapStat);
    normG = max(fi3_Diff2)/gMax;
    plot(xLocs1(6)+fi3_Diff2/normG, xi3_Diff2,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g50Bvs30g0B';
    thisDiff = 'div17VSdiv15';
    se = (ci3_Diff2(2) - ci3_Diff2(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci3_Diff2;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci3_Diff2(1)<0 && ci3_Diff2(2)<0) || (ci3_Diff2(1)>0 && ci3_Diff2(2)>0) 
        disp(['CIs = [',num2str(ci3_Diff2(1)),', ',num2str(ci3_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    
    for jj=1:3
        subplot(3,1,jj);
        xticks(xLocs1);
        xticklabels({'','','','','',''});
        set(gca,'box','off','tickdir','out');
        set(fig1,'defaultAxesColorOrder',[0 0 0; 0 0 0]);
    end %for jj
    
    if ready2save
        try
            saveas(fig1,[figDir,thisVar,'_withinInjury.png']);
        catch
            disp(['could not save fig1 ',thisVar,'as *.png']);
        end
        saveas(fig1,[figDir,thisVar,'_withinInjury.fig']);
        saveas(fig1,[figDir,thisVar,'_withinInjury.svg']);
        
        try
            saveas(fig2,[figDir,thisVar,'_div15div14.png']);
        catch
            disp(['could not save fig2 ',thisVar,'as *.png']);
        end
        saveas(fig2,[figDir,thisVar,'_div15div14.fig']);
        saveas(fig2,[figDir,thisVar,'_div15div14.svg']);
        
        try
            saveas(fig3,[figDir,thisVar,'_div17div14.png']);
        catch
            disp(['could not save fig3 ',thisVar,'as *.png']);
        end
        saveas(fig3,[figDir,thisVar,'_div17div14.fig']);
        saveas(fig3,[figDir,thisVar,'_div17div14.svg']);
        
        try
            saveas(fig4,[figDir,thisVar,'_div17div15.png']);
        catch
            disp(['could not save fig4 ',thisVar,'as *.png']);
        end
        saveas(fig4,[figDir,thisVar,'_div17div15.fig']);
        saveas(fig4,[figDir,thisVar,'_div17div15.svg']);
    end %if ready2save
    
    close(fig1);
    close(fig2);
    close(fig3);
    close(fig4);
    
end %for ii

wthnStats.theDataTable = theDataTable;
wthnStats.theRM = theRM;
wthnStats.theTbl = theTbl;
wthnStats.theBtwnSubj = theBtwnSubj;
wthnStats.theWthnSubj = theWthnSubj;
wthnStats.theHypVal = theHypVal;
wthnStats.theCDIVbyBGLU = theCDIVbyBGLU;
wthnStats.theCBGLUbyDIV = theCBGLUbyDIV;

btwnStats.theSE = theSE;
btwnStats.theEst = theEst;
btwnStats.theZ = theZ;
btwnStats.theP = theP;
btwnStats.theBootStat = theBootStat;
btwnStats.theCIs = theCIs;

% save([figDir, 'estStats_bgluSynch_withinInjury.mat'], 'wthnStats','btwnStats');

%% PART 3 (est) - plot and do stats - SUBTRACT ONLY FROM CONTROL
clc; close all;

theVars = {'SF147'};
theConds = {'cond0g_0b', 'cond0g_50b', 'cond30g_0b', 'cond30g_50b'};
theSubVars.cat1 = {'SF14','SF47','SF71'};

nIterations = 500;
scattSz = 10;
alpha = 0.05;
xLocs1 = [1 2 3];
gMax = 0.5;

markerSize = 8;

% y1 = [-0.2 -0.4 -0.6];
% y2 = [ 0.2  0.4  0.6];

for ii=1:length(theSubVars.cat1)
    
    thisVar = theSubVars.cat1{ii};
    
    div14_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div14.(thisVar).rawCleaned;
    div15_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div15.(thisVar).rawCleaned;
    div17_0g_0b = bgluRawSynchData.SF147.cond0g_0b.div17.(thisVar).rawCleaned;
    
    div14_0g_0b_old = div14_0g_0b;
    div14_0g_0b(isnan(div14_0g_0b_old)) = [];
    div15_0g_0b(isnan(div14_0g_0b_old)) = [];
    div17_0g_0b(isnan(div14_0g_0b_old)) = [];
    div15_0g_0b_old = div15_0g_0b;
    div14_0g_0b(isnan(div15_0g_0b_old)) = [];
    div15_0g_0b(isnan(div15_0g_0b_old)) = [];
    div17_0g_0b(isnan(div15_0g_0b_old)) = [];
    div17_0g_0b_old = div17_0g_0b;
    div14_0g_0b(isnan(div17_0g_0b_old)) = [];
    div15_0g_0b(isnan(div17_0g_0b_old)) = [];
    div17_0g_0b(isnan(div17_0g_0b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_0g_0b_other = div15_0g_0b;
    div17_0g_0b_other = div17_0g_0b;
    [r15_0g_0b,~] = find(div15_0g_0b==0);
    div15_0g_0b_other(r15_0g_0b) = [];
    div17_0g_0b_other(r15_0g_0b) = [];
    
    
    div14_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div14.(thisVar).rawCleaned;
    div15_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div15.(thisVar).rawCleaned;
    div17_0g_50b = bgluRawSynchData.SF147.cond0g_50b.div17.(thisVar).rawCleaned;
    
    div14_0g_50b_old = div14_0g_50b;
    div14_0g_50b(isnan(div14_0g_50b_old)) = [];
    div15_0g_50b(isnan(div14_0g_50b_old)) = [];
    div17_0g_50b(isnan(div14_0g_50b_old)) = [];
    div15_0g_50b_old = div15_0g_50b;
    div14_0g_50b(isnan(div15_0g_50b_old)) = [];
    div15_0g_50b(isnan(div15_0g_50b_old)) = [];
    div17_0g_50b(isnan(div15_0g_50b_old)) = [];
    div17_0g_50b_old = div17_0g_50b;
    div14_0g_50b(isnan(div17_0g_50b_old)) = [];
    div15_0g_50b(isnan(div17_0g_50b_old)) = [];
    div17_0g_50b(isnan(div17_0g_50b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_0g_50b_other = div15_0g_50b;
    div17_0g_50b_other = div17_0g_50b;
    [r15_0g_50b,~] = find(div15_0g_50b==0);
    div15_0g_50b_other(r15_0g_50b) = [];
    div17_0g_50b_other(r15_0g_50b) = [];
    
    
    div14_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div14.(thisVar).rawCleaned;
    div15_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div15.(thisVar).rawCleaned;
    div17_30g_0b = bgluRawSynchData.SF147.cond30g_0b.div17.(thisVar).rawCleaned;
    
    div14_30g_0b_old = div14_30g_0b;
    div14_30g_0b(isnan(div14_30g_0b_old)) = [];
    div15_30g_0b(isnan(div14_30g_0b_old)) = [];
    div17_30g_0b(isnan(div14_30g_0b_old)) = [];
    div15_30g_0b_old = div15_30g_0b;
    div14_30g_0b(isnan(div15_30g_0b_old)) = [];
    div15_30g_0b(isnan(div15_30g_0b_old)) = [];
    div17_30g_0b(isnan(div15_30g_0b_old)) = [];
    div17_30g_0b_old = div17_30g_0b;
    div14_30g_0b(isnan(div17_30g_0b_old)) = [];
    div15_30g_0b(isnan(div17_30g_0b_old)) = [];
    div17_30g_0b(isnan(div17_30g_0b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_30g_0b_other = div15_30g_0b;
    div17_30g_0b_other = div17_30g_0b;
    [r15_30g_0b,~] = find(div15_30g_0b==0);
    div15_30g_0b_other(r15_30g_0b) = [];
    div17_30g_0b_other(r15_30g_0b) = [];
    
    
    div14_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div14.(thisVar).rawCleaned;
    div15_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div15.(thisVar).rawCleaned;
    div17_30g_50b = bgluRawSynchData.SF147.cond30g_50b.div17.(thisVar).rawCleaned;
    
    div14_30g_50b_old = div14_30g_50b;
    div14_30g_50b(isnan(div14_30g_50b_old)) = [];
    div15_30g_50b(isnan(div14_30g_50b_old)) = [];
    div17_30g_50b(isnan(div14_30g_50b_old)) = [];
    div15_30g_50b_old = div15_30g_50b;
    div14_30g_50b(isnan(div15_30g_50b_old)) = [];
    div15_30g_50b(isnan(div15_30g_50b_old)) = [];
    div17_30g_50b(isnan(div15_30g_50b_old)) = [];
    div17_30g_50b_old = div17_30g_50b;
    div14_30g_50b(isnan(div17_30g_50b_old)) = [];
    div15_30g_50b(isnan(div17_30g_50b_old)) = [];
    div17_30g_50b(isnan(div17_30g_50b_old)) = [];
    
    % for div15-div17 comparison ONLY
    div15_30g_50b_other = div15_30g_50b;
    div17_30g_50b_other = div17_30g_50b;
    [r15_30g_50b,~] = find(div15_30g_50b==0);
    div15_30g_50b_other(r15_30g_50b) = [];
    div17_30g_50b_other(r15_30g_50b) = [];
    
  
    fig1 = figure('Position', [1,41,1280,607.33]);

    figure(fig1);
    subplot(3,1,1);
    % from https://courses.washington.edu/matlab1/Bootstrap_examples.html
%     ylim([y1(ii) y2(ii)]);
    plot([xLocs1(1)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    xlim([xLocs1(1)-0.5 xLocs1(end)+1]);
    hold on;
    
    % 0g0B vs 0g50B
    X1 = ((div15_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div15_0g_50b - div14_0g_50b)./div14_0g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci1_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(1) xLocs1(1)], [ci1_Diff1(1) ci1_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(1), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi1_Diff1,xi1_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi1_Diff1)/gMax;
    plot(xLocs1(1)+fi1_Diff1/normG, xi1_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond0g50Bvs0g0B';
    thisDiff = 'div15VSdiv14';
    se = (ci1_Diff1(2) - ci1_Diff1(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci1_Diff1;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci1_Diff1(1)<0 && ci1_Diff1(2)<0) || (ci1_Diff1(1)>0 && ci1_Diff1(2)>0) 
        disp(['CIs = [',num2str(ci1_Diff1(1)),', ',num2str(ci1_Diff1(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % 0g0B vs 30g0B
    X1 = ((div15_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div15_30g_0b - div14_30g_0b)./div14_30g_0b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci1_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(2) xLocs1(2)], [ci1_Diff2(1) ci1_Diff2(2)],'k-','linewidth',1.25);
    plot(xLocs1(2), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi1_Diff2,xi1_Diff2] = ksdensity(bootstrapStat);
    normG = max(fi1_Diff2)/gMax;
    plot(xLocs1(2)+fi1_Diff2/normG, xi1_Diff2,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g0Bvs0g0B';
    thisDiff = 'div15VSdiv14';
    se = (ci1_Diff2(2) - ci1_Diff2(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci1_Diff2;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci1_Diff2(1)<0 && ci1_Diff2(2)<0) || (ci1_Diff2(1)>0 && ci1_Diff2(2)>0) 
        disp(['CIs = [',num2str(ci1_Diff2(1)),', ',num2str(ci1_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % 0g0B vs 30g50B
    X1 = ((div15_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div15_30g_50b - div14_30g_50b)./div14_30g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci1_Diff3 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(3) xLocs1(3)], [ci1_Diff3(1) ci1_Diff3(2)],'k-','linewidth',1.25);
    plot(xLocs1(3), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi1_Diff3,xi1_Diff3] = ksdensity(bootstrapStat);
    normG = max(fi1_Diff3)/gMax;
    plot(xLocs1(3)+fi1_Diff3/normG, xi1_Diff3,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g50Bvs0g0B';
    thisDiff = 'div15VSdiv14';
    se = (ci1_Diff3(2) - ci1_Diff3(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci1_Diff3;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci1_Diff3(1)<0 && ci1_Diff3(2)<0) || (ci1_Diff3(1)>0 && ci1_Diff3(2)>0) 
        disp(['CIs = [',num2str(ci1_Diff3(1)),', ',num2str(ci1_Diff3(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %

    
    subplot(3,1,2);
%     ylim([y1(ii) y2(ii)]);
    plot([xLocs1(1)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    xlim([xLocs1(1)-0.5 xLocs1(end)+1]);
    hold on;
    
    % 0g0B vs 0g50B
    X1 = ((div17_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div17_0g_50b - div14_0g_50b)./div14_0g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci2_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(1) xLocs1(1)], [ci2_Diff1(1) ci2_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(1), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi2_Diff1,xi2_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi2_Diff1)/gMax;
    plot(xLocs1(1)+fi2_Diff1/normG, xi2_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond0g50Bvs0g0B';
    thisDiff = 'div17VSdiv14';
    se = (ci2_Diff1(2) - ci2_Diff1(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci2_Diff1;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci2_Diff1(1)<0 && ci2_Diff1(2)<0) || (ci2_Diff1(1)>0 && ci2_Diff1(2)>0) 
        disp(['CIs = [',num2str(ci2_Diff1(1)),', ',num2str(ci2_Diff1(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % 0g0B vs 30g0B
    X1 = ((div17_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div17_30g_0b - div14_30g_0b)./div14_30g_0b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci2_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(2) xLocs1(2)], [ci2_Diff2(1) ci2_Diff2(2)],'k-','linewidth',1.25);
    plot(xLocs1(2), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi2_Diff2,xi2_Diff2] = ksdensity(bootstrapStat);
    normG = max(fi2_Diff2)/gMax;
    plot(xLocs1(2)+fi2_Diff2/normG, xi2_Diff2,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g0Bvs0g0B';
    thisDiff = 'div17VSdiv14';
    se = (ci2_Diff2(2) - ci2_Diff2(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci2_Diff2;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci2_Diff2(1)<0 && ci2_Diff2(2)<0) || (ci2_Diff2(1)>0 && ci2_Diff2(2)>0) 
        disp(['CIs = [',num2str(ci2_Diff2(1)),', ',num2str(ci2_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % 0g0B vs 30g50B
    X1 = ((div17_0g_0b - div14_0g_0b)./div14_0g_0b).*100;
    n1 = length(X1);
    X2 = ((div17_30g_50b - div14_30g_50b)./div14_30g_50b).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci2_Diff3 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(3) xLocs1(3)], [ci2_Diff3(1) ci2_Diff3(2)],'k-','linewidth',1.25);
    plot(xLocs1(3), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi2_Diff3,xi2_Diff3] = ksdensity(bootstrapStat);
    normG = max(fi2_Diff3)/gMax;
    plot(xLocs1(3)+fi2_Diff3/normG, xi2_Diff3,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g50Bvs0g0B';
    thisDiff = 'div17VSdiv14';
    se = (ci2_Diff3(2) - ci2_Diff3(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci2_Diff3;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci2_Diff3(1)<0 && ci2_Diff3(2)<0) || (ci2_Diff3(1)>0 && ci2_Diff3(2)>0) 
        disp(['CIs = [',num2str(ci2_Diff3(1)),', ',num2str(ci2_Diff3(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %

    
    subplot(3,1,3);
%     ylim([y1(ii) y2(ii)]);
    plot([xLocs1(1)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    xlim([xLocs1(1)-0.5 xLocs1(end)+1]);
    hold on;
    
    % 0g0B vs 0g50B
    X2 = ((div17_0g_50b_other - div15_0g_50b_other)./div15_0g_50b_other).*100;
    X1 = ((div17_0g_0b_other - div15_0g_0b_other)./div15_0g_0b_other).*100;
    n1 = length(X1);
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci3_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(1) xLocs1(1)], [ci3_Diff1(1) ci3_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(1), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi3_Diff1,xi3_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi3_Diff1)/gMax;
    plot(xLocs1(1)+fi3_Diff1/normG, xi3_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond0g50Bvs0g0B';
    thisDiff = 'div17VSdiv15';
    se = (ci3_Diff1(2) - ci3_Diff1(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci3_Diff1;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci3_Diff1(1)<0 && ci3_Diff1(2)<0) || (ci3_Diff1(1)>0 && ci3_Diff1(2)>0) 
        disp(['CIs = [',num2str(ci3_Diff1(1)),', ',num2str(ci3_Diff1(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % 0g0B vs 30g0B
    X2 = ((div17_30g_0b_other - div15_30g_0b_other)./div15_30g_0b_other).*100;
    X1 = ((div17_0g_0b_other - div15_0g_0b_other)./div15_0g_0b_other).*100;
    n1 = length(X1);
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci3_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(2) xLocs1(2)], [ci3_Diff2(1) ci3_Diff2(2)],'k-','linewidth',1.25);
    plot(xLocs1(2), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi3_Diff2,xi3_Diff2] = ksdensity(bootstrapStat);
    normG = max(fi3_Diff2)/gMax;
    plot(xLocs1(2)+fi3_Diff2/normG, xi3_Diff2,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g0Bvs0g0B';
    thisDiff = 'div17VSdiv15';
    se = (ci3_Diff2(2) - ci3_Diff2(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci3_Diff2;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci3_Diff2(1)<0 && ci3_Diff2(2)<0) || (ci3_Diff2(1)>0 && ci3_Diff2(2)>0) 
        disp(['CIs = [',num2str(ci3_Diff2(1)),', ',num2str(ci3_Diff2(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % 0g0B vs 30g50B
    X2 = ((div17_30g_50b_other - div15_30g_50b_other)./div15_30g_50b_other).*100;
    X1 = ((div17_0g_0b_other - div15_0g_0b_other)./div15_0g_0b_other).*100;
    n1 = length(X1);
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci3_Diff3 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(3) xLocs1(3)], [ci3_Diff3(1) ci3_Diff3(2)],'k-','linewidth',1.25);
    plot(xLocs1(3), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi3_Diff3,xi3_Diff3] = ksdensity(bootstrapStat);
    normG = max(fi3_Diff3)/gMax;
    plot(xLocs1(3)+fi3_Diff3/normG, xi3_Diff3,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond30g50Bvs0g0B';
    thisDiff = 'div17VSdiv15';
    se = (ci3_Diff3(2) - ci3_Diff3(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z 
    theCIs.(thisVar).(thisComp).(thisDiff) = ci3_Diff3;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci3_Diff3(1)<0 && ci3_Diff3(2)<0) || (ci3_Diff3(1)>0 && ci3_Diff3(2)>0) 
        disp(['CIs = [',num2str(ci3_Diff3(1)),', ',num2str(ci3_Diff3(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
     for jj=1:3
        subplot(3,1,jj);
%         ylim([y1(ii) y2(ii)]);
        xticks(xLocs1);
        xticklabels({'','','','',''});
        set(gca,'box','off','tickdir','out');
        hold on;
    end %for jj

    try
        saveas(fig1,[figDir,thisVar,'_minus0g0B.png']);
    catch
        disp(['could not save fig1 ',thisVar,'as *.png']);
    end
    saveas(fig1,[figDir,thisVar,'_minus0g0B.fig']);
    saveas(fig1,[figDir,thisVar,'_minus0g0B.svg']);
    
end %for ii

