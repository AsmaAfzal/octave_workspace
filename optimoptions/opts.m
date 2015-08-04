classdef opts

properties 
Quadprog;
Fmincon;
end
%
%methods (Static)
%%  function val = optimoptions(func,varargin)
%  function val = Fmincon()
%%  Check if options sensible
%    val = Fminconopts();
%  end
%end
%methods  
%  function disp (val)
%    printf('TolX: %d \n',val.TolX)
%    printf('TolFun: %d \n',val.TolFun)  
%  endfunction
%  function obj = opts
%end  
%%end
%
%end
 
end


%classdef quadprogopts
%properties (SetAccess = public)
%TolX;
%TolFun;
%end
%%
%methods
%%  function val = optimoptions(func,varargin)
%  function val = quadprogopts()
%%  Check if options sensible
%    val.TolX = 1;
%    val.TolFun = 2;
%  end
%  function disp(val)
%    printf('TolX: %d \n',val.TolX)
%    printf('TolFun: %d \n',val.TolFun)  
%  end
%end
%  
%
%end