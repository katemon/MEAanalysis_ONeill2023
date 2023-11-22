function result = isvar(sp, x);
% ISVAR           - check if a variable exists in a given workspace
% result = isvar(sp,x)
% checks if variable named by a string <x> exist in the workspace <sp>, 
% which can be 'base' or 'caller' (default). <result> is 1 or 0. If <x>
% is a cell array of variable names <results> will be a vector of 0 and 1.
%
% (c) U. Egert 1998

warning off
if nargin == 1
   x = sp;
   sp = 'caller';
end;

if isnumeric(x)
   disp([mfilename ':: x must be a string']);
end;

if iscell(x)
   for i = 1:length(x)
      result(i) = evalin(sp, ['exist(''' x{i} ''')==1']);
   end;
else
   result = evalin(sp, ['exist(''' x ''')==1']);
end;
warning on