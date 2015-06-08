clc
clear all
%% Assume you determined xdata and ydata experimentally
xdata = [0.9 1.5 13.8 19.8 24.1 28.2 35.2 60.3 74.6 81.3];
ydata = [455.2 428.6 124.1 67.3 43.2 28.1 13.1 -0.4 -1.3 -1.5];
x0 = [100; -1] % Starting guess
opts=optimset('TolX',1e-6)
F = @(x)x(1)*exp(x(2)*xdata);
%[x,fy,flag,out] = nonlin_curvefit(F,x0,xdata,ydata)
[x,resnorm,resid,flag,out,lambda,jacob] = lsqcurvefit(F,x0,xdata,ydata,[],[],opts)
%
%t = [0 .3 .8 1.1 1.6 2.3]';
%y = [.82 .72 .63 .60 .55 .50]';
%yhat = @(c,t) c(1) + c(2)*exp(-t);
%opt = optimset('TolFun',1e-100)
%[c,res,resid,flag,out,lamb,jacob] = lsqcurvefit(@(c,t)yhat(c,t),[1 1],t,y,[0.2 0.6],[],opt)
%opt = optimset('TolFun',1e-100,'lbound',[0.2;0.6]);
%c=nonlin_curvefit(@(c,t)yhat(c,t),[1; 1],t,y,opt)

%*****user specified jacobian*******
%t = [0 .3 .8 1.1 1.6 2.3]';
%y = [.82 .72 .63 .60 .55 .50]';
%c0=[1;1];
%opt=optimset("Jacobian","on");
%[c,res,resid,flag,out,lamb,jacob]  = lsqcurvefit(@(c,t) myfun(c,t),c0,t,y,[],[],opt)

%x = 1:10:100;
% x=x';
% y=[9.2160e-001, 3.3170e-001, 8.9789e-002, 2.8480e-002, 2.6055e-002,...
%     8.3641e-003,  4.2362e-003,  3.1693e-003,  1.4739e-004,  2.9406e-004]';
% p0=[0.8;0.05];
% opts=optimset("Jacobian","on");
%p=lsqcurvefit(@diffcfit,p0,x,y)