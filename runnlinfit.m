clear all
clc
close all
modelfun = @(b,x)(b(1)+b(2)*exp(-b(3)*x));
b = [1;3;2];
x = exprnd(2,10,1);
y = modelfun(b,x) + normrnd(0,0.1,10,1);
beta0 = [2;2;2];
[beta, R1,J,covb,mse] = nlinfit(x,y,modelfun,beta0);
%[beta,R,J,CovB,MSE] = nlinfit(x,y,modelfun,beta0)

%****wights********
wts=16*ones(length(x),1);
setting = statset("MaxIter",1000, "TolFun", 1e-6);
[beta, R2,J,covb,mse] = nlinfit(x,y,modelfun,beta0,setting,"weights",wts)
beta