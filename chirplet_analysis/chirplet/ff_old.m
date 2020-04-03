% ff.m                                                   Steve Mann, 1989
%
% computes complex frequency-frequency (FF) plane and displays a contours  of
% the FF plane and labels axes.
% The FF plane may be regarded as a bank of matched filters arranged in a
% 2-d lattice.  Each filter is a chirp, and therefore has a chirp-rate (C) and
% center frequency (F) associated with it.  Because of the Nyquist boundary
% problem\cite{mannassp} (Submitted to IEEE Trans Acoustics Speech, Sig. Proc.),
% the boundary of the CF plane is diamond-shaped, and more efficient use of
% screen (or printer) real-estate is made by computing the FF plane.
% The parameters are Fbeg (frequency at the beginning of the analysis interval)
% and Fend (frequency at the end of the analysis interval).
%
% Examples of use:
% ff(data_b98(1:1024),.5,99); % produces a 99 by 99 image with freqlim .5
% ff(data,fracfreqlim,size)   % use odd sizes to get nice axes
%                             % sizes like 19,39,99,199,399 plot most nicely
% ff(data,fracfreqlim)        % default size is 19 by 19 for quick contour plots
% ff(data)                    % defaults to -.5,.5 frac frequency
% fracfreqlim=.5 gives chirps starting at Fbeg=-.5 going up to Fend=.5
%
% Bugs: Does not use the fast chirplet-slice (FCS) algorithm.

function clt = dummy_name(b,fracfreqlim,size_of_img)

if nargin < 3
  size_of_img = 19;
end%if
if nargin < 2
  fracfreqlim = .5;
end%if

xlo = -fracfreqlim;
xhi =  fracfreqlim;
ylo = -fracfreqlim;
yhi =  fracfreqlim;

M = size_of_img;
N = size_of_img;

len = length(b);

time_est_per_line = len/3870*21/16*N/99; % one 3870pt line takes 21/16 min.
disp(sprintf('est single usr sparc time PER LINE: %g min',time_est_per_line))

disp('subtracting mean from data vector')
b = b-mean(b);
disp('subtracted mean')

[fbeg,fend] = meshdom(linspace(xlo,xhi,N) , linspace(ylo,yhi,M));  
                                            % fbeg to right, fend up

clt = NaN*ones(M,N);   % avoid repeated calls to malloc
for m = 1:M        % do chirp likeness processing in TV order
  disp(sprintf('doing line %g of %g lines',m,M))
  for n = 1:N
    f0 = fbeg(m,n);
    f1 = fend(m,n);
%%%    c = chirp(f0,f1,len,1).*hanning(len).';   % default samp rate is 1 anyway
    c = logonwh((f0+f1)/2,f1-f0,len);   % goes from f0 to f1 over len samples
      %%%%NOT NEEDED for longer chirps (only for very short chirps as in GLT)
      %%%%c = c-mean(c);  % force DC to zero
%%%    clt(m,n) = abs(c*conj(b));   % ``energy'' in each of the chirps
    clt(m,n) = c*conj(b);   % similarity to each of the chirps
  end%for
end%for

axis('square')
contour(abs(clt))
grid
title('contour of chirp similarity diagram')
xlabel(sprintf('start frequency: %g to %g',xlo,xhi))
ylabel(sprintf('end frequency: %g to %g',ylo,yhi))

