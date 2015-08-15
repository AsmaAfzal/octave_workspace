clc
clear all

%objective_function = @ (p) p(1)^2 + p(2)^2;
% pin = [-2; 5];
% constraint_function = @ (p) p(1)^2 + 1 - p(2);
% gceq = @(p) [2*p(1),-1];
% gobjf = @(p) [2*p(1),2*p(2)];
% [p, objf, cvg, outp] = nonlin_min (objective_function, pin, optimset ("equc", {constraint_function,gceq},"objf_grad",gobjf))

% settings = optimset("GradObj","on");
% [x,fval] = fmincon(@objfun,pin,[],[],[],[],[],[],@nonlcon)
% 
f = @(x) -x(1) * x(2) * x(3);

A = [-1 -2 -2; ...
      1  2  2];
b = [0;72];
x0 = [10;10;10];    % Starting guess at the solution
S=-A';
%[x1,fval1] = nonlin_min( f, x0, optimset ("inequc",{S,b}) )
%[x2,fval2] = nonlin_min( f, x0, optimset ("inequc",{S,b},"Algorithm","octave_sqp") )
%
%settings = optimset("Algorithm","octave_sqp");
%[x,fval,cvg] = fmincon(f,x0,A,b)
%[x,fval,cvg] = fmincon(f,x0,A,b,[],[],[0;0;0],[],[],settings) 
opts=optimset("TolFun",1e-1)
[x,fval,cvg] = fmincon(f,x0,A,b,[],[],[0;0;0],[],[],opts) 

%***********Equality con****
%f=@(X)-X(1)*X(2)^2*X(3)^3*X(4)^4;
%x0=[2.5;2.5;2.5;2.5];
%Aeq=[1 1 1 1; 1 1 -1 -1];
%beq=[10;0];
%lb=[0;0;0;0];
%ub=[10;10;10;10];
%ceq=@(X) X(1)*X(2)-8-2/3-2/9;
%gceq=@(X)[X(2) X(1)];
%m=-Aeq.';
%[x1,fval1] = nonlin_min( f, x0, optimset ("equc",{ceq,gceq},"lbound",lb,"ubound",ub) ) 
%[x2,fval2] = nonlin_min( f, x0, optimset ("equc",{ceq, gceq},"lbound",lb,"ubound",ub,"Algorithm","octave_sqp") ) 
%[x,fval] = fmincon(f,x0,[],[],Aeq,beq,lb,ub,@nonlcon)
%

%*****nonlcon*************
%f=@(x)x(1)^3+x(2)^3+x(3)^3;
%x0=[1;1;2];
%c=@(x) -1*(2*x(3)^2-x(2)^2);
%ceq=@(x) x(1)^2+x(2)^2+x(3)^2-1; 
%[p, objf, cvg, outp] = nonlin_min (f, x0, optimset ("inequc",{c},"Algorithm","octave_sqp"))
%[x,fval]=fmincon(f,x0,[],[],[],[],[],[],@nonlcon)

%,"lbound",[0;-Inf;-Inf],"ubound",[Inf;Inf;0])

%objective_function = @ (p) p(1)^2 + p(2)^2;
%pin = [-2; 5];
%constraint_function = @ (p) p(1)^2 + 1 - p(2);
%[p, objf] = nonlin_min (objective_function, pin, optimset ("equc", {[],[],constraint_function,[]},"Algorithm","octave_sqp","ubound",[0;6]))
%[x,fval] = fmincon(objective_function,pin,[],[],[],[],[],[0;6],@nonlcon)


%********checking multiple ceq functions and gceq

%c = @(x)[x(1)^2/9 + x(2)^2/4 - 1;
%        x(1)^2 - x(2) - 1];
%ceq = @(x)tanh(x(1)) - x(2);
%nonlinfcn = @(x)deal(c(x),ceq(x));
%%
%obj = @(x)cosh(x(1))+sinh(x(2));
%%opts = optimset("Algorithm","octave_sqp");
%z = fmincon(obj,[0;0],[],[],[],[],[],[],nonlinfcn)
%z = nonlin_min(obj,[0;0],optimset("equc",{ceq},"inequc",{c},"Algorithm","octave_sqp"))
%
%%***********lambda****
%f=@(X)-X(1)*X(2)^2*X(3)^3*X(4)^4;
%x0=[2.5;2.5;2.5;2.5];
%Aeq=[1 1 1 1; 1 1 -1 -1];
%beq=[10;0];
%lb=[0;0;0;0];
%ub=[10;10;10;10];
%ceq=@(X) X(1)*X(2)-8-2/3-2/9;
%gceq=@(X)[X(2) X(1)];
%m=-Aeq.';
%%[x1,fval1] = nonlin_min( f, x0, optimset ("equc",{ceq,gceq},"lbound",lb,"ubound",ub) ) 
%[x2,fval2] = nonlin_min( f, x0, optimset ("equc",{m,beq,ceq,gceq},"lbound",lb,"ubound",ub,"Algorithm","octave_sqp") ) 
%[x,fval,flag,out,lambda,grad,hess] = fmincon(f,x0,[],[],Aeq,beq,lb,ub,@nonlcon)

