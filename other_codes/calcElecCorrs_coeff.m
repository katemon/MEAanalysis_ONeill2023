function [elecCorrMatrix,elecLagMatrix] = calcElecCorrs_coeff(spikeMatrix,maxlag)

elecCorrMatrix = zeros(size(spikeMatrix,1),size(spikeMatrix,1));
elecLagMatrix = elecCorrMatrix;

for ii=1:size(spikeMatrix,1)
    %disp(ii)
    parfor jj=1:size(spikeMatrix,1)
        elec1 = spikeMatrix(ii,:);
        elec2 = spikeMatrix(jj,:);
        [lagCorrs,lags] = xcorr(elec1', elec2', maxlag, 'coeff');
        
        [elecCorrMatrix(ii,jj),idx] = max(lagCorrs);
        if isnan(elecCorrMatrix(ii,jj))
            elecCorrMatrix(ii,jj) = 0;
            elecLagMatrix(ii,jj) = 0;
        end %if isnan
        
        elecLagMatrix(ii,jj) = lags(idx);
    end %for jj
end %for ii

end %elecCorrMatrix

