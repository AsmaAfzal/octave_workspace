% Simple quadprog example

H = diag([1; 0]);
f = [3; 4];
A = [-1 -3; 2 5; 3 4];
b = [-15; 100; 80];
l = zeros(2,1);
quadprog(H,f)
quadprog(H,f,A,b)
[x,fval] = quadprog(H,f,A,b,[],[],l,[])
[x,fval,exitflag] = quadprog(H,f,A,b,[],[],l,[])
[x,fval,exitflag,output] = quadprog(H,f,A,b,[],[],l,[])
[x,fval,exitflag,output,lambda] = quadprog(H,f,A,b,[],[],l,[])
