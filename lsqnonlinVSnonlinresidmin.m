x0 = [0.3; 0.4];                        % Starting guess
[x,res] = nonlin_residmin(@myfun,x0)          % Invoke optimizer

resnorm=sum(res.^2)