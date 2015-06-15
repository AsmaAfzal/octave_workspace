x = 0:5;
y = [10, 5, 3, 2, 1.5, 1];
f = @ (p, x) p(1) * exp (p(2) * x);
pin = [1; 1];
[p, fy, cvg, outp] = nonlin_curvefit (f, pin, x, y);
info = curvefit_stat (f, p, x, y, optimset ("ret_dfdp", true,  "ret_covp", true, "objf_type", "wls"));