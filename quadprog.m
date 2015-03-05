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
##

function varargout = quadprog(H,f, varargin)

   if(nargin<2)
        error ("quadprog: Input should be at least two arguments");
   endif

   if(nargin>10)
        error ("quadprog: Too many input arguments");
   endif

   if(nargout>5)
        error ("quadprog: Too many output arguments");
   endif   

   warning ("quadprog uses Octaves qp function");

  if(nargin==2)
    [x, obj, INFO, lambda]=  qp([],H,f);
  elseif(nargin==3)
    error("The number of rows in A must be the same as the length of b")
  elseif(nargin==4)
   [x, obj, INFO, lambda]=  qp([],H,f,[],[],[],[],[],varargin{1},varargin{2});
  elseif(nargin==5)
   [x, obj, INFO, lambda]=  qp([],H,f,varargin{3},[],[],[],[],varargin{1},varargin{2});
  elseif(nargin==6)
   [x, obj, INFO, lambda]=  qp([],H,f,varargin{3},varargin{4},[],[],[],varargin{1},varargin{2});
  elseif(nargin==7)
   [x, obj, INFO, lambda]=  qp([],H,f,varargin{3},varargin{4},varargin{5},[],[],varargin{1},varargin{2});
  elseif(nargin==8)
   [x, obj, INFO, lambda]=  qp([],H,f,varargin{3},varargin{4},varargin{5},varargin{6},[],varargin{1},varargin{2});
  elseif(nargin==9)
   [x, obj, INFO, lambda]=  qp(varargin{7},H,f,varargin{3},varargin{4},varargin{5},varargin{6},[],varargin{1},varargin{2});
  else
   [x, obj, INFO, lambda]=  qp(varargin{7},H,f,varargin{3},varargin{4},varargin{5},varargin{6},[],varargin{1},varargin{2},varargin{8});
  endif
  
   varargout{1}=x;
 
   if (nargout==2)
    varargout{2}=obj;
   elseif (nargout==3)
    varargout{2}=obj;
    varargout{3}=INFO;
   elseif (nargout==4)
    varargout{2}=obj;
    varargout{3}=INFO;
    varargout{4}=lambda;
   endif
    
endfunction
