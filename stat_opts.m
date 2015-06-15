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
## @deftypefn {Function File} {@var{retval} =} stat_opts (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

function  retval = stat_opts ()
retval=optimset("Display",1, "MaxFunEvals",2, "MaxIter",3, "TolBnd",4,"TolFun",5,...
"TolTypeFun",6, "TolX",7, "TolTypeX",8, "GradObj", 9,"Jacobian",10,...
"DerivStep",11, "FunValCheck",12, "RobustWgtFun",13,...
"Tune",14, "UseParallel",15, "UseSubstreams",16, "Streams",17, "OutputFcn",18);
endfunction
