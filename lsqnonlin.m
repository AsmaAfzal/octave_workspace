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
## @deftypefn {Function File} {} lsqnonlin (@var{fun}, @var{x0})
## @deftypefnx {Function File} {} lsqnonlin (@var{fun}, @var{x0}, @var{lb}, @var{ub})
## @deftypefnx {Function File} {} lsqnonlin (@var{fun}, @var{x0}, @var{lb}, @var{ub}, @var{options})
## @deftypefnx {Function File} {[@var{x}, @var{resnorm}, @var{residual}, @var{exitflag}, @var{output}, @var{lambda}, @var{jacobian}] =} lsqnonlin (@dots{})
## Solve nonlinear least-squares (nonlinear data-fitting) problems
## @example
## @group
## min [EuclidianNorm(f(x))] .^ 2
##  x   
## @end group
## @end example
## 
## The initial guess @var{x0} must be provided while the bounds @var{lb} and @var{ub}) can be set to
## the empty matrix (@code{[]}) if not given.
##
## @var{options} can be set with @code{optimset}
##
## Returned values:
##
## @table @var
## @item x
## Position of minimum.
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
## This function calls Octave's @code{nonlin_residmin} function internally.
## @end deftypefn

## PKG_ADD: __all_opts__ ("lsqnonlin");

function varargout = lsqnonlin (varargin)

  nargs = nargin ();
  out_args = nargout ();
  varargout = cell (1, out_args);
  
  if (nargs < 2 || nargs==3 || nargs > 5)
    print_usage ();
  endif
  
  in_args{1} = varargin{1};
  in_args{2} = real (varargin{2}(:));
  
  if (nargs >= 4)
    settings = optimset ("lbound", varargin{3}(:), "ubound", varargin{4}(:));          
    if (nargs == 5)
      settings = optimset (settings, varargin{5});
    endif  
    in_args(3) = settings;
  endif

  n_out = max (1, min (out_args, 5)); 
   
  if (n_out > 2)
    n_out = n_out - 1;
  endif
  
  residmin_out = cell (1, n_out);

  [residmin_out{:}] =  nonlin_residmin (in_args{:});

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
    varargout{5} = residmin_out{4};
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
     varargout{7} = sparse (jacobs (residmin_out{1}, in_args{1}));
  endif
  
endfunction