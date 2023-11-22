%Convert MCS electrode numbers to Matlab electrode numbers
% DIRECTIONS: Call the function ConvertMCS2Matlab in the command window and type in
% your array of bad electrodes.
% example: ConvertMCS2Matlab([13 83 64 17])
% Alternatively, you could create a variable and use that in place of the
% bracketed array of electrodes.
% example: BadElectrodes = [12 22 83 44]
%          ConvertMCS2Matlab(BadElectrodes)
function [badchannels] = ConvertMCS2Matlab(OldLabels, varargin)

badEnames = OldLabels;
TotbadE = length(badEnames);
newEnames = zeros(1,TotbadE);

load('convertE.mat')
for ii=1:TotbadE
    mcsE = badEnames(1,ii);   %for each of the bad electrodes, set a
                              %variable that indicates which electrode it
                              %is in MCS talk
    TheIndex = find(MCScode==mcsE); %since the index of the electrode in
                                    %MCS is the actual electrode number in
                                    %Matlab, no need for anything else.
%     matE = MATcode(TheIndex);
%     newEnames(ii) = matE;
    newEnames(1,ii) = TheIndex;
end %for ii

badchannels = [1, 5, 8, 57, 64, newEnames]; % * * * 2020-05-18 noticed 15 instead of 5??? shouldn't it be 5?

% NewLabels = deblank(num2str(newEnames)); %remove extra spaces
% disp('electrode names for Matlab input are the following:')
% disp(['  ', NewLabels])

end %function
