% fit_logons_mse  (fit logons with mean sqr err criterion)
%
% function of 3 variables to be minimised
%
% best logonfit to data, by DIFFERENCE,  ie mimimise MSE deviation
%
% uses neldar simplex "fmins"

if ~exist('b98down1024')
  disp('loading in data file b98down1024')
  b98down1024 = b98down1024 - mean(b98down1024);
  disp('subtracted mean')
end%if

global b98down1024    % cannot do a global inside "if" block
disp('declared global')

hold off
clg

initpars = [1;-.006;-.03]

pars = fmins('fitlogonmse_f',initpars);

logon = pars(1)*logonwh(pars(2),pars(3),1024);

subplot(211)
axis([0 1024 min(real(b98down1024))*1.1 max(real(b98down1024))*1.1])
plot(real(b98down1024))
title('real part of test data')
errs = b98down1024.' - logon;
err = errs(:)'*errs(:);
xlabel(sprintf('error in fit = %g',err))

axis([0 1024 min(real(logon))*1.1 max(real(logon))*1.1])
plot(real(logon))
title('real part of best fit logon')
xlabel(sprintf('amplitude=%g  fcent=%g  f1_f0=%g',pars(1),pars(2),pars(3)))

