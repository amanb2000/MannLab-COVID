% plots out prob of det versus prob false alm
% assumes "d" contains difference in mahalanobis distances from each class
%
% basically steps through a range of thresholds (offset by MAP requirement if
% desired).  for each threshold we have certain num of targets missed
% (certain num of class 1 classified as 2) which are 1-prob of det
% also have certain num of class 2 miss classified as 1, which are false alarms

axis([0 1 0 1])

for k = 1:max(d)+min(d);

  t = (k-min(d)); % threshold

  pd(k)  = length(find(d(1:64)>t))/64;  % should be > thresh

  pfa(k) = length(find(d(65:128)>t))/64;  % should be < threshold

end%for

plot(pd,pfa)

