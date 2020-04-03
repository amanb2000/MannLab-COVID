% finds best chirp to fit data in terms of SLOPE and INTERCEPT in tf space
% (as opposed to fbeg and fend)
%
% does single CLT spanning whole time series, eg. whole 512 pts
% contours CLT and labels axes
%
% clt(b98(1:L), L/32, L/128, 99);  % produces a 99 by 99 image from 1024pts,
%                                  % slopes out to 1/8 nyq, intercep to 1/64 nyq
%                                  % giving higher resolution in intercepts
% clt(data, a_lim, b_lim, size)
%
% clt(data, a_lim, b_lim) % defaults size to 19 for quick contour plots
% clt(data)               % defaults to L/8 and L/8 for within nyquist

function clt = dummy_name(dat,a_lim,b_lim,size_of_img)

L = length(dat);
if nargin < 4
  size_of_img = 19;
end%if
if nargin < 3
  b_lim = L/8;
end%if
if nargin < 2
  a_lim = L/8;
end%if

M = size_of_img;
N = size_of_img;

time_est_per_line = L/3870*21/16*N/99; % one 3870pt line takes 21/16 min.
disp(sprintf('est single usr sparc time PER LINE: %g min',time_est_per_line))

disp('subtracting mean from data vector')
dat = dat-mean(dat);
disp('subtracted mean')

[A,B] = meshdom(linspace(-a_lim,a_lim,N) , linspace(-b_lim,b_lim,M));  
                                            % a to right, b up

clt = NaN*ones(M,N);   % avoid repeated calls to malloc
for m = 1:M        % do chirp likeness processing in TV order
  disp(sprintf('doing line %g of %g lines',m,M))
  for n = 1:N
    a = A(m,n);
    b = B(m,n);
%%%    c = chirp(f0,f1,L,1).*hanning(L).';   % default samp rate is 1 anyway
    c = bird(a,b,L);   % bird chirp   in terms of slope and intercept in TF
      %%%%NOT NEEDED for longer chirps (only for very short chirps as in GLT)
      %%%%c = c-mean(c);  % force DC to zero
    clt(m,n) = abs(c*conj(dat));   % ``energy'' in each of the chirps
  end%for
end%for

axis('square')
contour(clt)
grid
title(sprintf('contour of chirp similarity diagram of %g pts',L))
xlabel(sprintf('TF slope (chirpyness): %g to %g',-a_lim,a_lim))
ylabel(sprintf('TF intercept: %g to %g',-b_lim,b_lim))

