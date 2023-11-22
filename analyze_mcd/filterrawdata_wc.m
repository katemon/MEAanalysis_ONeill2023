%Filters mcd data through a bandpass filter
%Also removed bad channels
function [filtdata] = filterrawdata_wc(thischunk,badchannels,fs,numChannels)
%create filter (butterworth bandpass, highpass 20Hz and lowpass 2000Hz)

N = 4; %filter order
Wn = [20, 2000]./(fs/2); %bandpass filter (allow data between 20Hz and 2000Hz)
%also try between 100Hz and 300Hz
[b,a] = butter(N,Wn); %butterworth bandpass filter 4th order

%notch filter to get rid of 60 Hz
wo = 60/(fs/2);
bw = wo/35;
[b2,a2] = iirnotch(wo,bw);

%apply filter to data row by row (now have filtered data in matrix y)
[rowdata, coldata] = size(thischunk);

Y = zeros(rowdata,coldata);
yy = zeros(rowdata,coldata);
% CHANGED TO FILT FILT SO THAT THERE IS NO PHASE DISTORTION
for ii=1:numChannels %cycle through each row
    yy(ii,:) = filtfilt(b,a,thischunk(ii,:)); %filter each row all columns
%     Y(ii,:) = yy(ii,:); % uncomment to not use notch filter
    Y(ii,:) = filtfilt(b2,a2,yy(ii,:)); % comment to not use notch filter
end

%remove all data from bad channels
Y(badchannels,:) = 0;

filtdata = Y;
end %function