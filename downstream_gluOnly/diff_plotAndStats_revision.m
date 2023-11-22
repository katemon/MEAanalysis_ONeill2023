clc; clear all; close all;

theDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - GLU only\revision_newPlots\data\';%D:\kate_dropbox\Dropbox
figDir = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\Manuscript DRAFTS\2022 BDNF MEA paper\figures\data - GLU only\revision_newPlots\data\figs_estStats\';%D:\kate_dropbox\Dropbox

% RAW MEA DATA
load([theDir, 'gluDataforRM_byMEA.mat'],'meaData');

theVars = {'spikeRate';'burstletRate';'globalBurstRate'};
theConds = {'cond0g', 'cond30g', 'cond100g', 'cond175g', 'cond250g'};
xLocs = [1 2 3 4 5];
theShapes = {'o', 's', '+', 'v', 'd'}; 

% bootci params
nIterations = 500;
alpha = 0.05;
sz = 0.3;

% PER ELECTRODE THRESHOLD (from trialEstStats_plot_stats.m) -- multiply by
% 59 to get "PER MEA THRESHOLD". applying manually for each (eliminate
% points 4 & 5 from control for div14/15 data).
spkThr = 0.2*59; % spike thresh is 150 spikes per recording
brstThr = 0.02*59; % 1 burstlet every 50 sec
gbThr = 0.01*59; % global burst

y1 = [-150 -150 -150];
y2 = [150 150 100];

