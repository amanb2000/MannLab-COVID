% [Mmaxavg, Nmaxavg] = cltmaxavg(cltm);  % gives the coordinates of the
%                                        % average of all clt maxima

function [Mmaxavg, Nmaxavg] = dum(cltm)
D=cltm(1,1);
disp(sprintf('index dimensionality of clt, D = %g',D))
L=cltm(2,1);
disp(sprintf('L = %g "pages" ',L))
M=cltm(3,1);
disp(sprintf('M = %g rows ',M))
N=cltm(4,1);
disp(sprintf('N = %g cols ',N))

Mmaxavg = 0;
Nmaxavg = 0;
for l = 1:L
  clt = cltm(:,2+(l-1)*N:1+l*N);
  [maximum Mmax Nmax] = max2(clt);
  if ~rem(l,5)
    dis = sprintf('doing clt # l=%g;  Mmax=%g;  Nmax=%g;',l,Mmax,Nmax);
  disp(dis)
  end%if
  Mmaxavg = Mmaxavg + Mmax;
  Nmaxavg = Nmaxavg + Nmax;
end%for

Mmaxavg = Mmaxavg/L;
Nmaxavg = Nmaxavg/L;

