function mfp = mfilepath
% MFILEPATH    - returns the m-file directory
% mfp = mfilepath
% this function is called by several setup scripts to identify the mfile root path
%
% U. Egert

% include a file separator at the end
switch computer
case 'PCWIN'
% mfp = [matlabroot filesep 'toolbox' filesep]; %default parent path of the meatools folder

% Alternatively for different locations of the meatools files change the command below,
% where <drive:\path> stands for the drive and path of the PARENT folder in which meatools is a subfolder.
% In this case delete the default command above.
%example (where the meatools files are in a folder c:\MyMfiles\meatools:
%mfp = ['C:\MyMfiles' filesep];

mfp= ['C:\Program Files\MATLAB\R2009b\toolbox' filesep]; % remove the % sign at the beginning of this line to enable the command

case 'LNX86'
   %mfp= [<drive:\path> filesep];
end;
