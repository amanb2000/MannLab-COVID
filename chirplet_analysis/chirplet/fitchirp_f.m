% function of two variables to be minimised

function fun = dummy(frequencies) 
% 2 vars to be optimised:

% want to maximise normalised abs inner prod

% center freq and final-initial freq
%%%fun = -ipan(logonwh(frequencies(1),frequencies(2),1024),b98down1024);

% starting freq and ending freq
fun = -ipan(chirp(frequencies(1),frequencies(2),1024,1),b98down1024);

