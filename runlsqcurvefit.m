clc
clear all
% Assume you determined xdata and ydata experimentally
xdata = [0.9 1.5 13.8 19.8 24.1 28.2 35.2 60.3 74.6 81.3];
ydata = [455.2 428.6 124.1 67.3 43.2 28.1 13.1 -0.4 -1.3 -1.5];
x0 = [100; -1] % Starting guess
F = @(x)x(1)*exp(x(2)*xdata);
%[x,fy,flag,out] = nonlin_curvefit(F,x0,xdata,ydata)
[x,resnorm,resid,flag,out,lambda,jacob] = lsqcurvefit(F,x0,xdata,ydata)