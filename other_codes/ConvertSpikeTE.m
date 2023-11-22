function [spikeMatrixList,spikeMatrix,spikeMatrix_forPlotting] = ...
    ConvertSpikeTE(SpikeTime, SpikeElectrode, binsize, raster, varargin)

% binsize is in msec
totaltime = 300; % assume recording time is 300 sec

totalspks = length(SpikeTime);
elecspks = zeros(64,1);

for ii=1:totalspks
    row = SpikeElectrode(ii);
    elecspks(row) = elecspks(row) + 1;
    col = elecspks(row);
    spikeMatrixList(row, col) = SpikeTime(ii);
end %for ii

if size(spikeMatrixList,1)==63
    spikeMatrixList = [spikeMatrixList;
                zeros(1,size(spikeMatrixList,2))];
end %if size

% eliminate the dummy and reference electrodes
spikeMatrixList(1,:) = 0; 
spikeMatrixList(5,:) = 0; 
spikeMatrixList(8,:) = 0; 
spikeMatrixList(57,:) = 0; 
spikeMatrixList(64,:) = 0; 

spikeMatrixList_msec = spikeMatrixList*1000;
numBins = totaltime*(1000/binsize);
spikeMatrix = zeros(64, numBins);

for jj=1:64
    spikeBins = discretize(spikeMatrixList_msec(jj,:),0:1:numBins)';
    unqBins = unique(spikeBins);
    for kk=1:length(unqBins)
        thisBin = unqBins(kk);
        [r,~] = find(spikeBins==thisBin);
        if ~isempty(r)
            spikeMatrix(jj,thisBin) = 1;
        end %if ~isempty       
    end %for kk
    clear spikeBins;
end %for jj

firstTimes = find((SpikeTime*1000)<=binsize);
firstElecs = SpikeElectrode(firstTimes);
unqFirstElecs = unique(firstElecs);
check1s = spikeMatrix(:,1);
check1s_0s = zeros(size(check1s));
for mm=1:length(unqFirstElecs)
    check1s_0s(unqFirstElecs(mm)) = check1s(mm);
end %for mm
spikeMatrix(:,1) = check1s_0s;

spikeMatrix_forPlotting = spikeMatrix;

% make spikeMatrix and spikeMatrixList into 59 electrode matrices
spikeMatrix([1,5,8,57,64],:) = [];
spikeMatrixList([1,5,8,57,64],:) = [];

% bnrzSpikeMatrix = zeros(size(spikeMatrixList));
% bnrzSpikeMatrix(spikeMatrixList>0) = 1;
% bnrzSumMatrix = sum(bnrzSpikeMatrix,2);
% max(bnrzSumMatrix)

if raster
    figure; xlim([0 numBins]); ylim([0 65]); hold on;
    for mm=1:64
        xVals_all = spikeMatrix_forPlotting(mm,:);
        xVals_plot = find(xVals_all==1);
        yVals = mm.*ones(1,length(xVals_plot));
        plot(xVals_plot,yVals,'.','markersize',5,'color','k');
        hold on;
    end %for mm
    if ~isempty(varargin)
        figTitle = varargin{1};
        if length(varargin)==2
            saveLoc = varargin{2};
        else
            saveLoc = '';
        end %if length
        title(figTitle);
        saveas(gcf,[saveLoc,figTitle,'_raster.fig']);
        saveas(gcf,[saveLoc,figTitle,'_raster.png']);
        close(gcf);
    end %if ~isempty
end %if raster
end %function