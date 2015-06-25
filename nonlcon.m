function [c,ceq]=nonlcon(x)

%c=2*x(3)^2-x(2)^2;
%ceq=x(1)^2+x(2)^2+x(3)^2-1; 
%c=[];
%ceq = x(1)^2 + 1 - x(2);
c=[];
ceq=x(1)*x(2)-8-2/3-2/9;
endfunction