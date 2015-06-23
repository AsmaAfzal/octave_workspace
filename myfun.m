## Copyright (C) 2015 Asma
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} myfun (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Asma <Asma@ASMA-PC>
## Created: 2015-06-02

%function [f,j] = myfun (c,t)
%f = c(1) + c(2)*exp(-t);
%j(1:length(t),1)=1;
%j(1:length(t),2)=exp(-t);
%endfunction

function w= myfun(a,varargin)
w=nargin;
endfunction