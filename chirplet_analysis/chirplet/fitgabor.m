% function of one variable to be minimised

function fun = dummy(freq)

% want to maximise normalised abs inner prod
fun = -ipan(logonwh(freq,0,256),b98const);  % best tone fit

