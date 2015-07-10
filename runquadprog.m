% Simple quadprog example
clc
clear all
H = diag([1; 0]);
f = [3; 4];
A = [-1 -3; 2 5; 3 4];
b = [-15; 100; 80];
l = zeros(2,1);
%quadprog(H,f)
%quadprog(H,f,A,b)
%[x,fval] = quadprog(H,f,A,b,[],[],l,[])
%[x,fval,exitflag] = quadprog(H,f,A,b,[],[],l,[])
%[x,fval,exitflag,output] = quadprog(H,f,A,b,[],[],l,[])
[ x,fval,exitflag,output,lambda] = quadprog(H,f,A,b,[],[],[],[])
%
%[x,fval,exitflag,output,lambda]=quadprog(H,f,A,b)
%[x, obj, info, lambda] = qp ([], H, f, [], [],[],[],[],A,b)

%***************

%x=linspace(0,5);
%a= [1.3130    0.6808    1.3137   -2.8538    2.2976    1.2959    0.6999   -0.5095   -0.6078   -0.0091];
%for i=1:10
%    y(i)=3*x(i)^2+2*x(i)+5;
%    y(i)=y(i)+a(i);
%    xx(i,1)=x(i)*x(i);xx(i,2)=x(i);xx(i,3)=1;
%end
%a=eye(10);
%a1=zeros(1,10);
%H=[a1; a1; a1; a];
%f=zeros(13,1);
%HH=[f f f H];
%Aeq=[xx eye(10)];beq=y';
%A=[];b=[];
%[X,fval,fl,out,lm]=quadprog(HH,f,A,b,Aeq,beq) 

%******************

% H = 1;  q = 0;                # objective: x -> 0.5 x^2
% A = 1;  lb =[];  ub = 10;   # constraint: x >= 1
% x0 = 0;                       # infeasible initial guess
%[x, obj_qp, INFO, lambda] = qp (x0, H, q, [], [], -inf, inf, lb, A, ub)