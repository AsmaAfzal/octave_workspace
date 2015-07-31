classdef optimoptions

properties (SetAccess = public)
TolX;
TolFun;
end
%
methods
%  function val = optimoptions(func,varargin)
  function val = optimoptions(a,b)
%  Check if options sensible
    val.TolX = a;
    val.TolFun = b;
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
