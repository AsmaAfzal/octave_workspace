## Copyright (C) 2015 Asma Afzal
##
## Octave is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or (at
## your option) any later version.
##
## Octave is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING. If not, see
## <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {} lsqlin (@var{C}, @var{d})
## @deftypefnx {Function File} {} lsqlin (@var{C}, @var{d}, @var{A}, @var{b})
## @deftypefnx {Function File} {} lsqlin (@var{C}, @var{d}, @var{A}, @var{b}, @var{Aeq}, @var{beq})
## @deftypefnx {Function File} {} lsqlin (@var{C}, @var{d}, @var{A}, @var{b}, @var{Aeq}, @var{beq}, @var{lb}, @var{ub})
## @deftypefnx {Function File} {} lsqlin (@var{C}, @var{d}, @var{A}, @var{b}, @var{Aeq}, @var{beq}, @var{lb}, @var{ub}, @var{x0})
## @deftypefnx {Function File} {} lsqlin (@var{C}, @var{d}, @var{A}, @var{b}, @var{Aeq}, @var{beq}, @var{lb}, @var{ub}, @var{x0}, @var{options})
## @deftypefnx {Function File} {[@var{x}, @var{resnorm}, @var{residual}, @var{exitflag}, @var{output}] =} lsqlin (@dots{})
## Solve the linear least squares program
## @example
## @group
## min 0.5 EuclidianNorm(C*x - d)
## x
## @end group
## @end example
## subject to
## @example
## @group
## @var{A}*@var{x} <= @var{b},
## @var{Aeq}*@var{x} = @var{beq},
## @var{lb} <= @var{x} <= @var{ub}.
## @end group
## @end example
##
## The initial guess @var{x0} and the constraint arguments (@var{A} and
## @var{b}, @var{Aeq} and @var{beq}, @var{lb} and @var{ub}) can be set to
## the empty matrix (@code{[]}) if not given. If the initial guess
## @var{x0} is feasible the algorithm is faster.
##
## @var{options} can be set with @code{optimset}, currently the only
## option is @code{MaxIter}, the maximum number of iterations (default:
## 200).
##
## Returned values:
##
## @table @var
## @item x
## Position of minimum.
##
## @item resnorm
## Scalar value of objective as EuclidianNorm(C*x - d).
##
## @item residual
## Vector of solution residuals C*x - d.
##
## @item exitflag
## Status of solution:
##
## @table @code
## @item 0
## Maximum number of iterations reached.
##
## @item -2
## The problem is infeasible.
##
## @item 1
## Global solution found.
##
## @end table
##
## @item output
## Structure with additional information, currently the only field is
## @code{iteratios}, the number of used iterations.
## @end table
##
## This function calls Octave's @code{qp} function internally.
##
## @c Will be cut out in optims info file and replaced with the same
## @c refernces explicitely there, since references to core Octave
## @c functions are not automatically transformed from here to there.
## @c BEGIN_CUT_TEXINFO
## @seealso{qp, quadprog}
## @c END_CUT_TEXINFO
## @end deftypefn

## PKG_ADD: __all_opts__ ("lsqlin");

function varargout = lsqlin (varargin)

  nargs = nargin ();

  n_out = nargout ();
  varargout = cell (1, n_out);

  if (nargs == 1 && ischar (varargin{1}) && ...
    strcmp (varargin{1}, "defaults"))
    varargout{1} = optimset ("MaxIter", 200);
    return;
  endif

  if (nargs < 2 || nargs == 3 || nargs == 5 || nargs > 10)
    print_usage();
  endif

  ## one argument more than lsqlin has, this is for unused ALB of qp
  in_args = cat (2, varargin, cell (1, 11 - nargs));
  if (nargs < 10)
    in_args{10} = struct ();
  endif

  ## do the argument mapping
  arg1_ct = in_args{1}';
  in_args{2} = real (- arg1_ct * in_args{2});
  in_args{1} = arg1_ct * in_args{1};
  qp_args = in_args([9, 1, 2, 5, 6, 7, 8, 11, 3, 4, 10]);

  ## remove inequality constraint arguments if empty
  if (isempty (qp_args{10}))
    qp_args([8:11]) = [];
  endif

  if (n_out > 2)
    tn_out = n_out - 1;
  else
    tn_out = n_out;
  endif
  qp_n_out = max (1, min (tn_out, 3));
  qp_out = cell (1, qp_n_out);
  [qp_out{:}] = qp (qp_args{:});

  varargout{1} = qp_out{1};

  if (n_out >= 2)
    varargout{2} = 2 * (qp_out{2} + 0.5 * varargin{2}' * varargin{2});
  endif

  if (n_out >= 3)
    varargout{3} = varargin{1} * varargout{1} - varargin{2};
  endif

  if (n_out >= 4)
    switch (qp_out{3}.info)
    case 0
      varargout{4} = 1;
    case 3
      varargout{4} = 0;
    case 6
      varargout{4} = -2;
    otherwise
      error ("internal error: unexpected qp status of solution '%i'",
             qp_out{3}.info);
    endswitch
  endif

  if (n_out >= 5)
    varargout{5}.iterations = qp_out{3}.solveiter;
  endif

endfunction

%!test
%!shared C,d,A,b
%! C = [0.9501,0.7620,0.6153,0.4057;     0.2311,0.4564,0.7919,0.9354;    0.6068,0.0185,0.9218,0.9169;    0.4859,0.8214,0.7382,0.4102;    0.8912,0.4447,0.1762,0.8936];
%! d = [0.0578;    0.3528;    0.8131;    0.0098;    0.1388];
%! A =[0.2027,    0.2721,    0.7467,   0.4659;    0.1987,    0.1988,    0.4450,   0.4186;    0.6037 , 0.0152,    0.9318,    0.8462];
%! b =[0.5251;0.2026;0.6721];
%! Aeq = [3, 5, 7, 9];
%! beq = 4;
%! lb = -0.1*ones(4,1);
%! ub = 2*ones(4,1);
%! [x,resnorm,residual,exitflag,output] = lsqlin(C,d,A,b,Aeq,beq,lb,ub)
%! assert(x,[-0.10000;  -0.10000;   0.15991;   0.40896],10e-5)
%! assert(resnorm,0.16951,10e-5)
%! assert(residual, [0.035297; 0.087623;  -0.353251;   0.145270;   0.121232],10e-5)
%! assert(exitflag,1)
%! assert(output.iterations,3)

%!test
%! Aeq = [];
%! beq = [];
%! lb = [];
%! ub = [];
%! x0 = 0.1*ones(4,1);
%! x = lsqlin(C,d,A,b,Aeq,beq,lb,ub,x0)
%! [x,resnorm,residual,exitflag,output] = lsqlin(C,d,A,b,Aeq,beq,lb,ub,x0)
%! assert(x,[ 0.12986;  -0.57569 ;  0.42510;   0.24384],10e-5)
%! assert(resnorm,0.017585,10e-5)
%! assert(residual, [-0.0126033;  -0.0208040;  -0.1295084;  -0.0057389;   0.01372462],10e-5)
%! assert(exitflag,1)
%! assert(output.iterations,4)
