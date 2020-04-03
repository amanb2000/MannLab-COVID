% function of three variables to be minimised
%
% best logonfit to data, by DIFFERENCE,  ie mimimise MSE deviation

function fun = dummy(modpars)   % 3 model parameters
% 3 vars to be optimised:

% want to mimimise mse err

% amplitude, centerfreq  and  final-initial freq
err = b98down1024.' - modpars(1)*logonwh(modpars(2),modpars(3),1024);

fun = err(:)'*err(:);

