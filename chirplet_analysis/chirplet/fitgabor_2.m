% for use with fsolve instead of fmin
%
% function to be zeroed rather than minimised

function fun = dummy(freqamp)   % both vars must be passed in single var!

% want to maximise normalised abs inner prod
fun = sum(abs(b98down1024 - freqamp(1)*chirp(freqamp(2),freqamp(2),1024,1).'));

