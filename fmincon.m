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
## @deftypefn {Function File} {} fmincon (@var{fun}, @var{x0}, @var{A}, @var{b})
## @deftypefn {Function File} {} fmincon (@var{fun}, @var{x0}, @var{A}, @var{b}, @var{Aeq}, @var{beq})
## @deftypefnx {Function File} {} fmincon (@var{fun}, @var{x0}, @var{A}, @var{b}, @var{Aeq}, @var{beq}, @var{lb}, @var{ub})
## @deftypefnx {Function File} {} fmincon (@var{fun}, @var{x0}, @var{A}, @var{b}, @var{Aeq}, @var{beq}, @var{lb}, @var{ub}, @var{nonlcon})
## @deftypefnx {Function File} {} fmincon (@var{fun}, @var{x0}, @var{A}, @var{b}, @var{Aeq}, @var{beq}, @var{lb}, @var{ub}, @var{nonlcon}, @var{options})
## @deftypefnx {Function File} {[@var{x}, @var{fval}, @var{exitflag}, @var{output}, @var{lambda}, @var{grad}, @var{hessian}] =} fmincon (@dots{})
## Find minimum of nonlinear constrained scalar objective function
## @example
## @group
## min f(x)
##  x   
## @end group
## @end example
## subject to
## @example
## @group
## @var{A}*@var{x} <= @var{b},
## @var{Aeq}*@var{x} = @var{beq},
## @var{lb} <= @var{x} <= @var{ub},
## @code{c(x)} <= 0,
## @code{ceq(x)} <= 0.
## @end group
## @end example
##
## @var{fun} is the scalar objective function to be minimized. @var{A} and @var{Aeq} are the linear constraint matrices and @var{b} and @var{beq} 
## are the corresponding vectors. @var{nonlcon} is the function computing the nonlinear inequality and equality constraints. This function accepts 
## the vector @var{x} as input and gives the two output vectors @var{c(x)} and @var{ceq(x)}. 
## @var{Y} and @var{X} must be the same size as the vector (or matrix) returned by @var{fun}.
## @var{options} is a structure containing estimation algorithm options. It can be set using @code{optimset}. If the option @code{GradObj} is set to 
## @code{on}, @var{fun} must return a second output argument containing the gradient vector, @code{g(x)}. If the option @code{Hessian} os set to 
## @code{user-supplied}, @var{fun} must return a third output argument containing the hessian matrix, @code{h(x)}. If the option @code{GradConstr} is set to 
## @code{on}, @var{nonlcon} must also return, in the third and fourth output arguments, GC, the gradient of c(x), and GCeq, the gradient of ceq(x).
##
## Returned values:
##
## @table @var
## @item x
## Position of minimum.
##
## @item fval
## Scalar value of objective at the minimum.
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
## Change in the objective function was less than the specified tolerance.
##
## @item -1
## Output function terminated the algorithm.
## @end table
##
## @item output
## Structure with additional information, currently the only field is
## @code{iterations}, the number of used iterations.
##
## @item lambda
## Structure containing Lagrange multipliers at the solution @var{x} sepatared by constraint type.
##
## @item gradient
## Vector, where @var{gradient(i)} is the partial derivative of @var{fun} with respect to @var{x(i)}
## As a default, fmincon approximates the Jacobian using finite differences.
##
## @item hessian
## Symmetric matrix of second derivative of the Lagrangian.
##
## @end table
##
## This function calls Octave's @code{nonlin_min} function internally.
## @end deftypefn

## PKG_ADD: __all_opts__ ("fmincon");

function varargout = fmincon (f, x0, varargin)
  nargs = nargin ();
  
  TolFun_default = 1e-6;
  MaxIter_default = 400;
  TypicalX_default = 1;
  
  if (nargs == 1 && ischar (f) && strcmp (f, "defaults"))
    varargout{1} = optimset ("FinDiffRelStep", [],...
              "FinDiffType", "forward",...
                             "TypicalX", TypicalX_default,...
               "TolFun", TolFun_default,...
               "MaxIter", MaxIter_default,...
               "Display", "off",...
                "Jacobian", "off",...
               "Algorithm", "lm_svd_feasible");
    return;
  endif
  
  if (nargs < 4 || nargs == 5  || nargs == 7  || nargs > 10)
    print_usage ();
  endif
  
  out_args = nargout ();
  varargout = cell (1, out_args);
  in_args{1, 2} = {f, x0};
  inequc = cell(1,4);
  equc = cell(1,4);
  
  if (nargs >= 4)
      ## linear constraints are specified in a different way for nonlin_min
     inequc{1:2} = {{varargin{1}(:), varargin{2}(:)}}; 
  endif  

  if (nargs >=6)
     equc{1:2} = {{varargin{3}(:), varargin{4}(:)}}; 
  endif
  
  if (nargs >= 8)
     ## bounds are specified in a different way for nonlin_min
     settings = optimset (settings, "lbound", varargin{5}(:),
                         "ubound", varargin{6}(:));
  endif
    
  if (nargs >= 9)
     ## nonlinear constraints specified in a different way for nonlin_min
     [c, ceq] = 
     settings = optimset (settings, "lbound", varargin{5}(:),
                         "ubound", varargin{6}(:));
  endif
  
  
      settings = optimset (settings, varargin{5});

      ## Jacobian function is specified in a different way for
      ## nonlin_min
      if (strcmpi (optimget (settings, "Jacobian"), "on")) 
          settings = optimset (settings,
                               "dfdp", @(p) computeJacob (modelfun, p));
      endif

      ## apply default values which are possibly different from those of
      ## nonlin_min
      FinDiffType = optimget (settings, "FinDiffType", "forward");
      if (strcmpi (FinDiffType, "forward"))
        FinDiffRelStep_default = sqrt (eps);
      elseif (strcmpi (FinDiffType, "central"))
        FinDiffRelStep_default = eps^(1/3);
      else
        error ("unknown value of option 'FinDiffType': %s",
               FinDiffType);
      endif
      FinDiffRelStep = optimget (settings, "FinDiffRelStep",
                                 FinDiffRelStep_default);
      TolFun = optimget (settings, "TolFun", TolFun_default);
      MaxIter = optimget (settings, "MaxIter", MaxIter_default);
      settings = optimset (settings,
                           "FinDiffRelStep", FinDiffRelStep,
                           "FinDiffType", FinDiffType,
                           "TolFun", TolFun,
                           "TypicalX", TypicalX_default,
                           "MaxIter", MaxIter);
    endif

    in_args{3} = settings; 
  endif

  n_out = max (1, min (out_args, 5)); 
   
  if (n_out > 2)
    n_out--;
  endif
  
  residmin_out = cell (1, n_out);

  [residmin_out{:}] =  nonlin_min (in_args{:});

  varargout{1} = residmin_out{1};

  if (out_args >= 2)
    varargout{2} = sum (residmin_out{2} .^ 2);
  endif
  
  if (out_args >= 3)
    varargout{3} = residmin_out{2};
  endif
  
  if (out_args >= 4)
    varargout{4} = residmin_out{3};
  endif

  if (out_args >= 5)
    outp = residmin_out{4};
    outp = rmfield (outp, 'lambda');
    varargout{5} = outp;
  endif
  
  if (out_args >= 6)
    varargout{6} = residmin_out{4}.lambda;
  endif
  
  if (out_args >= 7)
    info = residmin_stat (modelfun, residmin_out{1}, optimset (settings, "ret_dfdp", true));
    varargout{7} = info.dfdp;
  endif
  
endfunction

function Jacob = compute (modelfun, p)
  [~, Jacob] = modelfun (p);
endfunction