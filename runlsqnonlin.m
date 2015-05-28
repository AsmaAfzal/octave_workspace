clc
clear all
k = 1:10;
func = @(x) 2 + 2*k-exp(k*x(1))-exp(k*x(2));
x0 = [0.3; 0.4];                        % Starting guess

%********lsqnonlin==nonlin_residmin*******
%x = lsqnonlin(func,x0)  
%x = nonlin_residmin(func,x0)   
%[x,resnorm] = nonlin_residmin(func,x0)
%[x,resnorm,residual] = lsqnonlin(func,x0)
%[x,resnorm,flag] = nonlin_residmin(func,x0)
%[x,resnorm,residual,flag] = lsqnonlin(func,x0)


%*********bounds********
%settings = optimset ("lbound",[0.3;0.3])
%settings = struct();%dummy options
%settings = optimset (settings,struct())
%settings = optimset ("lbound",[0.3;0.3])
%settings = optimset (settings,"ubound",[0.5;0.5])
%[x,resnorm] = nonlin_residmin(func,x0,settings)
%lb = [0.3;0.3];
%ub = [0.5;0.5];
%[x,resnorm,residual] = lsqnonlin(func,x0,lb,ub,settings)%all 5 inputs
%[x,resnorm,residual] = lsqnonlin(func,x0,lb,[],struct())%empty upper bounds
%[x,resnorm,residual] = lsqnonlin(func,x0,lb)

%****check row/col input
%x0 = [0.3 0.4];
%[x,resnorm,residual] = lsqnonlin(func,x0)

%******Settings*****
settings = optimset("MaxIter",10)
%[x,resnorm,flag,output] = nonlin_residmin(func,x0,settings)
%lb = [0.3 0.3];
%ub = [0.5 0.5];
%[x,resnorm,residual,flag,output] = lsqnonlin(func,x0,settings)

%*******Jacobian*********
%settings=optimset(settings, "ret_dfdp", true);
%[x,resnorm,flag,output] = nonlin_residmin(func,x0,settings)
[x,resnorm,residual,flag,output,jacobian] = lsqnonlin(func,x0)

%info = residmin_stat(func,x0,settings)