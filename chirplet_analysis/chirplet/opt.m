% function opt:
%
% removes DC and finds best fit
% calls opt_fun.m
%
% call: [f0,f1,fit] = opt(dat,fbeg_init,fend_init); % where _init are 1 by 3
% example: [f0,f1,fit] = opt(b98down1024,[-.01 0 .01],[-.03 -.04 -.05])
%                 necessary to choose good starting values so it wont get stuck

function [f0, f1, fit] = dum(b, x, y)

if nargin < 2
  x = [-.01 0 .01];    % need to use well chosen start pt...
end%if
if nargin < 3
  y = [-.03 -.04 -.05];
end%if

b = b-mean(b);

for itt = 1:50

  disp([x(2) y(2) opt_fun(b,[x(2) y(2)])/length(b)]) 

  [val ind] = min([opt_fun(b,[x(1),y(2)]) opt_fun(b,[x(2),y(2)]) opt_fun(b,[x(3),y(2)])]);
     % ind gives worst pt; here we want to MAXIMIZE not MINIMIZE the fun
  if ind == 1;   % first evaluation is worst...
    x = [x(2) x(3) 2*x(3)-x(2)];
  else%if
    x = [2*x(1)-x(2) x(1) x(2)];
  end%if

  [val ind] = min([opt_fun(b,[x(2),y(1)]) opt_fun(b,[x(2),y(2)]) opt_fun(b,[x(2),y(3)])]);
     % ind gives worst pt; here we want to MAXIMIZE not MINIMIZE the fun
  if ind == 1;   % first evaluation is worst...
    y = [y(2) y(3) 2*y(3)-y(2)];
  else%if
    y = [2*y(1)-y(2) y(1) y(2)];
  end%if

  if ~rem(itt,2)
    x = [.5*x(1)+.5*x(2)  x(2)  .5*x(2)+.5*x(3)];
    y = [.5*y(1)+.5*y(2)  y(2)  .5*y(2)+.5*y(3)];
                                           % compress inwards by 2*
  end%if
end%for

f0 = x(2);
f1 = y(2);   % return final frequencies
fit = opt_fun(b,[x y]);

