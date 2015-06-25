clc
clear all
%objective_function = @ (p) p(1)^2 + p(2)^2;
% pin = [-2; 5];
% constraint_function = @ (p) p(1)^2 + 1 - p(2);
% [p, objf, cvg, outp] = nonlin_min (objective_function, pin, optimset ("equc", {constraint_function},"Algorithm","octave_sqp","ubound",[0;6]))

f = @(x) -x(1) * x(2) * x(3);

A = [-1 -2 -2; ...
      1  2  2];
b = [0;72];
x0 = [10;10;10];    % Starting guess at the solution
S=-A;
%[x,fval] = nonlin_min( f, x0, optimset ("inequc",{S',b},"Algorithm","octave_sqp") ) 

[x,fval,cvg,outp,lm] = fmincon(f,x0,A,b)