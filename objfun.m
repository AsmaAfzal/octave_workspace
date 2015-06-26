function [f,g] = objfun (p)

f = p(1)^2 + p(2)^2;
g = [2*p(1);2*p(2)];

endfunction
