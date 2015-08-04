classdef Fmincon

properties (SetAccess = public)
TolX;
TolFun;
end
%
methods
%  function val = optimoptions(func,varargin)
  function val = Fmincon(varargin)
%%  Check if options sensible
%      if(nargs == 0)
%       ## Return defaults for named function.
%       fcn = varargin{1};
%       try
%        retval = feval (fcn, "defaults");
%       catch
%        error ("optimset: no defaults for function '%s'", fcn);
%      end_try_catch
%     elseif (nargs == 2 && isstruct (varargin{1}) && isstruct (varargin{2}))
%       ## Set slots in old from non-empties in new.
%       ## Should we be checking to ensure that the field names are expected?
%       old = varargin{1};
%       new = varargin{2};
%       fnames = fieldnames (old);
    val.TolX = 1;
    val.TolFun = 2;
  end
  function disp(val)
    printf('TolX: %d \n',val.TolX)
    printf('TolFun: %d \n',val.TolFun)  
  end
end
  
%%end
%
%end
 
end