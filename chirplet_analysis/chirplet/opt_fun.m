% finds similarity to chirp for some arbitrary fun...
%
% this is the fuction to be used by the optimization package
%
% we wish to MAXIMIZ this fun.
%
% call:     goddness = opt_fun(dat,state_vector)
% example:  goodness = opt_fun(b9825(1:255), [f0 f1])

function similarity_abs = dummy(dat,f)

similarity_abs = abs(chirp(f(1),f(2),length(dat),1) * conj(dat(:)));

