clc; clear all; close all;

% data info
dataLoc = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\MEA papers -- addl experiments\EXP for BDNF + glu\Glutamate cell death, BDNF treatment\';
replNames = {'Replicate 1'; 'Replicate 2'; 'Replicate 3'};

% filter parameters
filSig = [4, 1];
numSig = 3;
numAng = 30;

% thresholds
gfpMult = 0.10;
dapiMult = 0.25;
flThr = 35;
snrThr = 100;
arThr = 20;
szThr = 10;
eccThr = 0.80;

params.filSig = filSig;
params.numSig = numSig;
params.numAng = numAng;
params.gfpMult = gfpMult;
params.dapiMult = dapiMult;
params.flThr = flThr;
params.snrThr = snrThr;
params.arThr = arThr;
params.szThr = szThr;
params.eccThr = eccThr;

for ii=1:length(replNames)
    dirInfo = dir([dataLoc,replNames{ii},'\']);
    dirInfo = dirInfo(3:end);

    for jj=1:length(dirInfo)
        thisCond = dirInfo(jj).name;
        
        fileInfo = dir([dataLoc,replNames{ii},'\',thisCond]);
        fileInfo = fileInfo(3:end);

        for kk=1:length(fileInfo)
            realNames{kk,1} = fileInfo(kk).name;
            preNames{kk,1} = fileInfo(kk).name(1:length(thisCond)+1);
            postNames{kk,1} = fileInfo(kk).name(end-7:end-4);
            combNames{kk,1} = [preNames{kk,1}, '_', postNames{kk,1}];
        end %for kk
        
        [~, unqIdx, ~] = unique(combNames);
        for kk=1:length(unqIdx)
            unqCombNames{kk,1} = combNames{unqIdx(kk)};
            unqPreNames{kk,1} = preNames{unqIdx(kk)};
            unqPostNames{kk,1} = postNames{unqIdx(kk)};
        end %for kk
        
        for kk=1:length(unqCombNames)
            
            thisPreName = unqPreNames{kk,1};
            thisPostName = unqPostNames{kk,1};
            
            imLoc = [dataLoc,replNames{ii},'\',thisCond,'\',unqCombNames{kk,1}(1:length(thisCond)+1),'_RGB_',unqCombNames{kk,1}(end-3:end),'.tif'];
            theIm = imread(imLoc);
            dapiIm = theIm(:,:,3); % blue channel
            gfpIm = theIm(:,:,2); % green channel
            if ~strcmp(class(dapiIm),'uint8')
                dapiIm = im2uint8(dapiIm);
            end %if
            if ~strcmp(class(dapiIm),'uint8')
                gfpIm = im2uint8(dapiIm);
            end %if
            
            gfpIm2filt = gfpIm - 0.5*dapiIm;
            
            [prefAng, gfpFiltIm] = fft_LoG(filSig, numSig, numAng, gfpMult, gfpIm2filt);

            dapiMax = max(max(dapiIm));
            gfpMax = max(max(gfpFiltIm));
            SNR = gfpMax/(std(std(gfpFiltIm)));
            
            if (gfpMax<flThr && SNR>snrThr)
                gfpThr = 4;
            else
                gfpThr = gfpMult*gfpMax;
            end %if gfpMax

            dapiMask_big = dapiIm>=(dapiMult*dapiMax);
            gfpMask = gfpFiltIm>=gfpThr;
            szDiff = size(dapiMask_big,1) - size(gfpMask,1);
            dapiMask = dapiMask_big(1+(szDiff/2):end-(szDiff/2),1+(szDiff/2):end-(szDiff/2));
            
            gfpIm2skel_og = logical(double(gfpMask) - double(dapiMask.*gfpMask));
            gfpIm2skel_v2 = bwareafilt(gfpIm2skel_og,[arThr size(gfpIm2skel_og,1)*size(gfpIm2skel_og,2)]);
            gfpIm2skel = bwpropfilt(gfpIm2skel_v2,'Eccentricity',[eccThr 1]);
            
            if (gfpMax<flThr && SNR>snrThr)
                gfpIm2skel = logical(gfpIm2skel);
            else
                v2Inv = imcomplement(gfpIm2skel_v2);
                finalInv = imcomplement(gfpIm2skel);
                clear gfpIm2skel;
                comboInv = v2Inv.*finalInv;
                gfpIm2skel = logical(imcomplement(comboInv));
            end %if gfpMax
    
            gfpSkel = bwskel(gfpIm2skel,'minbranchlength',szThr);
            numPix = sum(sum(double(gfpSkel)));
            
            gfpBPs = bwmorph(gfpSkel,'branchpoints');
            numBPs = sum(sum(gfpBPs));
            
            figure('Position',[1,41,1536,747]);
            subplot(2,3,1); imagesc(gfpIm2filt); colorbar;
            title('raw GFP image'); axis equal; axis tight; hold on;
            subplot(2,3,2); imagesc(dapiIm); colorbar;
            title('raw DAPI image'); axis equal; axis tight; hold on;
            subplot(2,3,3); imagesc(gfpFiltIm); colorbar;
            title(['filtered GFP image, filSig = [',num2str(filSig(1)),', ',num2str(filSig(2)),']']); 
            axis equal; axis tight; hold on;
            subplot(2,3,4); imshowpair(dapiMask, gfpMask);
            title('compare masks'); axis equal; axis tight; hold on;
            subplot(2,3,5); imagesc(gfpIm2skel);
            title([thisPreName, ' ', thisPostName]); axis equal; axis tight; hold on;
            subplot(2,3,6); imshowpair(gfpIm2skel, gfpSkel);
            title('overlay skel'); axis equal; axis tight; hold on; 
            
            saveas(gcf,[dataLoc,'analyzed ',replNames{ii},'\',unqCombNames{kk},'_all.fig']);
            saveas(gcf,[dataLoc,'analyzed ',replNames{ii},'\',unqCombNames{kk},'_all.svg']);
            close(gcf);
            
            kcwMap = [0 0 0; 0 1 1; 1 1 1]; % black cyan white
            plotSkel = 10.*gfpIm2skel - 5.*gfpSkel; 
            figure; imagesc(plotSkel); colormap(kcwMap);
            saveas(gcf,[dataLoc,'analyzed ',replNames{ii},'\',unqCombNames{kk},'_skelOnly.fig']);
            saveas(gcf,[dataLoc,'analyzed ',replNames{ii},'\',unqCombNames{kk},'_skelOnly.svg']);
            close(gcf);
            
            % view where BPs are
            figure; imagesc(gfpSkel);
            [rr,cc] = find(gfpBPs==1);
            for mm=1:length(rr)
                hold on;
                plot(cc(mm),rr(mm),'o','markersize',4,'markerfacecolor','r','markeredgecolor','r');
            end %for ii
            title(unqCombNames{kk});
            axis equal; axis tight;
            saveas(gcf,[dataLoc,'analyzed ',replNames{ii},'\',unqCombNames{kk},'_skelBPs.fig']);
            saveas(gcf,[dataLoc,'analyzed ',replNames{ii},'\',unqCombNames{kk},'_skelBPs.svg']);
            close(gcf);
            
            save([dataLoc,'analyzed ',replNames{ii},'\',unqCombNames{kk},'.mat'], ...
                'dapiIm', 'gfpIm', 'gfpIm2filt', 'prefAng', 'gfpFiltIm', ...
                'dapiMax', 'gfpMax', 'dapiMask_big', 'gfpMask', 'szDiff', ...
                'dapiMask', 'gfpIm2skel_og', 'gfpIm2skel_v2', 'gfpIm2skel', ...
                'gfpSkel', 'numPix', 'gfpBPs', 'numBPs', 'thisCond', ...
                'thisPreName', 'thisPostName', 'params');
             
            rName = ['repl',num2str(ii)];
            pixData.(rName).(thisCond).(thisPreName)(str2num(thisPostName)) = numPix;
            bpData.(rName).(thisCond).(thisPreName)(str2num(thisPostName)) = numBPs;
            
        end %for kk
        
        clear realNames preNames postNames combNames unqCombNames unqPreNames unqPostNames

    end %for jj
end %for ii

save([dataLoc,'cellDeathPixelData.mat'],'pixData','bpData','params');
