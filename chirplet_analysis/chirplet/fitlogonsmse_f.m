% function of six variables to be minimised
%
% best logonfit to data, by DIFFERENCE,  ie mimimise MSE deviation

function fun = dummy(modpars)   % 3 model parameters
% 6 vars to be optimised:

% want to mimimise mse err

% amplitude, centerfreq  and  final-initial freq
logon1 = modpars(1)*logonwh(modpars(2),modpars(3),1024);
logon2 = modpars(4)*logonwh(modpars(5),modpars(6),1024);
err = b98down1024.' - logon1 - logon2;

fun = err(:)'*err(:);

