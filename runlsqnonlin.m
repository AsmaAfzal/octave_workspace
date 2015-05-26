clc
clear all
k = 1:10;
func = @(x) 2 + 2*k-exp(k*x(1))-exp(k*x(2));
x0 = [0.3; 0.4];                        % Starting guess

%x = lsqnonlin(func,x0)  
%x  = nonlin_residmin(func,x0)   
%
%[x,resnorm]=nonlin_residmin(func,x0)
%[x,resnorm,residual]=lsqnonlin(func,x0)

%[x,resnorm,flag]=nonlin_residmin(func,x0)
%[x,resnorm,residual,flag]=lsqnonlin(func,x0)
%settings=optimset ("lbound",[0.3;0.3])
%settings = struct();
%settings=optimset (settings,struct())

settings = optimset ("lbound",[0.3;0.3])
settings = optimset (settings,"ubound",[0.5;0.5])
%[x,resnorm]=nonlin_residmin(func,x0,settings)
lb=[0.3;0.3];ub=[0.5;0.5];
%[x,resnorm,residual]=lsqnonlin(func,x0,lb,ub,settings)
%[x,resnorm,residual]=lsqnonlin(func,x0,lb,[],struct())
