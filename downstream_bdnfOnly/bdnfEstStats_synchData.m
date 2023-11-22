%% ESTIMATION STATS METHOD

%% PART 0 (est) - set colors and load data
clc; clear all; close all;

addpath('C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\');%D:\kate_dropbox\Dropbox

myColors(1,:) = [0 0 0]; % black
myColors(2,:) = [1 0 0]; % red
myColors(3,:) = [0 0 1]; % blue

rawDays = {'div07';'div10';'div17'};

theXlabels = { {'0.1-0.4','0.4-0.7','0.7-1.0'} };

markerSize = 8;

theDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF dose response\revision_0B25B50Bonly_newPlots\data\';%D:\kate_dropbox\Dropbox
figDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - BDNF dose response\revision_0B25B50Bonly_newPlots\data\figs_estStats\';%D:\kate_dropbox\Dropbox

% RAW DATA
load([figDir, 'bdnfSynchData_forRM.mat'],'bdnfRawSynchData');

%% PART 1 (est) - plot and do stats

theVars = {'SF147'};
theConds = {'cond0B', 'cond25B', 'cond50B'};
theSubVars.cat1 = {'SF14','SF47','SF71'};

% * * * * * * * * %
ready2save = 0;
% * * * * * * * * %

nIterations = 500;
scattSz = 16;
alpha = 0.05;
jittAmt = 0.5;
xLocs1 = [0.5 1.5 2.5 4 5 6.5];
xLocs2 = [0.5 1.5 2.5];
gMax = 0.75;

% yL1 = [-1.2 -1.2 -1.2];
% yL2 = [ 1.2  1.2  1.2];
% yR1 = [-0.2 -0.4 -0.4];
% yR2 = [ 0.2  0.4  0.4];
% yLtl1 = [-0.55 -0.75];
% yLtl2 = [0.05 0.05];
%
for ii=1:length(theSubVars.cat1)
   
    thisVar = theSubVars.cat1{ii};
    
    div07_0B = bdnfRawSynchData.SF147.cond0B.div07.(thisVar).rawCleaned;
    div10_0B = bdnfRawSynchData.SF147.cond0B.div10.(thisVar).rawCleaned;
    div17_0B = bdnfRawSynchData.SF147.cond0B.div17.(thisVar).rawCleaned;
    
    div07_0B_old = div07_0B;
    div07_0B(isnan(div07_0B_old)) = [];
    div10_0B(isnan(div07_0B_old)) = [];
    div17_0B(isnan(div07_0B_old)) = [];
    div10_0B_old = div10_0B;
    div07_0B(isnan(div10_0B_old)) = [];
    div10_0B(isnan(div10_0B_old)) = [];
    div17_0B(isnan(div10_0B_old)) = [];
    div17_0B_old = div17_0B;
    div07_0B(isnan(div17_0B_old)) = [];
    div10_0B(isnan(div17_0B_old)) = [];
    div17_0B(isnan(div17_0B_old)) = [];
    
    % for div10-div17 comparison ONLY
    div10_0B_other = div10_0B;
    div17_0B_other = div17_0B;
    [r10_0B,~] = find(div10_0B==0);
    div10_0B_other(r10_0B) = [];
    div17_0B_other(r10_0B) = [];
    
    
    div07_25B = bdnfRawSynchData.SF147.cond25B.div07.(thisVar).rawCleaned;
    div10_25B = bdnfRawSynchData.SF147.cond25B.div10.(thisVar).rawCleaned;
    div17_25B = bdnfRawSynchData.SF147.cond25B.div17.(thisVar).rawCleaned;
    
    div07_25B_old = div07_25B;
    div07_25B(isnan(div07_25B_old)) = [];
    div10_25B(isnan(div07_25B_old)) = [];
    div17_25B(isnan(div07_25B_old)) = [];
    div10_25B_old = div10_25B;
    div07_25B(isnan(div10_25B_old)) = [];
    div10_25B(isnan(div10_25B_old)) = [];
    div17_25B(isnan(div10_25B_old)) = [];
    div17_25B_old = div17_25B;
    div07_25B(isnan(div17_25B_old)) = [];
    div10_25B(isnan(div17_25B_old)) = [];
    div17_25B(isnan(div17_25B_old)) = [];
    
    % for div10-div17 comparison ONLY
    div10_25B_other = div10_25B;
    div17_25B_other = div17_25B;
    [r10_25B,~] = find(div10_25B==0);
    div10_25B_other(r10_25B) = [];
    div17_25B_other(r10_25B) = [];
    
    
    div07_50B = bdnfRawSynchData.SF147.cond50B.div07.(thisVar).rawCleaned;
    div10_50B = bdnfRawSynchData.SF147.cond50B.div10.(thisVar).rawCleaned;
    div17_50B = bdnfRawSynchData.SF147.cond50B.div17.(thisVar).rawCleaned;
    
    div07_50B_old = div07_50B;
    div07_50B(isnan(div07_50B_old)) = [];
    div10_50B(isnan(div07_50B_old)) = [];
    div17_50B(isnan(div07_50B_old)) = [];
    div10_50B_old = div10_50B;
    div07_50B(isnan(div10_50B_old)) = [];
    div10_50B(isnan(div10_50B_old)) = [];
    div17_50B(isnan(div10_50B_old)) = [];
    div17_50B_old = div17_50B;
    div07_50B(isnan(div17_50B_old)) = [];
    div10_50B(isnan(div17_50B_old)) = [];
    div17_50B(isnan(div17_50B_old)) = [];
    
    % for div10-div17 comparison ONLY
    div10_50B_other = div10_50B;
    div17_50B_other = div17_50B;
    [r10_50B,~] = find(div10_50B==0);
    div10_50B_other(r10_50B) = [];
    div17_50B_other(r10_50B) = [];
    
    
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
    xJitt = jittAmt*rand(length(div07_0B),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(1),div10_0B-div07_0B,scattSz,'k');
    xJitt = jittAmt*rand(length(div07_25B),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(2),div10_25B-div07_25B,scattSz,'r');
    xJitt = jittAmt*rand(length(div07_50B),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(3),div10_50B-div07_50B,scattSz,'b');
    %     ylim([yR1(ii) yR2(ii)]);
    
    figure(fig3); % inset2
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs2(end)+0.5]);
    xJitt = jittAmt*rand(length(div07_0B),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(1),div17_0B-div07_0B,scattSz,'k');
    xJitt = jittAmt*rand(length(div07_25B),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(2),div17_25B-div07_25B,scattSz,'r');
    xJitt = jittAmt*rand(length(div07_50B),1)-(jittAmt/2);
    scatter(xJitt+xLocs1(3),div17_50B-div07_50B,scattSz,'b');
    %     ylim([yR1(ii) yR2(ii)]);
    
    figure(fig4); % inset3
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs2(end)+0.5]);
    if strcmp(thisVar,'Eloc')
        xJitt = jittAmt*rand(length(div10_0B_other),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(1),div17_0B_other-div10_0B_other,scattSz,'k');
        xJitt = jittAmt*rand(length(div10_25B_other),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(2),div17_25B_other-div10_25B_other,scattSz,'r');
        xJitt = jittAmt*rand(length(div10_50B_other),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(3),div17_50B_other-div10_50B_other,scattSz,'b');
    else
        xJitt = jittAmt*rand(length(div07_0B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(1),div17_0B-div10_0B,scattSz,'k');
        xJitt = jittAmt*rand(length(div07_25B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(2),div17_25B-div10_25B,scattSz,'r');
        xJitt = jittAmt*rand(length(div07_50B),1)-(jittAmt/2);
        scatter(xJitt+xLocs1(3),div17_50B-div10_50B,scattSz,'b');
    end %if strcmp
    %     ylim([yR1(ii) yR2(ii)]);
    
    
    figure(fig1);
    subplot(3,1,1);
    yyaxis left;
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs1(end)+1]);
    subplot(3,1,2);
    yyaxis left;
    plot([0 xLocs1(3)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs1(end)+1]);
    subplot(3,1,3);
    yyaxis left;
    plot([0 xLocs2(end)+0.5], [0 0],'--','color',[0.4 0.4 0.4]); hold on;
    xlim([0 xLocs1(end)+1]);
    
    
    figure(fig1);
    subplot(3,1,1); yyaxis left;
    y = (div10_0B./div07_0B).*100;
    x = (div07_0B./div07_0B).*100;
    myFun = @(y,x) mean(y-x);
    ci1_0B = bootci(nIterations,myFun,y,x);
    y = (div10_25B./div07_25B).*100;
    x = (div07_25B./div07_25B).*100;
    myFun = @(y,x) mean(y-x);
    ci1_25B = bootci(nIterations,myFun,y,x);
    y = (div10_50B./div07_50B).*100;
    x = (div07_50B./div07_50B).*100;
    myFun = @(y,x) mean(y-x);
    ci1_50B = bootci(nIterations,myFun,y,x);
    
    plot([xLocs2(1) xLocs2(1)], [ci1_0B(1) ci1_0B(2)], 'k-','linewidth',1.25);
    plot([xLocs2(2) xLocs2(2)], [ci1_25B(1) ci1_25B(2)], 'r-','linewidth',1.25);
    plot([xLocs2(3) xLocs2(3)], [ci1_50B(1) ci1_50B(2)], 'b-','linewidth',1.25);
    
    % *** *** *** %
    disp([thisVar, ' div10 vs div07 mean % change']);
    disp(['0B: ',num2str(mean(100.*((div10_0B-div07_0B)./div07_0B)))]);
    disp(['25B: ',num2str(mean(100.*((div10_25B-div07_25B)./div07_25B)))]);
    disp(['50B: ',num2str(mean(100.*((div10_50B-div07_50B)./div07_50B)))]);
    % *** *** *** %
    plot(xLocs2(1), mean(100.*((div10_0B-div07_0B)./div07_0B)),'ko','markersize',markerSize,'markerfacecolor','k','linewidth',1.75);
    plot(xLocs2(2), mean(100.*((div10_25B-div07_25B)./div07_25B)),'ro','markersize',markerSize,'markerfacecolor','r','linewidth',1.75);
    plot(xLocs2(3), mean(100.*((div10_50B-div07_50B)./div07_50B)),'bo','markersize',markerSize,'markerfacecolor','b','linewidth',1.75);
    if ii==1
        %         ylim([yLtl1(1) yLtl2(1)]);
        %     yticks([-0.05, -0.025, 0, 0.025, 0.05, 0.075]);
        %     yticklabels({'-0.05','','0','','0.05',''});
    elseif ii==2
        %         ylim([yLtl1(2) yLtl2(2)]);
    elseif ii==3
        %         ylim([yR1(ii) yR2(ii)]);
    elseif ii==4
        %         ylim([yLtl1(3) yLtl2(3)]);
    end %if ii
    set(gca,'box','off','tickdir','out');
    
    
    figure(fig1);
    subplot(3,1,2); yyaxis left;
    y = (div17_0B./div07_0B).*100;
    x = (div07_0B./div07_0B).*100;
    myFun = @(y,x) mean(y-x);
    ci2_0B = bootci(nIterations,myFun,y,x);
    y = (div17_25B./div07_25B).*100;
    x = (div07_25B./div07_25B).*100;
    myFun = @(y,x) mean(y-x);
    ci2_25B = bootci(nIterations,myFun,y,x);
    y = (div17_50B./div07_50B).*100;
    x = (div07_50B./div07_50B).*100;
    myFun = @(y,x) mean(y-x);
    ci2_50B = bootci(nIterations,myFun,y,x);
    
    plot([xLocs2(1) xLocs2(1)], [ci2_0B(1) ci2_0B(2)], 'k-','linewidth',1.25);
    plot([xLocs2(2) xLocs2(2)], [ci2_25B(1) ci2_25B(2)], 'r-','linewidth',1.25);
    plot([xLocs2(3) xLocs2(3)], [ci2_50B(1) ci2_50B(2)], 'b-','linewidth',1.25);
    
    % *** *** *** %
    disp([thisVar, ' div17 vs div07 mean % change']);
    disp(['0B: ',num2str(mean(100.*((div17_0B-div07_0B)./div07_0B)))]);
    disp(['25B: ',num2str(mean(100.*((div17_25B-div07_25B)./div07_25B)))]);
    disp(['50B: ',num2str(mean(100.*((div17_50B-div07_50B)./div07_50B)))]);
    % *** *** *** %
    plot(xLocs2(1), mean(100.*((div17_0B-div07_0B)./div07_0B)),'ko','markersize',markerSize,'markerfacecolor','k','linewidth',1.75);
    plot(xLocs2(2), mean(100.*((div17_25B-div07_25B)./div07_25B)),'ro','markersize',markerSize,'markerfacecolor','r','linewidth',1.75);
    plot(xLocs2(3), mean(100.*((div17_50B-div07_50B)./div07_50B)),'bo','markersize',markerSize,'markerfacecolor','b','linewidth',1.75);
    if ii==1
        %         ylim([yLtl1(1) yLtl2(1)]);
        %     yticks([-0.05, -0.025, 0, 0.025, 0.05, 0.075]);
        %     yticklabels({'-0.05','','0','','0.05',''});
    elseif ii==2
        %         ylim([yLtl1(2) yLtl2(2)]);
    elseif ii==3
        %         ylim([yR1(ii) yR2(ii)]);
    elseif ii==4
        %         ylim([yLtl1(3) yLtl2(3)]);
    end %if ii
    set(gca,'box','off','tickdir','out');
    
    
    figure(fig1);
    subplot(3,1,3); yyaxis left;
    y = (div17_0B_other./div10_0B_other).*100;
    x = (div10_0B_other./div10_0B_other).*100;
    myFun = @(y,x) mean(y-x);
    ci3_0B = bootci(nIterations,myFun,y,x);
    y = (div17_25B_other./div10_25B_other).*100;
    x = (div10_25B_other./div10_25B_other).*100;
    myFun = @(y,x) mean(y-x);
    ci3_25B = bootci(nIterations,myFun,y,x);
    y = (div17_50B_other./div10_50B_other).*100;
    x = (div10_50B_other./div10_50B_other).*100;
    myFun = @(y,x) mean(y-x);
    ci3_50B = bootci(nIterations,myFun,y,x);
    
    plot([xLocs2(1) xLocs2(1)], [ci3_0B(1) ci3_0B(2)], 'k-','linewidth',1.25);
    plot([xLocs2(2) xLocs2(2)], [ci3_25B(1) ci3_25B(2)], 'r-','linewidth',1.25);
    plot([xLocs2(3) xLocs2(3)], [ci3_50B(1) ci3_50B(2)], 'b-','linewidth',1.25);
    
    % *** *** *** %
    disp([thisVar, ' div17 vs div10 mean % change']);
    disp(['0B: ',num2str(mean(100.*((div17_0B_other-div10_0B_other)./div10_0B_other)))]);
    disp(['25B: ',num2str(mean(100.*((div17_25B_other-div10_25B_other)./div10_25B_other)))]);
    disp(['50B: ',num2str(mean(100.*((div17_50B_other-div10_50B_other)./div10_50B_other)))]);
    % *** *** *** %
    plot(xLocs2(1), mean(100.*((div17_0B_other-div10_0B_other)./div10_0B_other)),'ko','markersize',markerSize,'markerfacecolor','k','linewidth',1.75);
    plot(xLocs2(2), mean(100.*((div17_25B_other-div10_25B_other)./div10_25B_other)),'ro','markersize',markerSize,'markerfacecolor','r','linewidth',1.75);
    plot(xLocs2(3), mean(100.*((div17_50B_other-div10_50B_other)./div10_50B_other)),'bo','markersize',markerSize,'markerfacecolor','b','linewidth',1.75);
    
    
    % % % differences WITHIN conditions -- bdnfOnly
    disp(thisVar);
    dataMatrix = 100.*[ ((div07_0B-div07_0B)./div07_0B), ((div10_0B-div07_0B)./div07_0B), ((div17_0B-div07_0B)./div07_0B); ...
        ((div07_25B-div07_25B)./div07_25B), ((div10_25B-div07_25B)./div07_25B), ((div17_25B-div07_25B)./div07_25B); ...
        ((div07_50B-div07_50B)./div07_50B), ((div10_50B-div07_50B)./div07_50B), ((div17_50B-div07_50B)./div07_50B) ];
    
    condMatrix = [ ones(size(div07_0B)); ...
        2*ones(size(div07_25B)); ...
        3*ones(size(div07_50B)) ];
    
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
    disp('BDNF dose response')
    for jj=1:size(cDIVbyBDNF,1)
        thisP = table2array(cDIVbyBDNF(jj,6));
        if thisP<0.10
            col1 = table2cell(cDIVbyBDNF(jj,1));
            temp1_1 = cellstr(col1{1});
            temp1_2 = temp1_1{1};
            if strcmp(temp1_2,'1')
                disp1 = 'div07';
            elseif strcmp(temp1_2,'2')
                disp1 = 'div10';
            elseif strcmp(temp1_2,'3')
                disp1 = 'div17';
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
                disp2 = 'div10';
            elseif strcmp(temp2_2,'3')
                disp2 = 'div17';
            end %if strcmp
            
            col3 = table2cell(cBDNFbyDIV(kk,3));
            temp3_1 = cellstr(col3{1});
            temp3_2 = temp3_1{1};
            if strcmp(temp3_2,'1')
                disp3 = 'div07';
            elseif strcmp(temp3_2,'2')
                disp3 = 'div10';
            elseif strcmp(temp3_2,'3')
                disp3 = 'div17';
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
    
    theCDIVbyBDNF.(thisVar) = cDIVbyBDNF;
    theCBDNFbyDIV.(thisVar) = cBDNFbyDIV;
    % % % differences WITHIN conditions -- bdnfOnly
    
    figure(fig1);
    subplot(3,1,1);
    yyaxis right;
    % from https://courses.washington.edu/matlab1/Bootstrap_examples.html
