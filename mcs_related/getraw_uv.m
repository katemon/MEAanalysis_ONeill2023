function [duV, duVT]=getraw_uv(D, newseTime, varargin);
% getraw_uV - retrieves MC-Rack continuous data as a matrix of uV values
% currOutVar=getraw_uV(D, newseTime)
%     <D> must be the name of a datastream object or a
%     file of continuous raw data recorded with MCRacks. 
%     <newseTime> is a 2-element vector giving the start and end 
%     time in milliseconds.
%     <currOutVar> is a variable of voltage data in uV. 
%
% If called without arguments an input dialog opens, requesting the 
% necessary information, suggesting defaults based on the previous
% call.
%
% Parameter value pairs may be used to select specific electrodes.
%
% example 
% ..., 'electrode', {'25', '35'}); 
% or to use ChannelIDs 
% ..., 'electrode', [13 21]);
%
% This will return a 2xN matrix with the data from electrodes # 25 and # 35
% in row 1 and 2 respectively.
%
% To retain a 64xN structure of the output matrix this default setting may 
% be modified with the pair:
%
% ..., 'make64', 'yes', ...
%
% The output will be a 64xN matrix with all values = 0 except for the 
% electrode specified.
%
% Note:
% The most recent settings will be stored with set(0, 'userdata') and reused 
% as defaults in the next call to getraw_uv via the dialog box, i.e. without input 
% arguments. 
% 
% See also GETANALOG_UV GETTRIGGER_UV GETSWEEP_UV
%
% (c) U. Egert 3/99

% History
% ue 10/12/02: restructured the code for clarity, replaced i with ii for
%              better performance with Matlab 6.5

electrode = 'all';
slice = 200;         % used to retrieve the data in chunks in order to save memory space, slows down only slightly
make64 = 'yes';

pvpmod(varargin);

if nargin == 0
   % Check for and restore previously used settings
   [D, newseTime, make64, dtype, electrode, M] = querydlg;
   if isempty(D),
      return
   end;
else
   [D, M] = checkDin(D, inputname(1));
end;


%---------------------------------------------------------------
% prepare retrieval 
[slice, chunk, Nchunks, Nsamples] = getchunksize(D, newseTime, slice);

% evaluate electrode definitions
cid = findcidlist(D, electrode, make64);

% resize if a 64xN matrix is requested
if strcmp('yes', make64)
   duV = zeros(64, Nsamples);
else
   duV = zeros(length(cid), Nsamples);
end;


%---------------------------------------------------------------
% retrieve the data
%---------------------------------------------------------------
m = 1;
n = 0;

% w = startwaitbar;

M.currseTime(1) = newseTime(1); % will be used to define the next GUI defaults

switch getfield(D,'fileaccess')
   case 'ole'
      if strcmp(getfield(D, 'meatype'), 'nogrid'), 
         make64 = 'no';
      end;
      
      for ii = 1:Nchunks
         d = nextdata(D, 'streamname', 'Electrode Raw Data', ...
            'startend', [newseTime(1)+(ii-1)*slice, min([newseTime(2), newseTime(1)+ii*slice])]);
         
         m = 1+(ii-1)*chunk;
         n = (ii-1)*chunk + size(d.data,2);
         
         duV(:,m:n) = convertNewFileData(D, d, cid, make64);
         
         if size(d.data,2) ~= chunk, 
            break, 
         end;
%          waitbar(ii/Nchunks, w);
      end;
      
      if nargout==2
         duVT=newseTime(1) + [0:size(duV,2)]*getfield(D, 'MicrosecondsPerTick')/1000;
      end;
      
   case 'file' 
      % for files recorded with MCRack version < 1.44
      for ii = 1:Nchunks
         
         if strcmp(getfield(D, 'DataType'), 'raw continous')
            d = getOldFileData(D, newseTime, slice, ii);
         else
            disp('getraw_uv: could not determine the DataType')
            return
         end;
         
         m=1+(ii-1)*chunk;
         n = (ii-1)*chunk + size(d.data,2);
         
         duV = convertOldData(D, d, cid, make64, m, n)
         
         if size(d.data,2) ~= chunk, 
            break, 
         end;
%          waitbar(ii/Nchunks, w);
      end;
end;

% crop trailing values
% close(w); 
if size(duV,2)>n
   duV(:, n+1:end)=[];
end;

% save current settings for the next call to the GUI
M.currseTime(2) = getfield(d, 'startend', {2}); % will be used to define the next GUI defaults
set(0,'userdata', M);

% if the GUI was used, assign the results to the base workspace
if nargout == 0
   assignin('base', M.currOutVar, duV);
   clear duV
end;



%***************************************************************
%         FUNCTIONS
%***************************************************************

function cid = findcidlist(D, electrode, make64);

if isvar('base', 'electrode')
   electrode = evalin('base', electrode)
