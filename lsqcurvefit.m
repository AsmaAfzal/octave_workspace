## Copyright (C) 2015 Asma Afzal
##
## Octave is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or (at
## your option) any later version.
##
## Octave is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {} lsqcurvefit (@var{fun}, @var{x0}, @var{xdata}, @var{ydata})
## @deftypefnx {Function File} {} lsqcurvefit (@var{fun}, @var{x0}, @var{xdata}, @var{ydata}, @var{lb}, @var{ub})
## @deftypefnx {Function File} {} lsqcurvefit (@var{fun}, @var{x0}, @var{xdata}, @var{ydata}, @var{lb}, @var{ub}, @var{options})
## @deftypefnx {Function File} {[@var{x}, @var{resnorm}, @var{residual}, @var{exitflag}, @var{output}, @var{lambda}, @var{jacobian}] =} lsqcurvefit (@dots{})
## Solve nonlinear least-squares (nonlinear data-fitting) problems
## @example
## @group
## min sum [EuclidianNorm (f(x,xdata(i)) -ydata(i) )] .^ 2
##  x     i
## @end group
## @end example
## 
## The first four input arguments must be provided with non-empty initial guess @var{x0}. If the Jacobian is set to "on" in @var{options} 
## then @var{fun} must return a second argument providing a user-sepcified Jacobian. For a given input @var{xdata}, @var{ydata} is the observed output. 
## @var{ydata} must be the same size as the vector (or matrix) returned by @var{fun}. The optional bounds @var{lb} and @var{ub} should be the same size as @var{x0}.
## @var{options} can be set with @code{optimset}
##
## Returned values:
##
## @table @var
## @item x
## Coefficients to best fit the nonlinear function fun(x,xdata) to the observed values ydata.
##
## @item resnorm
## Scalar value of objective as squared EuclidianNorm(f(x)).
##
## @item residual
## Value of solution residuals EuclidianNorm(f(x)).
##
## @item exitflag
## Status of solution:
##
## @table @code
## @item 0
## Maximum number of iterations reached.
##
## @item 1
## Solution x found.
##
## @item 2
## Change in x was less than the specified tolerance.
##
## @item 3
## Change in the residual was less than the specified tolerance.
##
## @item -1
## Output function terminated the algorithm.
## @end table
##
## @item output
## Structure with additional information, currently the only field is
## @code{iterations}, the number of used iterations.
## @end table
##
## This function calls Octave's @code{nonlin_curvefit} function internally.
## @end deftypefn

## PKG_ADD: __all_opts__ ("lsqcurvefit");

function varargout = lsqcurvefit (varargin)

  nargs = nargin ();
  modelfun = varargin{1};
  
  if (nargin == 1 && ischar (modelfun) && strcmp (modelfun, "defaults"))
    p = optimset (
		  "max_fract_change", [], \
		  "fract_prec", [], \
		  "diffp", [], \
		  "TolFun", stol_default, \
      "TolX", stol_default, \
		  "MaxIter", [], \
		  "Display", "off", \
 		  "Jacobian", "off", \
		  "Algorithm", "lm_svd_feasible", \
		  "plot_cmd", @ (f) 0, \
		  "lm_svd_feasible_alt_s", false);
    return;
  endif

  if (nargs < 4 || nargs==5 || nargs > 7)
    print_usage ();
  endif
  
   if (! isreal (varargin{2}))
    error('function does not accept complex inputs. Split into real and imaginary parts')
  endif
  
  out_args = nargout ();
  varargout = cell (1, out_args);
  in_args{1} = varargin{1};
  in_args{2} = varargin{2}(:);
  in_args(3:4) = varargin(3:4);
  
  if (nargs >= 6)
    settings = optimset ("lbound", varargin{5}(:), "ubound", varargin{6}(:));       
    if (nargs == 7)
      settings = optimset (settings, varargin{7});
      if (strcmp (optimget (settings, "Jacobian"), "on")) 
          settings = optimset ("dfdp", @(p) computeJacob (modelfun, p, in_args{3}));
      endif
    endif
    in_args{5} = settings;
  endif
  
  n_out = max (1, min (out_args, 5)); 
   
  if (n_out > 2)
    n_out--;
  endif
  
  curvefit_out = cell (1, n_out);

  [curvefit_out{:}] =  nonlin_curvefit (in_args{:});
  
  [row, col] = size (in_args{2});
  varargout{1} = reshape (curvefit_out{1}, row, col);

  if (out_args >= 2)
    varargout{2} = sum ((curvefit_out{2}-in_args{4}) .^ 2);
  endif
  
  if (out_args >= 3)
    varargout{3} = curvefit_out{2}-in_args{4};
  endif
  
  if (out_args >= 4)
    varargout{4} = curvefit_out{3};
  endif

  if (out_args >= 5)
    outp = curvefit_out{4};
    outp = rmfield (outp, 'lambda');
    varargout{5} = outp;
  endif
  
  if (out_args >= 6)
    varargout{6} = curvefit_out{4}.lambda;
  endif
  
  if (out_args >= 7)
    info = residmin_stat (modelfun, curvefit_out{1}, optimset (settings, "ret_dfdp", true));
    varargout{7} = sparse (info.dfdp);
  endif
  
endfunction

function Jacob = computeJacob (modelfun, p, xdata)
  [~, Jacob] = modelfun (p, xdata);
endfunction