%     ylim([yR1(ii) yR2(ii)]);
    plot([xLocs1(4)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    
    % 25B vs 0B
    X2 = ((div10_25B - div07_25B)./div07_25B).*100;
    X1 = ((div10_0B - div07_0B)./div07_0B).*100;
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
    disp([thisVar, ' div10 vs div07, diff in % change']);
    disp(['25B vs 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci1_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(4) xLocs1(4)], [ci1_Diff1(1) ci1_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(4), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi1_Diff1 ,xi1_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi1_Diff1)/gMax;
    plot(xLocs1(4)+fi1_Diff1/normG, xi1_Diff1,'k-','linewidth',1.5);
    % STATS %  https://www.bmj.com/content/343/bmj.d2304
    thisComp = 'cond25Bvs0B';
    thisDiff = 'div10VSdiv07';
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
    
    % 50B vs 0B
    X2 = ((div10_50B - div07_50B)./div07_50B).*100;
    X1 = ((div10_0B - div07_0B)./div07_0B).*100;
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
%     disp([thisVar, ' div10 vs div07, diff in % change']);
    disp(['50B vs 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci1_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(5) xLocs1(5)], [ci1_Diff1(1) ci1_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(5), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi1_Diff1 ,xi1_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi1_Diff1)/gMax;
    plot(xLocs1(5)+fi1_Diff1/normG, xi1_Diff1,'k-','linewidth',1.5);
    % STATS %  https://www.bmj.com/content/343/bmj.d2304
    thisComp = 'cond50Bvs0B';
    thisDiff = 'div10VSdiv07';
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
    
    % 50B vs 25B
    X2 = ((div10_50B - div07_50B)./div07_50B).*100;
    X1 = ((div10_25B - div07_25B)./div07_25B).*100;
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
%     disp([thisVar, ' div10 vs div07, diff in % change']);
    disp(['50B vs 25B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci1_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(6) xLocs1(6)], [ci1_Diff1(1) ci1_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(6), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi1_Diff1 ,xi1_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi1_Diff1)/gMax;
    plot(xLocs1(6)+fi1_Diff1/normG, xi1_Diff1,'k-','linewidth',1.5);
    % STATS %  https://www.bmj.com/content/343/bmj.d2304
    thisComp = 'cond50Bvs25B';
    thisDiff = 'div10VSdiv07';
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
    
    
    
    subplot(3,1,2);
    yyaxis right;
%     ylim([yR1(ii) yR2(ii)]);
    plot([xLocs1(4)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    
    % 25B vs 0B
    X2 = ((div17_25B - div07_25B)./div07_25B).*100;
    X1 = ((div17_0B - div07_0B)./div07_0B).*100;
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
    disp([thisVar, ' div17 vs div07, diff in % change']);
    disp(['25B vs 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci2_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(4) xLocs1(4)], [ci2_Diff1(1) ci2_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(4), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi2_Diff1 ,xi2_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi2_Diff1)/gMax;
    plot(xLocs1(4)+fi2_Diff1/normG, xi2_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond25Bvs0B';
    thisDiff = 'div17VSdiv07';
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
    
    % 50B vs 0B
    X2 = ((div17_50B - div07_50B)./div07_50B).*100;
    X1 = ((div17_0B - div07_0B)./div07_0B).*100;
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
%     disp([thisVar, ' div17 vs div07, diff in % change']);
    disp(['50B vs 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci2_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(5) xLocs1(5)], [ci2_Diff1(1) ci2_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(5), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi2_Diff1 ,xi2_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi2_Diff1)/gMax;
    plot(xLocs1(5)+fi2_Diff1/normG, xi2_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond50Bvs0B';
    thisDiff = 'div17VSdiv07';
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
    
    % 50B vs 25B
    X2 = ((div17_50B - div07_50B)./div07_50B).*100;
    X1 = ((div17_25B - div07_25B)./div07_25B).*100;
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
%     disp([thisVar, ' div17 vs div07, diff in % change']);
    disp(['50B vs 25B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci2_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(6) xLocs1(6)], [ci2_Diff1(1) ci2_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(6), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi2_Diff1 ,xi2_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi2_Diff1)/gMax;
    plot(xLocs1(6)+fi2_Diff1/normG, xi2_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond50Bvs25B';
    thisDiff = 'div17VSdiv07';
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
    
    
    
    subplot(3,1,3);
    yyaxis right;
%     ylim([yR1(ii) yR2(ii)]);
    plot([xLocs1(4)-0.5 xLocs1(end)+1], [0 0],'--','color',[0.4 0.4 0.4]);
    
    % 25B vs 0B
    X2 = ((div17_25B_other - div10_25B_other)./div10_25B_other).*100;
    X1 = ((div17_0B_other - div10_0B_other)./div10_0B_other).*100;
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
    disp([thisVar, ' div17 vs div10, diff in % change']);
    disp(['25B vs 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci3_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(4) xLocs1(4)], [ci3_Diff1(1) ci3_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(4), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi3_Diff1 ,xi3_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi3_Diff1)/gMax;
    plot(xLocs1(4)+fi3_Diff1/normG, xi3_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond25Bvs0B';
    thisDiff = 'div17VSdiv10';
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
    
    % 50B vs 0B
    X2 = ((div17_50B_other - div10_50B_other)./div10_50B_other).*100;
    X1 = ((div17_0B_other - div10_0B_other)./div10_0B_other).*100;
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
%     disp([thisVar, ' div17 vs div10, diff in % change']);
    disp(['50B vs 0B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci3_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(5) xLocs1(5)], [ci3_Diff1(1) ci3_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(5), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi3_Diff1 ,xi3_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi3_Diff1)/gMax;
    plot(xLocs1(5)+fi3_Diff1/normG, xi3_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond50Bvs0B';
    thisDiff = 'div17VSdiv10';
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
    
    % 50B vs 25B
    X2 = ((div17_50B_other - div10_50B_other)./div10_50B_other).*100;
    X1 = ((div17_25B_other - div10_25B_other)./div10_25B_other).*100;
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
%     disp([thisVar, ' div17 vs div10, diff in % change']);
    disp(['50B vs 25B: ',num2str(mean(X2)-mean(X1))]);
    % *** *** *** %
    ci3_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    plot([xLocs1(6) xLocs1(6)], [ci3_Diff1(1) ci3_Diff1(2)],'k-','linewidth',1.25);
    plot(xLocs1(6), mean(X2)-mean(X1),'ks','markersize',markerSize,'markerfacecolor',[0 0 0],'linewidth',1.75);
    [fi3_Diff1 ,xi3_Diff1] = ksdensity(bootstrapStat);
    normG = max(fi3_Diff1)/gMax;
    plot(xLocs1(6)+fi3_Diff1/normG, xi3_Diff1,'k-','linewidth',1.5);
    % STATS %
    thisComp = 'cond50Bvs25B';
    thisDiff = 'div17VSdiv10';
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
            saveas(fig2,[figDir,thisVar,'_div10div07.png']);
        catch
            disp(['could not save fig2 ',thisVar,'as *.png']);
        end
        saveas(fig2,[figDir,thisVar,'_div10div07.fig']);
        saveas(fig2,[figDir,thisVar,'_div10div07.svg']);
        
        try
            saveas(fig3,[figDir,thisVar,'_div17div07.png']);
        catch
            disp(['could not save fig3 ',thisVar,'as *.png']);
        end
        saveas(fig3,[figDir,thisVar,'_div17div07.fig']);
        saveas(fig3,[figDir,thisVar,'_div17div07.svg']);
        
        try
            saveas(fig4,[figDir,thisVar,'_div17div10.png']);
        catch
            disp(['could not save fig4 ',thisVar,'as *.png']);
        end
        saveas(fig4,[figDir,thisVar,'_div17div10.fig']);
        saveas(fig4,[figDir,thisVar,'_div17div10.svg']);
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
wthnStats.theCDIVbyBDNF = theCDIVbyBDNF;
wthnStats.theCBDNFbyDIV = theCBDNFbyDIV;

btwnStats.theSE = theSE;
btwnStats.theEst = theEst;
btwnStats.theZ = theZ;
btwnStats.theP = theP;
btwnStats.theBootStat = theBootStat;
btwnStats.theCIs = theCIs;

% save([figDir, 'estStats_bdnfSynch.mat'], 'wthnStats','btwnStats');
