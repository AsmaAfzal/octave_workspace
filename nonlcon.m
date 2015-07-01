%function [c,ceq,gc,gceq]=nonlcon(x)
%
%%c=2*x(3)^2-x(2)^2;
%%ceq=x(1)^2+x(2)^2+x(3)^2-1; 
%%c=[];
%%ceq = x(1)^2 + 1 - x(2);
%c=[];
%ceq=x(1)*x(2)-8-2/3-2/9;
%gc=[];
%gceq=[x(2); x(1)];
%
%endfunction

function [c,ceq]=nonlcon(x)
%ceq = p(1)^2 + 1 - p(2);
%c = [];
c = -1*[x(1)^2/9 + x(2)^2/4 - 1;
        x(1)^2 - x(2) - 1];
ceq = tanh(x(1)) - x(2);
endfunction