## Copyright (C) 2015 Asma Afzal
## Copyright (C) 2015 Olaf Till <i7tiol@t-online.de>
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
## @deftypefn {Function File} {} quadprog (@var{H}, @var{f})
## @deftypefnx {Function File} {} quadprog (@var{H}, @var{f}, @var{A}, @var{b})
## @deftypefnx {Function File} {} quadprog (@var{H}, @var{f}, @var{A}, @var{b}, @var{Aeq}, @var{beq})
## @deftypefnx {Function File} {} quadprog (@var{H}, @var{f}, @var{A}, @var{b}, @var{Aeq}, @var{beq}, @var{lb}, @var{ub})
## @deftypefnx {Function File} {} quadprog (@var{H}, @var{f}, @var{A}, @var{b}, @var{Aeq}, @var{beq}, @var{lb}, @var{ub}, @var{x0})
## @deftypefnx {Function File} {} quadprog (@var{H}, @var{f}, @var{A}, @var{b}, @var{Aeq}, @var{beq}, @var{lb}, @var{ub}, @var{x0}, @var{options})
## @deftypefnx {Function File} {[@var{x}, @var{fval}, @var{exitflag}, @var{output}] =} quadprog (@dots{})
## Solve the quadratic program
## @example
## @group
## min 0.5 x'*H*x + x'*f
##  x
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
## the empty matrix (@code{[]}) if not given.  If the initial guess
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
## @item fval
## Value at the minimum.
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
## @item -3
## The problem is not convex and unbounded
##
## @item 1
## Global solution found.
##
## @item 4
## Local solution found.
## @end table
##
## @item output
## Structure with additional information, currently the only field is
## @code{iteratios}, the number of used iterations.
## @end table
##
## This function calls Octave's @code{qp} function internally.
## @end deftypefn

## PKG_ADD: __all_opts__ ("quadprog");

function varargout = quadprog (varargin)

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

  ## one argument more than quadprog has, this is for unused ALB of qp
  in_args = cat (2, varargin, cell (1, 11 - nargs));
  if (nargs < 10)
    in_args{10} = struct ();
  endif

  ## do the argument mapping
  qp_args = in_args([9, 1, 2, 5, 6, 7, 8, 11, 3, 4, 10]);

  ## remove inequality constraint arguments if empty
  if (isempty (qp_args{10}))
    qp_args([8:11]) = [];
  endif
  
  qp_n_out = max (1, min (n_out, 3));

  qp_out = cell (1, qp_n_out);

  [qp_out{:}] =  qp (qp_args{:});

  varargout{1} = qp_out{1};

  if (n_out >= 2)
    varargout{2} = qp_out{2};
  endif
 
  if (n_out >= 3)
    switch (qp_out{3}.info)
      case 0
        varargout{3} = 1;
      case 1
        varargout{3} = 4;
      case 2
        varargout{3} = -3;
      case 3
        varargout{3} = 0;
      case 6
        varargout{3} = -2;
    endswitch
  endif
   
  if (n_out >= 4)
    varargout{4}.iterations = qp_out{3}.solveiter;
  endif

endfunction
