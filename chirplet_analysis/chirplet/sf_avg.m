% sf_avg.m                                                     Steve Mann
%
% finds the best modulated gaussian to fit the data
% AVERAGES for shorter windows, over whole data length
% since FFT in effect "averages" freq content of whole record regardless of
% particular basis used, we need to do same here and avg short bases
%
% assume data to be fit is stored in variable ''b'' (stands for b98...)
%       assumed to be ZEROMEAN
%
% function ??? is ''c''

disp('DATA ASSUMED TO BE IN VARIABLE "b"')
disp('subtracting mean')
b = b - mean(b);
disp('subtracted  mean')

fracfreqlim = input('enter a frac. freq. limit (default is .5) ');
if isempty(fracfreqlim)
  fracfreqlim = .5;
end%if
xlo = -fracfreqlim;
xhi = fracfreqlim;

len = length(b);

disp('input # of ker sizes = MULTIPLE of 4; for plots (file glt_gabor_avg.met...)');
M=input('M # of kernel sizes; for nice contour center, use: 4,8,...or 19,39,59,79,99...');
if isempty(M), M = 8; disp('using default size=8'), end%if   % default
N=input('N: number of center freq.s to try: use 19,39,59,79,99,or 119,... ');
if isempty(N), N = 39; disp('using default size')   , end%if   % default

%%%fbeg = ((-16:.5:16).' *  ones(1,N))/256;      % freq from -16/256 to 16/256, with fbeg point down, fend to right
%%%fend = (ones(M,1)    * (-16:.5:16))/256;      % create matrix of frequencies

ylo = input('enter kernel len to begin with (default is 100)');
if isempty(ylo)
  ylo = 100;
end%if
yhi = input('enter kernel len to end   with (default is length of data, "b")');
if isempty(yhi)
  yhi = length(b);
end%if

[fc,kernellen] = meshdom(linspace(xlo,xhi,N) , linspace(ylo,yhi,M));  % fc to right, kernellen up

similarity = NaN*ones(M,N);   % avoid repeated calls to malloc
for m = 1:M        % do logon likeness processing in TV order
  for n = 1:N
    dis = sprintf('doing line %g and point %g',m,n);
    disp([dis sprintf('   (of %g lines and %g pts/line)',M,N)])
    fcenter = fc(m,n);
    kerlen = kernellen(m,n);
    c = logonwh(fcenter,fcenter,kerlen);   % chirp from fc to fc (steady tone) 
    % MEAN SUBTRACTED FROM each kernel
    c = c(:) - mean(c(:));  % and make it a COLUMN VEC
    % compute ``energy'' in each of the logons averaged over all possible posns
    similarities = abs(conv(c,conj(b)));
%%%    similarity(m,n) = abs((c-mean(c))*conj(b(1:kerlen)));
    lose = ceil((kerlen-1)/2);  % need to get rid of edge effects
    similarity(m,n) = sum(similarities(lose+1:length(similarities)-lose));
  end%for
  disp(sprintf('did line %g;  kerlen was %g,  lose was %g',m,kerlen,lose))
end%for

if rem(M,4) == 0
  freq = linspace(xlo,xhi,N);
  subplot(221)
  for m = 1:8
    plot(freq,similarity(m,:))
    xlabel('fractional frequency')
    title(sprintf('scale = %g',kernellen(m,1)))
    if rem(m,4) == 0
      disp('rem(m,4) was found to be 0')
      meta glt_gabor_avg
      disp('put 4 plots into metafile')
    end%if
  end%for
else%if
  contour(similarity)
  grid
  title('contour of logon similarity diagram')
  xlabel(sprintf('center frequency: %g to %g',xlo,xhi))
  ylabel(sprintf('kernel length: %g to %g',ylo,yhi))
end%if