end;

switch class(electrode)
   case 'char'
      if strmatch(electrode, 'all', 'exact') 
         cid = sort([reshape(getfield(D, 'ChannelID'), length(getfield(D, 'ChannelID')),1)]);
      else
         cid = getcid(electrode);
      end;
      
%      if strmatch(getfield(D,'meatype'), 'nogrid'), else, %old version before
%      040917
      if ~strcmp(getfield(D,'meatype'), 'nogrid') & strcmp(make64, 'yes')
         cid = sort([1; 8; 57; 64; cid]);
      end;
      
   case 'cell'
      if isempty(electrode{1})
         tempcid = getfield(D, 'ChannelID');
         cid = sort([1; 8; 57; 64; tempcid(:)]); clear tempcid
      else
         if strmatch(electrode{1}, 'all', 'exact') 
            cid = sort([reshape(getfield(D, 'ChannelID'), length(getfield(D, 'ChannelID')),1)]);
         else
            cid = getcid(electrode);
         end;
      end;
      
%      if strmatch(getfield(D,'meatype'), 'nogrid'), else, %old version before
%      040917
      if ~strcmp(getfield(D,'meatype'), 'nogrid') & strcmp(make64, 'yes')
          cidtmp = sort([1; 8; 57; 64; cid(:)]);
          cid = cidtmp; clear cidtmp;
       else
     end;

      
   case 'double'
      cid = electrode;
   otherwise
end;


%---------------------------------------------------------------
function [D, newseTime, make64, dtype, electrode, M] = querydlg;

% Check for and restore previously used settings
[M, currDSO, currOutVar, seTime, make64, electrode] = getPrevParams;

%---------------------------------------------------------------
% settings for the inputdlg window:
%---------------------------------------------------------------
Aprompt = {'datastream object or file name', ...
      'start time [ms]', ...
      'stop time [ms]', ...
      'target variable name (no quotes)', ...
      'electrode (separate with blanks, no quotes)', ...
      'retain 64 rows in the output matrix'};

Adef = {currDSO, ...
      num2str(seTime(2)), ...
      num2str(seTime(2)+diff(seTime)), ...
      currOutVar, ...
      char(electrode), ...
      make64};

A = inputdlg(Aprompt, 'read continuous analog data from MCRack files',1,Adef);


%---------------------------------------------------------------
% evaluate inputs
%---------------------------------------------------------------
if isempty(A)
   [D, newseTime, make64, dtype, electrode, M] = deal([]);
   return
end;

[D, dtype, newseTime, electrode, make64, M] = evalDlgA(A);

%---------------------------------------------------------------
function [D, M] = checkDin(D, inDname);
% evaluate the input parameters for datastream object variables vs
% filenames

switch class(D)
   case 'char'
      D = datastrm(D);
      M.currDSO = D;
   case 'datastrm'
      M.currDSO = inDname;
   otherwise
end;

M.currDSO = inDname;
if nargout == 0
   M.currOutVar = 'DuV';
end;

%---------------------------------------------------------------
function    [slice, chunk, Nchunks, Nsamples] = getchunksize(D, newseTime, slice);
% define the size of the retrieved section

Tdiff = diff(newseTime);

% define the size of the data chunk retrieved in one call
if slice > Tdiff
   slice = Tdiff;
end;
chunk = slice/(getfield(D, 'MicrosecondsPerTick')*1e-3); % time window for 8000 samples at 40 musec/sample
Nchunks = ceil(Tdiff/slice);
Nsamples = floor(Tdiff/(getfield(D, 'MicrosecondsPerTick')*1e-3));

%---------------------------------------------------------------
function w = startwaitbar;
nowait
w = waitbar(0,'retrieving data');
set(w, 'name', 'getraw: retrieving data')


%---------------------------------------------------------------
function d = getOldFileData(D, newseTime, slice, ii)
% retrieve data from files < MCRack v. 1.44 

od=nextraw(D, newseTime(1)+(ii-1)*slice, newseTime(1)+ii*slice);
d.data=od.sweepValues(1:64,:);
d.startend =od.startend;

%---------------------------------------------------------------
function duV = convertOldData(D, d, cid, make64, m, n)
% convert data from files < MCRack v. 1.44 from ADC samples to microvolts

if length(cid) < 60 & strcmp('yes', make64)
   duV(:,m:n) = ad2muvolt(D, d.data);
else
   duV(:,m:n) = ad2muvolt(D, d.data(cid,:));
end;

%---------------------------------------------------------------
function duVchunk = convertNewFileData(D, d, cid, make64);
% convert data from ole-style files from ADC samples to microvolts

if length(cid) < 64 
   if strcmp('yes', make64)
      duVchunk = ad2muvolt(D, d.data, 'Electrode Raw Data');
   else
      switch getfield(D, 'meatype')
         case '8x8'
            duVchunk = ad2muvolt(D, d.data(cid,:), 'Electrode Raw Data');
         case 'nogrid'
