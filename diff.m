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
## @deftypefn {Function File} {@var{retval} =} diff (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Asma <Asma@ASMA-PC>
## Created: 2015-06-08

function [F,J] = diff (p)
 x = 1:10:100;
 x=x';
 y=[9.2160e-001, 3.3170e-001, 8.9789e-002, 2.8480e-002, 2.6055e-002,...
     8.3641e-003,  4.2362e-003,  3.1693e-003,  1.4739e-004,  2.9406e-004]';
 F= p(1)*exp(-p(2)*x)-y;
%J=[x,p(2)*x];
J=[exp(-p(2)*x),-p(1)*x.*exp(-p(2)*x)];
 endfunction
