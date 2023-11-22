function [thresh,sigma_n] = adaptivethresh_wc(filtchunk, badchannels,numChannels)

%get DataChunk (the raw stuff)
%do this for every channel
%do not include the "bad channels"

badc = badchannels;
Nbadc = length(badc);
jj = 1;

thresh = zeros(numChannels,1); %pre-allocate
sigma_n = zeros(numChannels,1);
for ii=1:numChannels
    
    if ii==badc(jj)
        thresh(ii,1) = Inf;
        if jj<Nbadc
            jj = jj+1;
        end %if
        
    else %if not a bad channel
        RMSmult = 4.5; %4.25, 5.00
        
%         sigma_n2(ii,1) = median(filtchunk(ii,:)./0.6745);
%         sigma_n(ii,1) = median(abs(det1))/0.6745;
        sigma_n(ii,1) = std(filtchunk(ii,:));
        thresh(ii,1) = RMSmult*sigma_n(ii,1);

    end %if ii = bad channel

end %for ii = electrodes

end %function
