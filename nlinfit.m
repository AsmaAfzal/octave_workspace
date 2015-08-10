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
## @deftypefn {Function File} {} nlinfit (@var{X}, @var{Y}, @var{modelfun}, @var{beta0})
## @deftypefnx {Function File} {} nlinfit (@var{X}, @var{Y}, @var{modelfun}, @var{beta0}, @var{options})
## @deftypefnx {Function File} {} nlinfit (@dots{}, @var{Name}, @var{Value})
## @deftypefnx {Function File} {[@var{beta}, @var{R}, @var{J}, @var{CovB}, @var{MSE}] =} nlinfit (@dots{})
## Nonlinear Regression using Iteratively Reweighted Least Squares (IRLS) Method. 
##
## @example
## @group
## min sum w(i) * [EuclidianNorm (Y(i) - modelfun (beta, X(i)))] .^ 2
##      i
## @end group
## @end example
##
## @var{X} is a matrix of independents, @var{Y} is the observed output and @var{modelfun} is the nonlinear regression model function.
## @var{modelfun} should be specified as a function handle, which accepts two inputs: an array of coefficients and an array of independents- in that order.
## The first four input arguments must be provided with non-empty initial guess of the coefficients @var{beta0}. 
## @var{Y} and @var{X} must be the same size as the vector (or matrix) returned by @var{fun}.
## @var{options} is a structure containing estimation algorithm options. It can be set using @code{statset}. Optional @var{Name}, 
## @{Value} pair can be provided to set additional options. Currently the only applicable name-value pair is 'Weights', w, where w is the array of real positive weights .
##
## Returned values:
##
## @table @var
## @item beta
## Coefficients to best fit the nonlinear function modelfun (beta, X) to the observed values Y.
##
## @item R
## Value of solution residuals EuclidianNorm (modelfun (beta, X)).
## If observation weights are specified then @var{R} is the array of weighted residuals.
##
## @item J
## m-by-n matrix, where @var{J(i,j)} is the partial derivative of @var{modelfun(i)} with respect to @var{x(j)}.
## If observation weights are specified then @var{J} is the weighted  model function Jacobian.
##
## @item CovB
## p-by-p matrix of estimated covariance matrix for the fitted coefficients, where p is the number of fitted coefficients.
## If the model Jacobian is full rank, then CovB = inv (J' * J) * MSE, where MSE is the mean-squared error.
##
## @item MSE
## Scalar valued estimate of the variance of error term. If the model Jacobian is full rank, then MSE = (R' * R)/(N-p), 
## where N is the number of observations and p is the number of estimated coefficients.
## @end table
##
## This function calls Octave's @code{nonlin_curvefit} and @code{curvefit_stat} functions internally. 
## 
## @end deftypefn

## PKG_ADD: __all_stat_opts__ ("nlinfit");

function varargout = nlinfit (varargin)

  nargs = nargin ();
  
  TolFun_default = 1e-8;
  MaxIter_default = 100;
  DerivStep_default = eps ^ (1/3);
  
   if (nargs == 1 && ischar (varargin{1}) && strcmp (varargin{1}, "defaults"))
    varargout{1} = optimset ("DerivStep", DerivStep_default,...
		             "TolFun", TolFun_default,...
		             "MaxIter", MaxIter_default,...
		             "Display", "off");
    return;
  endif
  
  if (nargs < 4 || nargs==6 || nargs > 7)
    print_usage ();
  endif
  
   if (! isreal (varargin{4}))
    error("Function does not accept complex inputs. Split into real and imaginary parts")
  endif
  
  out_args = nargout ();
  varargout = cell (1, out_args);
    modelfun = varargin{3};
  in_args{1} = varargin{3};
  in_args{2} = varargin{4}(:);
  in_args(3:4) = varargin(1:2);
  settings = struct ();
  
  if (nargs >= 5)
    if (isempty (varargin{5}))
      settings = struct ();
    else
      settings = varargin{5};
    endif
    ## apply default values which are possibly different from those of
    ## nonlin_curvefit
    DerivStep = statget (settings, "DerivStep", DerivStep_default);
    TolFun = statget (settings, "TolFun", TolFun_default); 
    MaxIter = statget (settings, "MaxIter", MaxIter_default);
    settings = optimset (settings, "FinDiffRelStep", DerivStep,...
                           "TolFun", TolFun,...
                           "MaxIter", MaxIter);
    in_args{5} = settings;
  endif
  
  if (nargs == 7)
  ## weights are specified in a different way for nonlin_curvefit
    if (strcmpi (varargin{6}, "weights") ) 
      settings = optimset (settings, "weights", varargin{7});
      in_args{5} = settings;
    else
      error ("Unidentified Name-value pair input.")
    endif   
  endif

  n_out = max (1, min (out_args, 2)); 
  
  nlinfit_out = cell (1, n_out);

  [nlinfit_out{:}] =  nonlin_curvefit (in_args{:});
  
  varargout{1} = nlinfit_out{1};

  if (out_args >= 2)
    if (nargs == 7)
     ## weighted residual
      varargout{2} = sqrt (varargin{7}).* (in_args{4} - nlinfit_out{2});
    else
      varargout{2} = in_args{4} - nlinfit_out{2};
    endif
  endif
  
  if (out_args >= 3)
    info = curvefit_stat (modelfun, nlinfit_out{1}, in_args{3}, in_args{4},
                                 optimset (settings, "ret_dfdp", true, "ret_covp", true, "objf_type", "wls"));
    if (nargs == 7)
      ## weighted Jacobian
      weights = repmat (varargin{7}, 1, length (in_args{2}));
      varargout{3} = sqrt (weights) .* info.dfdp;
    else
      varargout{3} = info.dfdp;
    endif
  endif
  
  if (out_args >= 4)
    varargout{4} = info.covp;
  endif

  if (out_args >= 5)
    varargout{5} = (varargout{2}' * varargout{2}) / (length (in_args{3}) - length (in_args{2}));
  endif 
endfunction

%!test
%! modelfun = @(b, x) (b(1) + b(2) * exp (- b(3) * x));
%! b = [1;3;2];
%! xdata = exprnd (2,100,1);
%! ydata = modelfun (b,xdata) + normrnd (0,0.1,100,1);
%! beta0 = [2;2;3];
%! beta = nlinfit(xdata,ydata,modelfun,beta0);
%! assert (beta, [1;3;2], 1e-1)

%!demo
%! %% modelfun = @(b, x) (b(1) + b(2) * exp(- b(3) * x));
%! %% actual value beta = [1;3;2]
%! %% x = exponentially distributed random variable
%! x = [3.49622; 0.33751; 1.25675; 3.66981; 0.26237; 5.51095;...
%!      2.11407; 1.48774; 6.22436; 2.04519];
%! %% y_actual = modelfun(beta,x)     
%! y_actual = [1.0028; 2.5274; 1.2430; 1.0019; 2.7751; 1.0000;...
%!            1.0437; 1.1531; 1.0000; 1.0502];
%! %% y_noisy = y_actual + noise           
%! y_noisy =  [1.17891; 2.46055; 1.47400; 0.95433; 2.66687; 1.12279;...
%!            1.10664; 1.30461; 1.11601; 0.95274];
%! %% initial guess           
%! beta0 = [2;2;2];
%! %% weight vector
%! weights = [5; 16; 1; 20; 12; 11; 17; 8; 11; 13];
%! beta = nlinfit(x,y_noisy,modelfun,beta0)
%! beta = nlinfit(x,y_noisy,modelfun,beta0,[],"weights",weights)