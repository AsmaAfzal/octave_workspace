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
## @deftypefn  {Function File} {@var{x} =} quadprog (@var{H})
## @deftypefn  {Function File} {@var{x} =} quadprog (@var{H},@var{f})
## @deftypefn  {Function File} {@var{x} =} quadprog (@var{H},@var{f},@var{A})
## @deftypefn  {Function File} {@var{x} =} quadprog (@var{H},@var{f},@var{A},@var{b})
## @deftypefn  {Function File} {@var{x} =} quadprog (@var{H},@var{f},@var{A},@var{b},@var{Aeq})
## @deftypefn  {Function File} {@var{x} =} quadprog (@var{H},@var{f},@var{A},@var{b},@var{Aeq},@var{beq})
## @deftypefn  {Function File} {@var{x} =} quadprog (@var{H},@var{f},@var{A},@var{b},@var{Aeq},@var{beq},@var{lb})
## @deftypefn  {Function File} {@var{x} =} quadprog (@var{H},@var{f},@var{A},@var{b},@var{Aeq},@var{beq},@var{lb},@var{ub})
## @deftypefn  {Function File} {@var{x} =} quadprog (@var{H},@var{f},@var{A},@var{b},@var{Aeq},@var{beq},@var{lb},@var{ub},@var{x0})
## @deftypefn  {Function File} {@var{x} =} quadprog (@var{H},@var{f},@var{A},@var{b},@var{Aeq},@var{beq},@var{lb},@var{ub},@var{x0},@var{options})
## @deftypefn  {Function File} {[@var{x},@var{fval}] =} quadprog (@var{H},@var{f},@var{A},@var{b},@var{Aeq},@var{beq},@var{lb},@var{ub},@var{x0},@var{options})
## @deftypefn  {Function File} {[@var{x},@var{fval},@var{exitflag}] =} quadprog (@var{H},@var{f},@var{A},@var{b},@var{Aeq},@var{beq},@var{lb},@var{ub},@var{x0},@var{options})
## @deftypefn  {Function File} {[@var{x},@var{fval},@var{exitflag},@var{output}] =} quadprog (@var{H},@var{f},@var{A},@var{b},@var{Aeq},@var{beq},@var{lb},@var{ub},@var{x0},@var{options})
## @deftypefn  {Function File} {[@var{x},@var{fval},@var{exitflag},@var{output},@var{lambda}] =} quadprog (@var{H},@var{f},@var{A},@var{b},@var{Aeq},@var{beq},@var{lb},@var{ub},@var{x0},@var{options})
## Solve the quadratic program
## For doc see the doc for 'qp'
## This function provides a MATLAB compatible interface for 'quadprog' 
## It is a wrapper around Octave's 'qp' function.
## The notation for quadprog in MATLAB is different from qp in Octave.
## @end deftypefn

function varargout = quadprog (varargin)

  warning ("quadprog uses Octaves qp function");

  nargs = nargin ();
  outargs = nargout();

  if (nargs < 2 || nargs == 3 || nargs == 5 || nargs > 10 || outargs > 5)
    print_usage();
  endif

  ## one argument more than quadprog has, this is for unused ALB of qp
  in_args = cat (2, varargin, cell (1, 11 - nargs)); 

  ## do the argument mapping
  qp_args = in_args([9, 1, 2, 5, 6, 7, 8, 11, 3, 4, 10]);

  ## remove inequality constraint arguments if empty
  if (isempty (qp_args{10}))
    qp_args([8:11]) = [];
  elseif (isstruct (varargin{end}))
    qp_args(11) = varargin{end};
  else
    qp_args(11) = struct();
  endif
  
  [x, obj, INFO, lambda] =  qp (qp_args{:});

  varargout{1} = x;

  if (outargs >= 2)
    varargout{2} = obj;
  endif
 
  if (outargs >= 3)
    if (INFO.info == 0)
      varargout{3} = 1;
    elseif (INFO.info == 1)
      varargout{3} = -6;
    elseif (INFO.info == 2)
      varargout{3} = -3;
    elseif (INFO.info == 3)
      varargout{3} = 0;
    else
      varargout{3} = -2;
    endif
  endif
   
  if (outargs >= 4)
    varargout{4}.iterations = INFO.solveiter;
  endif

  if (outargs >= 5)
    varargout{5} = lambda;
  endif

endfunction
