% sums up the pages of a 3dim array
% input:  3d array as a block row, with first column used to indicate dims
% output: matrix of same dim as one page of arr.
%
% to get average of all pages, take sum and div. by num of pages as in:
% cltavg = cltsum(cltm)/cltm(2,1);       % gives the average window
%                                        % average of all clt

function sum = dum(cltm)
D=cltm(1,1);
disp(sprintf('index dimensionality of clt, D = %g',D))
L=cltm(2,1);
disp(sprintf('L = %g "pages" ',L))
M=cltm(3,1);
disp(sprintf('M = %g rows ',M))
N=cltm(4,1);
disp(sprintf('N = %g cols ',N))

sum = zeros(M,N);
for l = 1:L
  clt = cltm(:,2+(l-1)*N:1+l*N);
  if ~rem(l,5)
    dis = sprintf('doing page # l=%g   of   %g pages', l, L);
  disp(dis)
  end%if
  sum = sum + clt;
end%for