%             cid_map = find(cid == getfield(D, 'ChannelID')); %this needs to be moved outside the loop
            [C,IA,IB] = intersect(cid, getfield(D, 'ChannelID'));
            duVchunk = ad2muvolt(D, d.data(IA,:), 'Electrode Raw Data');
      end;
   end;
else
   duVchunk = ad2muvolt(D, d.data(cid,:), 'Electrode Raw Data');
end;

%---------------------------------------------------------------
function duV = convertNewFileData_bak(D, d, cid, make64, m, n);
% convert data from ole-style files from ADC samples to microvolts

if length(cid) < 64 
   if strcmp('yes', make64)
      duV(:,m:n) = ad2muvolt(D, d.data, 'Electrode Raw Data');
   else
      switch getfield(D, 'meatype')
         case '8x8'
            duV(:,m:n) = ad2muvolt(D, d.data(cid,:), 'Electrode Raw Data');
            %               duV(:,m:n) = ad2muvolt(D, d.data, 'Electrode Raw Data');
         case 'nogrid'
            cid_map = find(cid == getfield(D, 'ChannelID')); %this needs to be moved outside the loop
            duV(:,m:n) = ad2muvolt(D, d.data(cid_map,:), 'Electrode Raw Data');
      end;
   end;
else
   duV(cid,m:n) = ad2muvolt(D, d.data(cid,:), 'Electrode Raw Data');
end;


%---------------------------------------------------------------
function [M, currDSO, currOutVar, seTime, make64, electrode] = getPrevParams;

%---------------------------------------------------------------
% Check for and restore previously used settings
%---------------------------------------------------------------

[M, currDSO, currOutVar, seTime, make64, electrode] = deal([]);

M = get(0, 'userdata');
if isstruct(M) 
   if isfield(M, 'currDSO')
      currDSO = getfield(M, 'currDSO');
   else
      currDSO = 'D';
   end;
   
   if isfield(M, 'currOutVar')
      currOutVar = getfield(M, 'currOutVar');
   else
      currOutVar = 'DuV';
   end;
   
   if isfield(M, 'currseTime')
      seTime = getfield(M, 'currseTime');
   else
      seTime = [-100 0];
   end;
   slice = diff(seTime);
   
   if isfield(M, 'make64')
      make64 = getfield(M, 'make64');
   else
      make64 = 'yes';
   end;
   
   if isfield(M, 'electrode') & ~isempty(M.electrode{1})
      electrode = [];
      for ii = 1:length(M.electrode)
         electrode=[electrode M.electrode{ii} ' '];
      end;
      electrode = deblank(electrode);
   else
      electrode = 'all';
   end;
else
   currDSO = 'D';
   currOutVar = 'DuV';
   seTime = [-100 0];
   make64 = 'yes';
   electrode = 'all';
end;

%---------------------------------------------------------------
function [D, dtype, newseTime, electrode, make64, M] = evalDlgA(A);

[D, dtype, newseTime, electrode, make64, M] = deal([]);

if isempty(A{1})
   [fn, fp]=uigetfile('*.*', 'select MCRack data file:');
   if isempty(fn)
      return
   end;
   D = datastrm(fullfile(fp, fn));
   assignin('base', 'D', D);
elseif isfile(A{1})
   if evalin('base', ['~checkd(D, ''' A{1} ''')'], '1')
      D = datastrm(A{1});
      assignin('base', 'D', D);
   else
      D = evalin('base', 'D');
   end;
elseif isempty(evalin('base', A{1}, ''''''))
   [fn, fp]=uigetfile('*.*', 'select MCRack data file:');
%    if isempty(fn)
   if isnumeric(fn) & fn == 0
      return
   end;
   D = datastrm(fullfile(fp, fn));
   assignin('base', 'D', D);
elseif evalin('base', ['isobject(' A{1} ')'])
   D = evalin('base', A{1});
else   
   disp([mfilename ':: ERROR -- invalid datatype']);
   return
end;

if ~strcmp(class(D), 'datastrm')
   disp('ERROR :: variable given is not a valid datastream object')
   return
end;

dtype = getfield(D, 'DataType');

if ~strcmp(dtype, 'raw continous'),
   disp('ERROR :: DataType of the datastream object must be ''raw continuous''');
   return
end;


M.currDSO = A{1};
M.currOutVar = A{4};
newseTime = str2num([A{2} ' ' A{3}]);
if strcmp(A{5}, 'all')
   electrode = getfield(D, 'ChannelNames');
else
   electrode = cellstr(num2str(str2num(A{5})'));
end;
M.electrode = electrode;
make64 = A{6}; 
M.make64 = A{6};
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          