% fit_logons_mse  (fit logons with mean sqr err criterion)
%
% function of six variables to be minimised
%
% best logonfit to data, by DIFFERENCE,  ie mimimise MSE deviation
%
% uses neldar simplex "fmins"

if ~exist('b98down1024')
  disp('loading in data file b98down1024')
  b98down1024 = b98down1024 - mean(b98down1024);
  disp('subtracted mean')
end%if

global b98down1024
disp('declared global')

initpars = [1;-.006;-.03;1;-.006;-.03]

pars = fmins('fitlogonsmse_f',initpars);

logon1 = pars(1)*logonwh(pars(2),pars(3),1024);
logon2 = pars(4)*logonwh(pars(5),pars(6),1024);
subplot(221)

plot(real(logon1))
title('real part of logon 1')

plot(real(b98down1024))
title('real part of test data')

plot(real(logon2))
title('real part of logon 2')

plot(logon1+logon2)
title('sum of the 2 best fit "wavelets"')
errs = b98down1024.' - logon1 - logon2;
err = errs(:)'*errs(:);
xlabel(sprintf('error in fit = %g,err))