for ii=1:length(theVars)
    thisVar = theVars{ii};
    disp(thisVar);
    
    myFig = figure('Position',[43 254 1035 501]);
    plot([xLocs(1)-1 xLocs(end)+1], [0 0], 'color',[0.2 0.2 0.2], 'linewidth',2);
    hold on;
    
    thisData1 = [];
    for jj=1:length(meaData.cond0g.div14)
        thisData1 = [thisData1; meaData.cond0g.div14(jj).(thisVar).raw]; 
    end %for jj
    div14_0g = thisData1;
    thisData2 = [];
    for jj=1:length(meaData.cond0g.div14)
        thisData2 = [thisData2; meaData.cond0g.div15(jj).(thisVar).raw]; 
    end %for jj
    div15_0g = thisData2;
    
    % eliminate points 4&5 per thresholds above
    div14_0g(4:5) = [];
    div15_0g(4:5) = [];
    % eliminate points 4&5 per thresholds above
    div14_0g_old = div14_0g;
    [r14_0g,~] = find(div14_0g_old==0);
    div14_0g(r14_0g) = [];
    div15_0g(r14_0g) = [];
    div14_0g_newOld = div14_0g;
    div14_0g(isnan(div14_0g_newOld)) = [];
    div15_0g(isnan(div14_0g_newOld)) = [];
    div15_0g_newOld = div15_0g;
    div14_0g(isnan(div15_0g_newOld)) = [];
    div15_0g(isnan(div15_0g_newOld)) = [];
    
    thisData1 = [];
    for jj=1:length(meaData.cond30g.div14)
        thisData1 = [thisData1; meaData.cond30g.div14(jj).(thisVar).raw]; 
    end %for jj
    div14_30g = thisData1;
    thisData2 = [];
    for jj=1:length(meaData.cond30g.div14)
        thisData2 = [thisData2; meaData.cond30g.div15(jj).(thisVar).raw]; 
    end %for jj
    div15_30g = thisData2;

    div14_30g_old = div14_30g;
    [r14_30g,~] = find(div14_30g_old==0);
    div14_30g(r14_30g) = [];
    div15_30g(r14_30g) = [];
    div14_30g_newOld = div14_30g;
    div14_30g(isnan(div14_30g_newOld)) = [];
    div15_30g(isnan(div14_30g_newOld)) = [];
    div15_30g_newOld = div15_30g;
    div14_30g(isnan(div15_30g_newOld)) = [];
    div15_30g(isnan(div15_30g_newOld)) = [];
    
    
    thisData1 = [];
    for jj=1:length(meaData.cond100g.div14)
        thisData1 = [thisData1; meaData.cond100g.div14(jj).(thisVar).raw]; 
    end %for jj
    div14_100g = thisData1;
    thisData2 = [];
    for jj=1:length(meaData.cond100g.div14)
        thisData2 = [thisData2; meaData.cond100g.div15(jj).(thisVar).raw]; 
    end %for jj
    div15_100g = thisData2;

    div14_100g_old = div14_100g;
    [r14_100g,~] = find(div14_100g_old==0);
    div14_100g(r14_100g) = [];
    div15_100g(r14_100g) = [];
    div14_100g_newOld = div14_100g;
    div14_100g(isnan(div14_100g_newOld)) = [];
    div15_100g(isnan(div14_100g_newOld)) = [];
    div15_100g_newOld = div15_100g;
    div14_100g(isnan(div15_100g_newOld)) = [];
    div15_100g(isnan(div15_100g_newOld)) = [];
    
    
    thisData1 = [];
    for jj=1:length(meaData.cond175g.div14)
        thisData1 = [thisData1; meaData.cond175g.div14(jj).(thisVar).raw]; 
    end %for jj
    div14_175g = thisData1;
    thisData2 = [];
    for jj=1:length(meaData.cond175g.div14)
        thisData2 = [thisData2; meaData.cond175g.div15(jj).(thisVar).raw]; 
    end %for jj
    div15_175g = thisData2;
    
    div14_175g_old = div14_175g;
    [r14_175g,~] = find(div14_175g_old==0);
    div14_175g(r14_175g) = [];
    div15_175g(r14_175g) = [];
    div14_175g_newOld = div14_175g;
    div14_175g(isnan(div14_175g_newOld)) = [];
    div15_175g(isnan(div14_175g_newOld)) = [];
    div15_175g_newOld = div15_175g;
    div14_175g(isnan(div15_175g_newOld)) = [];
    div15_175g(isnan(div15_175g_newOld)) = [];
    
    
    thisData1 = [];
    for jj=1:length(meaData.cond250g.div14)
        thisData1 = [thisData1; meaData.cond250g.div14(jj).(thisVar).raw]; 
    end %for jj
    div14_250g = thisData1;
    thisData2 = [];
    for jj=1:length(meaData.cond250g.div14)
        thisData2 = [thisData2; meaData.cond250g.div15(jj).(thisVar).raw]; 
    end %for jj
    div15_250g = thisData2;
    
    div14_250g_old = div14_250g;
    [r14_250g,~] = find(div14_250g_old==0);
    div14_250g(r14_250g) = [];
    div15_250g(r14_250g) = [];
    div14_250g_newOld = div14_250g;
    div14_250g(isnan(div14_250g_newOld)) = [];
    div15_250g(isnan(div14_250g_newOld)) = [];
    div15_250g_newOld = div15_250g;
    div14_250g(isnan(div15_250g_newOld)) = [];
    div15_250g(isnan(div15_250g_newOld)) = [];

    
    % % % differences BETWEEN conditions -- bdnfGlu
    disp('differences BETWEEN conditions');
    
    % % % ALL THE BETWEEN CONDITION COMPARISONS
    
    % % % div15 - div14
    % % 0g vs 30g
    X1 = ((div15_0g - div14_0g)./div14_0g).*100;
    n1 = length(X1);
    X2 = ((div15_30g - div14_30g)./div14_30g).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci1_Diff1 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    % STATS %
    thisComp = 'cond30gvs0g';
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
    
    % PLOT COND0G AND COND30G
    plotData = X1;
    thisMean = mean(plotData);
    thisSEM = std(plotData)/sqrt(n1);
    [h,p] = adtest(plotData);
    if h==0
        ciVal_both = tinv([0.025 0.975], n1-1);
        ciVal = ciVal_both(2);
    else %if h==1
        ciVal = 1.96;
    end %if h
    theCI951 = ciVal.*thisSEM;
    
    theX = xLocs(1) - sz;
    theRect = rectangle('Position', [theX thisMean-theCI951 2*sz 2*theCI951], 'FaceColor',[0.7 0.7 0.7], 'EdgeColor', 'none');
    hold on;
    plot([xLocs(1)-sz, xLocs(1)+sz],[thisMean, thisMean],'color',[1 0 0],'linewidth',2);
    
    xJitt = (sz*0.75)*rand(n1,1) - 0.5*(sz*0.75);
    thisScatter = scatter(xJitt + xLocs(1),plotData,40,theShapes{1},'markeredgecolor',[0 0 0]);

    
    plotData = X2;
    thisMean = mean(plotData);
    thisSEM = std(plotData)/sqrt(n2);
    [h,p] = adtest(plotData);
    if h==0
        ciVal_both = tinv([0.025 0.975], n2-1);
        ciVal = ciVal_both(2);
    else %if h==1
        ciVal = 1.96;
    end %if h
    theCI952 = ciVal.*thisSEM;
    
    theX = xLocs(2) - sz;
    theRect = rectangle('Position', [theX thisMean-theCI952 2*sz 2*theCI952], 'FaceColor',[0.7 0.7 0.7], 'EdgeColor', 'none');
    hold on;
    plot([xLocs(2)-sz, xLocs(2)+sz],[thisMean, thisMean],'color',[1 0 0],'linewidth',2);

    xJitt = (sz*0.75)*rand(n2,1) - 0.5*(sz*0.75);
    thisScatter = scatter(xJitt + xLocs(2),plotData,40,theShapes{2},'markeredgecolor',[0 0 0]);
    % PLOT COND0G AND COND30G
    
    % % 0g vs 100g
    X1 = ((div15_0g - div14_0g)./div14_0g).*100;
    n1 = length(X1);
    X2 = ((div15_100g - div14_100g)./div14_100g).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci1_Diff2 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    % STATS %
    thisComp = 'cond100gvs0g';
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
    
    % PLOT COND100G
    plotData = X2;
    thisMean = mean(plotData);
    thisSEM = std(plotData)/sqrt(n2);
    [h,p] = adtest(plotData);
    if h==0
        ciVal_both = tinv([0.025 0.975], n2-1);
        ciVal = ciVal_both(2);
    else %if h==1
        ciVal = 1.96;
    end %if h
    theCI953 = ciVal.*thisSEM;
    
    theX = xLocs(3) - sz;
    theRect = rectangle('Position', [theX thisMean-theCI953 2*sz 2*theCI953], 'FaceColor',[0.7 0.7 0.7], 'EdgeColor', 'none');
    hold on;
    plot([xLocs(3)-sz, xLocs(3)+sz],[thisMean, thisMean],'color',[1 0 0],'linewidth',2);

    xJitt = (sz*0.75)*rand(n2,1) - 0.5*(sz*0.75);
    thisScatter = scatter(xJitt + xLocs(3),plotData,40,theShapes{3},'markeredgecolor',[0 0 0]);
    % PLOT COND100G
    
    % % 0g vs 175g
    X1 = ((div15_0g - div14_0g)./div14_0g).*100;
    n1 = length(X1);
    X2 = ((div15_175g - div14_175g)./div14_175g).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci1_Diff3 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    % STATS %
    thisComp = 'cond175gvs0g';
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
    
    % PLOT COND175G
    plotData = X2;
    thisMean = mean(plotData);
    thisSEM = std(plotData)/sqrt(n2);
    [h,p] = adtest(plotData);
    if h==0
        ciVal_both = tinv([0.025 0.975], n2-1);
        ciVal = ciVal_both(2);
    else %if h==1
        ciVal = 1.96;
    end %if h
    theCI954 = ciVal.*thisSEM;
    
    theX = xLocs(4) - sz;
    theRect = rectangle('Position', [theX thisMean-theCI954 2*sz 2*theCI954], 'FaceColor',[0.7 0.7 0.7], 'EdgeColor', 'none');
    hold on;
    plot([xLocs(4)-sz, xLocs(4)+sz],[thisMean, thisMean],'color',[1 0 0],'linewidth',2);
    
    xJitt = (sz*0.75)*rand(n2,1) - 0.5*(sz*0.75);
    thisScatter = scatter(xJitt + xLocs(4),plotData,40,theShapes{4},'markeredgecolor',[0 0 0]);
    hold on;
    % PLOT COND175G
    
    % % 0g vs 250g
    X1 = ((div15_0g - div14_0g)./div14_0g).*100;
    n1 = length(X1);
    X2 = ((div15_250g - div14_250g)./div14_250g).*100;
    n2 = length(X2);
    myStatistic = @(X1,X2) mean(X2)-mean(X1);
    bootstrapStat = zeros(nIterations,1);
    for jj=1:nIterations
        sampX1 = X1(ceil(rand(n1,1)*n1));
        sampX2 = X2(ceil(rand(n2,1)*n2));
        bootstrapStat(jj) = myStatistic(sampX1,sampX2);
    end %for jj
    ci1_Diff4 = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
    % STATS %
    thisComp = 'cond250gvs0g';
    thisDiff = 'div15VSdiv14';
    se = (ci1_Diff4(2) - ci1_Diff4(1))/(2*1.96);
    est = mean(bootstrapStat);
    z = est/se;
    if z>0
        p = exp((-0.717*z)-(0.416*(z*z)));
    elseif z<0
        p = exp((0.717*z)-(0.416*(z*z)));
    end %if z
    theCIs.(thisVar).(thisComp).(thisDiff) = ci1_Diff4;
    theSE.(thisVar).(thisComp).(thisDiff) = se;
    theEst.(thisVar).(thisComp).(thisDiff) = est;
    theZ.(thisVar).(thisComp).(thisDiff) = z;
    theP.(thisVar).(thisComp).(thisDiff) = p;
    theBootStat.(thisVar).(thisComp).(thisDiff) = bootstrapStat;
    if (ci1_Diff4(1)<0 && ci1_Diff4(2)<0) || (ci1_Diff4(1)>0 && ci1_Diff4(2)>0)
        disp(['CIs = [',num2str(ci1_Diff4(1)),', ',num2str(ci1_Diff4(2)),']',' for ', thisComp, ' and ', thisDiff]);
    end% if
    if p<0.10
        disp(['p = ',num2str(p),' for ', thisComp, ' and ', thisDiff]);
    end %if p
    % STATS %
    
    % PLOT COND250G
    plotData = X2;
    thisMean = mean(plotData);
    thisSEM = std(plotData)/sqrt(n2);
    [h,p] = adtest(plotData);
    if h==0
        ciVal_both = tinv([0.025 0.975], n2-1);
        ciVal = ciVal_both(2);
    else %if h==1
        ciVal = 1.96;
    end %if h
    theCI955 = ciVal.*thisSEM;
    
    theX = xLocs(5) - sz;
    theRect = rectangle('Position', [theX thisMean-theCI955 sz*2 2*theCI955], 'FaceColor',[0.7 0.7 0.7], 'EdgeColor', 'none');
    hold on;
    plot([xLocs(5)-sz, xLocs(5)+sz],[thisMean, thisMean],'color',[1 0 0],'linewidth',2);
    
    xJitt = (sz*0.75)*rand(n2,1) - 0.5*(sz*0.75);
    thisScatter = scatter(xJitt + xLocs(5),plotData,40,theShapes{5},'markeredgecolor',[0 0 0]);
    % PLOT COND175G

    
    
    % % % differences WITHIN conditions -- bdnfGlu
    disp('differences WITHIN conditions, RM ANOVA');
    
    dataMatrix = 100.*[ ((div14_0g-div14_0g)./div14_0g), ((div15_0g-div14_0g)./div14_0g); ...
        ((div14_30g-div14_30g)./div14_30g), ((div15_30g-div14_30g)./div14_30g); ...
        ((div14_100g-div14_100g)./div14_100g), ((div15_100g-div14_100g)./div14_100g); ...
        ((div14_175g-div14_175g)./div14_175g), ((div15_175g-div14_175g)./div14_175g); ...
        ((div14_250g-div14_250g)./div14_250g), ((div15_250g-div14_250g)./div14_250g) ];
    
    condMatrix = [ ones(size(div14_0g)); ...
        2*ones(size(div14_30g)); ...
        3*ones(size(div14_100g)); ...
        4*ones(size(div14_175g)); ...
        5*ones(size(div14_250g)) ];
    
    myTable = table(dataMatrix(:,1), dataMatrix(:,2), categorical(condMatrix),...
        'VariableNames',{'div14','div15','gluLevel'});
    
    % Define the within subject parameter (pre, during, post)
    Time = [1; 2];
    myTime = array2table(categorical(Time),'VariableNames',{'divGroup'});
    
    rm = fitrm(myTable, 'div14-div15~gluLevel', ...
        'WithinDesign', myTime);
    
    [tbl, btwnSubj, wthnSubj, hypVal] = ranova(rm, 'WithinModel', 'divGroup');
    
    [cDIVbyGLU] = multcompare(rm,'gluLevel','By','divGroup'); % * * * THIS IS IT ! ! ! * * * %
    [cGLUbyDIV] = multcompare(rm,'divGroup','By','gluLevel'); % * * * THIS IS IT ! ! ! * * * %
    
    disp('')
    disp('GLU injury only')
    for jj=1:size(cDIVbyGLU,1)
        thisP = table2array(cDIVbyGLU(jj,6));
        if thisP<0.10
            col1 = table2cell(cDIVbyGLU(jj,1));
            temp1_1 = cellstr(col1{1});
            temp1_2 = temp1_1{1};
            if strcmp(temp1_2,'1')
                disp1 = 'pre';
            elseif strcmp(temp1_2,'2')
                disp1 = '24h post';
            end %if strcmp
            
            col2 = table2cell(cDIVbyGLU(jj,2));
            temp2_1 = cellstr(col2{1});
            temp2_2 = temp2_1{1};
            if strcmp(temp2_2,'1')
                disp2 = '0g';
            elseif strcmp(temp2_2,'2')
                disp2 = '30g';
            elseif strcmp(temp2_2,'3')
                disp2 = '100g';
            elseif strcmp(temp2_2,'4')
                disp2 = '175g';
            elseif strcmp(temp2_2,'5')
                disp2 = '250g';
            end %if strcmp
            
            col3 = table2cell(cDIVbyGLU(jj,3));
            temp3_1 = cellstr(col3{1});
            temp3_2 = temp3_1{1};
            if strcmp(temp3_2,'1')
                disp3 = '0g';
            elseif strcmp(temp3_2,'2')
                disp3 = '30g';
            elseif strcmp(temp3_2,'3')
                disp3 = '100g';
            elseif strcmp(temp3_2,'4')
                disp3 = '175g';
            elseif strcmp(temp3_2,'5')
                disp3 = '250g';
            end %if strcmp
            
            disp('')
            %             dispThis = [cellstr(col1{1}),' & ',cellstr(col2{1}),...
            %                 ' & ',cellstr(col3{1}),', p=',num2str(thisP)];
            %             disp([dispThis{1},dispThis{2},dispThis{3},dispThis{4},...
            %                 dispThis{5},dispThis{6},dispThis{7}]);
            disp([disp1,' & ',disp2,' & ',disp3,', p=',num2str(thisP)]);
        end %if thisP
    end %for jj
    for kk=1:size(cGLUbyDIV,1)
        thatP = table2array(cGLUbyDIV(kk,6));
        if thatP<0.10
            col1 = table2cell(cGLUbyDIV(kk,1));
            temp1_1 = cellstr(col1{1});
            temp1_2 = temp1_1{1};
            if strcmp(temp1_2,'1')
                disp1 = '0g';
            elseif strcmp(temp1_2,'2')
                disp1 = '30g';
            elseif strcmp(temp1_2,'3')
                disp1 = '100g';
            elseif strcmp(temp1_2,'4')
                disp1 = '175g';
            elseif strcmp(temp1_2,'5')
                disp1 = '250g';
            end %if strcmp
            
            col2 = table2cell(cGLUbyDIV(kk,2));
            temp2_1 = cellstr(col2{1});
            temp2_2 = temp2_1{1};
            if strcmp(temp2_2,'1')
                disp2 = 'pre';
            elseif strcmp(temp2_2,'2')
                disp2 = '24h post';
            end %if strcmp
            
            col3 = table2cell(cGLUbyDIV(kk,3));
            temp3_1 = cellstr(col3{1});
            temp3_2 = temp3_1{1};
            if strcmp(temp3_2,'1')
                disp3 = 'pre';
            elseif strcmp(temp3_2,'2')
                disp3 = '24h post';
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
    plotDataTable.(thisVar) = myTable;
    theRM.(thisVar) = rm;
    theTbl.(thisVar) = tbl;
    theBtwnSubj.(thisVar) = btwnSubj;
    theWthnSubj.(thisVar) = wthnSubj;
    theHypVal.(thisVar) = hypVal;
    
    theCDIVbyGLU.(thisVar) = cDIVbyGLU;
    theGLUbyDIV.(thisVar) = cGLUbyDIV;
    
    figure(myFig);
    xlim([xLocs(1)-1 xLocs(end)+1]);
    ylim([y1(ii) y2(ii)]);
    hold on;
    
    xticks(xLocs);
    xticklabels({'','','','',''});
    
    set(gca,'fontsize',16,'linewidth',2,'box','off','tickdir','out');
    
    saveas(myFig,[figDir,'gluOnlyDiff_',thisVar,'.fig']);
    saveas(myFig,[figDir,'gluOnlyDiff_',thisVar,'.svg']);
    saveas(myFig,[figDir,'gluOnlyDiff_',thisVar,'.png']);
    close(myFig);

end %for ii

save([theDir,'diffStats_gluOnly.mat'],'theGLUbyDIV','theCDIVbyGLU','plotDataTable','theRM',...
    'theTbl','theBtwnSubj','theWthnSubj','theHypVal');
