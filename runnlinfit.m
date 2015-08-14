clear all
clc
close all
%modelfun = @(b,x)(b(1)+b(2)*exp(-b(3)*x));
%b = [1;3;2];
%x = exprnd(2,10,1);
%y = modelfun(b,x) + normrnd(0,0.1,10,1);
%beta0 = [2;2;2];
%[beta, R1,J1,covb,mse1] = nlinfit(x,y,modelfun,beta0)
%[beta,R,J,CovB,MSE] = nlinfit(x,y,modelfun,beta0)

%****weights********
%wts=16*ones(length(x),1);
%setting = statset("MaxIter",1000, "TolFun", 1e-6);
%[beta, R2,J2,covb,mse2] = nlinfit(x,y,modelfun,beta0,setting,"weights",wts)

%***Weighted Residual Example*****
modelfun = @(b,x)(b(1)+b(2)*exp(-b(3)*x));
b = [1;3;2];
x = [3.49622; 0.33751; 1.25675; 3.66981; 0.26237; 5.51095;...
     2.11407; 1.48774; 6.22436; 2.04519];
y_actual = [1.0028; 2.5274; 1.2430; 1.0019; 2.7751; 1.0000;...
           1.0437; 1.1531; 1.0000; 1.0502];
y_noisy =  [1.17891; 2.46055; 1.47400; 0.95433; 2.66687; 1.12279;...
           1.10664; 1.30461; 1.11601; 0.95274];
beta0 = [2;2;2];
weights = [5; 16; 1; 20; 12; 11; 17; 8; 11; 13]';
nlinfit(x,y_noisy,modelfun,beta0)
nlinfit(x,y_noisy,modelfun,beta0,[],"weights",weights)