% logonwh = logonwh(fc,fend-fbeg,N,p,sigma)     %      steve mann, 1990 oct. 22
%
% generates a LINEAR chirped signal
% with parameters "comfortable" in Weyl Hiesenberg space (eg. cent freq
% in cy/pixel, and kernel length explicit, rather than scale explicit)
%
% where:
% fc = center FRACTIONAL frequency  (-.5 to .5)
% fend_fbeg = end freq - beg freq    % DEFAULTS to 0, for nonchirping exp. wave
% N = number of samples  % DEFAULTS to 100 pts. for quick plots
% p = norm of output (env is unit L^p norm, so logon is unit Lp)
% p DEFAULTS to 2 (ie logon defaults to unit ENERGY if p not specified)
%
% sigma DEFAULTs to N/6, to give 3sigma on each side of center sample


function g = dummy_name(fc,fend_fbeg,N,p,sigma)

%%% nargin< 4 gives unit L2 norm
if nargin < 3
  N = 100;   % nice for quick plots
end%if
if nargin < 2
  fend_fbeg = 0;
%%%%  disp('freq. diff =0 given, so a steady tone will be produced')
end%if
if nargin < 5
  sigma = N/6;  % the 3sigma has most of it
end%if

f0 = fc - fend_fbeg/2;
f1 = fc + fend_fbeg/2;

indices=1:N;
f=f0+(f1-f0)/N.*indices/2;
g = exp(2*pi*sqrt(-1).*indices.*f);

t = -(N-1)/2:(N-1)/2;  % timebase for gauss env
env = 1/sqrt(sqrt(pi)*sigma) * exp(-1/2*(t/sigma).^2); % const. L2 norm (const area of energy)
% need div by sqrt(sigma) for unit L2, not sqrt(sigma^2) = sigma as for unit L1
% also need div by sqrt(sqrt(pi)), not sqrt(2pi) 

if nargin > 3 % a preferred norm was specified
  env = env/norm(env,p);
end%if

g = g.*env;

