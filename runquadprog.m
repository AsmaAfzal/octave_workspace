% Simple quadprog example
clc
clear all
%H = diag([1; 0]);
%f = [3; 4];
%A = [-1 -3; 2 5; 3 4];
%l = zeros(2,1);
%b = [-15; 100; 80];
%quadprog(H,f)
%quadprog(H,f,A,b)
%[x,fval] = quadprog(H,f,A,b,[],[],l,[])
%[x,fval,exitflag] = quadprog(H,f,A,b,[],[],l,[])
%[x,fval,exitflag,output] = quadprog(H,f,A,b,[],[],l,[])
%[ x,fval,exitflag,output,lambda] = quadprog(H,f,A,b,[],[],l,[])
%%
%[x,fval,exitflag,output,lambda]=quadprog(H,f,A,b)
%[x, obj, info, lambda] = qp ([], H, f, [], [],[],[],[],A,b)

%%***************
%
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

%%*************
%
C = [0.9501    0.7620    0.6153    0.4057
    0.2311    0.4564    0.7919    0.9354
    0.6068    0.0185    0.9218    0.9169
    0.4859    0.8214    0.7382    0.4102
    0.8912    0.4447    0.1762    0.8936];
d = [0.0578
    0.3528
    0.8131
    0.0098
    0.1388];
A =[0.2027    0.2721    0.7467    0.4659
    0.1987    0.1988    0.4450    0.4186
    0.6037    0.0152    0.9318    0.8462];
b =[0.5251
    0.2026
    0.6721];
Aeq = [3 5 7 9];
beq = 4;
lb = -0.1*ones(4,1);
%lb(3)= -Inf;
lb(4)=0.3;
ub = 0.3*ones(4,1);
H=C'*C;f=-C'*d;
%[x,obj,flag,op,lambda]=quadprog(H,f,A,b,Aeq,beq,lb,ub)
[x,obj,flag,op,lambda]=quadprog(C'*C,-C'*d,[],[],[],[],lb,ub)
%
%[x, obj_qp, INFO, lambda] = qp ([],H,f,Aeq,beq,lb,ub,[],A,b)
%
[x, obj_qp, INFO, lambda] = qp ([],H,f,[],[],lb,ub)
%[x,obj,flag,op,lambda]=quadprog(C'*C,-C'*d,A,b,Aeq,beq);
%lambda
%[x,obj,flag,op,lambda]=quadprog(C'*C,-C'*d,A,b,Aeq,beq,[],ub)
%[x,obj,flag,op,lambda]=quadprog(C'*C,-C'*d,A,b,Aeq,beq)
%
%[x, obj_qp, INFO, lambda] = qp (zeros(4,1), C'*C,-C'*d,Aeq,beq,lb,ub,[],A,b)
%[x, obj_qp, INFO, lambda] = qp ([], C'*C,-C'*d,Aeq,beq,[],[],[],A,b);
%lambda

%***************

%H = [2 1; 1 2];
%f = [-6;7];
%Aeq= [1 0];
%beq= 3;
%[x,obj,flag,op,lambda]=quadprog(H,f,[],[],Aeq,beq)
%[x, obj_qp, INFO, lambda] = qp ([], H, f, Aeq,beq)
%*************************************
%
%H = [2 0; 0 2];
%f = [-2;-5];
%Aeq= [-1 2;0 1];
%beq= [-2; 0];
% [x,obj,flag,op,lambda]=quadprog(H,f,[],[],Aeq,beq)