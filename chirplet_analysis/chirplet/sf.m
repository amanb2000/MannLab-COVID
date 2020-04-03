% sf.m   Scale-Freq (SF) plane of chirplet transform       Steve Mann 1989
%
% computes samples of the Scale Frequency (SF) plane of the chirplet transform,
% using a Gaussian mother chirplet
%
% assume data is stored in variable ''b'' (stands for b98...)
%       assumed to be ZEROMEAN
%
% function ??? is ''c''

disp('DATA ASSUMED TO BE IN VARIABLE "b"')
disp('subtracting mean')
b = b - mean(b);
% disp('subtracted  mean')

fracfreqlim = input('enter a frac. freq. limit (default is .5) ');
if isempty(fracfreqlim)
  fracfreqlim = .5;
end%if
xlo = -fracfreqlim;
xhi = fracfreqlim;

len = length(b);

M=input('M: # of scales; for nice contour center, use 19,39,59,79,99,119,... ');
if isempty(M), M = 19; disp('using default size=19'), end%if   % default
N=input('N: number of center freq.s to try: use 19,39,59,79,99,or 119,... ');
if isempty(N), N = 19; disp('using default size')   , end%if   % default

npts = M*N;
disp(sprintf('estimated single user sparc time to execute: %g minutes',...
              npts/8/60))

%%%fbeg = ((-16:.5:16).' *  ones(1,N))/256;
    % freq from -16/256 to 16/256, with fbeg point down, fend to right
%%%fend = (ones(M,1)    * (-16:.5:16))/256;      % create matrix of frequencies

ylo = input('enter kernel len to begin with (default is 5)');
if isempty(ylo)
  ylo = 5;
end%if
yhi = input('enter kernel len to end with (default is 512)');
if isempty(yhi)
  yhi = 512;
end%if

[fc,kernellen] = meshdom(linspace(xlo,xhi,N) , linspace(ylo,yhi,M));
               % fc to right, kernellen up

Csf = NaN*ones(M,N);   % avoid repeated calls to malloc
for m = 1:M        % do logon likeness processing in TV order
  disp(sprintf('doing line %g of %g lines',m,M))
  for n = 1:N
    fcenter = fc(m,n);
    kerlen = kernellen(m,n);
    c = logonwh(fcenter,fcenter,kerlen);   % chirp from fc to fc (steady tone) 
    Csf(m,n) = abs((c-mean(c))*conj(b(1:kerlen)));
             % ``energy'' in each of the logons  NOT CENTERED (LEFT JUSTified)
     % MEAN SUBTRACTED FROM each kernel
  end%for
end%for

contour(Csf)
grid
title('Contour of Scale-Freq (SF) Plane of Chirplet Transform')
xlabel(sprintf('center frequency: %g to %g',xlo,xhi))
ylabel(sprintf('kernel length: %g to %g',ylo,yhi))

