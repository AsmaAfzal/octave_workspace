clc
clear all
k = 1:10;
func = @(x) 2 + 2*k-exp(k*x(1))-exp(k*x(2));
x0 = [0.3; 0.5];                        % Starting guess

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
lb = [0.3;0.3];
ub = [0.5;0.5];
%[x,resnorm,residual] = lsqnonlin(func,x0,lb,[],struct())%empty upper bounds
%[x,resnorm,residual] = lsqnonlin(func,x0,lb,ub,settings)%all 5 inputs
[x,resnorm,residual] = lsqnonlin(func,x0,lb,[],[])

%****check row/col input
%x0 = [0.3 0.4];
%[x,resnorm,residual] = lsqnonlin(func,x0)

%******Settings*****
%settings = optimset("MaxIter",300)
%[x,resnorm,flag,output] = nonlin_residmin(func,x0,settings)
%lb = [0.3 0.3];
%ub = [0.5 0.5];
%[x,resnorm,residual,flag,output] = lsqnonlin(func,x0,settings)
%*********Lambda**********
%lb = [0.1;0.3];
%ub = [0.3; 0.1];
%settings = optimset (settings,"lbound", lb, "TolFun", 1e-30, "TolX", 1e-30);
%settings = optimset (settings,"ubound", ub)
%[x,resnorm,cvg,output] = nonlin_residmin(func,x0,settings);

%lb=[0.4 0.3]
%[x,resnorm,residual,flag,output,lambda,jacobian] = lsqnonlin(func,x0,lb)

%*******Jacobian*********
%settings=optimset(settings, "ret_dfdp", true);
%[x,resnorm,flag,output] = nonlin_residmin(func,x0,settings)
%[x,resnorm,residual,flag,output,jacobian] = lsqnonlin(func,x0)

%info = residmin_stat(func,x0,settings)

%*******Eg.2
%
%t = [0 .3 .8 1.1 1.6 2.3]';
%y = [.82 .72 .63 .60 .55 .50]';
%yhat = @(c,t) c(1) + c(2)*exp(-t);
%opt = optimset('TolFun',1e-100)
%[c,res,resid,flag,out,lamb,jacob] = lsqnonlin(@(c)yhat(c,t)-y,[1 1],[0.2 0.6],[],opt)

%*****user specified jacobian*******
%t = [0 .3 .8 1.1 1.6 2.3]';
%y = [.82 .72 .63 .60 .55 .50]';
%c0=[1;1];
%opt=optimset("Jacobian","on");
%c = nonlin_residmin(@(c) myfun(c,t,y),c0,opt)
%c = lsqnonlin(@(c) myfun(c,t,y),c0,opt)

%*****Complex Input******

%N = 100; % number of observations
%v0 = [2;3+4i;-.5+.4i]; % coefficient vector
%xdata = -log(rand(N,1)); % exponentially distributed
%noisedata = randn(N,1).*exp((1i*randn(N,1))); % complex noise
%cplxydata = v0(1) + v0(2).*exp(v0(3)*xdata) + noisedata;
%objfcn = @(v)v(1)+v(2)*exp(v(3)*xdata) - cplxydata;
%x0 = (1+1i)*[1;1;1]; % arbitrary initial guess
%[vest,resnorm,exitflag,output] = nonlin_residmin(objfcn,real(x0))

