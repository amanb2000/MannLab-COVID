% QUIET vers. for use by cltm.m
% finds the best chirp to fit the data
%
% clt_cltm(b98(1:1024), .5, 99);  % produces a 99 by 99 image with freqlim .5
% clt_cltm(data, fracfreqlim, size)
%
% clt_cltm(data,fracfreqlim) % defaults size to 19 for quick contour plots
% clt_cltm(data)             % defaults to -.5,.5
% data is a COLUMN vector
%
% fracfreqlim = .5 gives image of likeness to chirps starting @f0 going up to f1
%
% clt_cltm(data,fracfreqlim,2,64)  displays "doing image 2 of 64 images
%                                  (last 2 numbers do nothing, just displayed)

function clt = dummy_name(b,fracfreqlim,size_of_img,img_count_for_dis,IMG_COUNT)

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

%%%disp('subtracting mean from data vector')
b = b-mean(b);
%%%disp('subtracted mean')

[fbeg,fend] = meshdom(linspace(xlo,xhi,N) , linspace(ylo,yhi,M));  
                                            % fbeg to right, fend up

clt = NaN*ones(M,N);   % avoid repeated calls to malloc
for m = 1:M        % do chirp likeness processing in TV order
  dis = sprintf('line m=%g of M=%g lines',m,M);
  if nargin < 4
    disp(dis)   % no image count given
  else%if
    dis2 = sprintf('img l=%g of L=%g images ... ',img_count_for_dis,IMG_COUNT);
    disp([dis2 dis])
  end%if
  for n = 1:N
    f0 = fbeg(m,n);
    f1 = fend(m,n);
%%%    c = chirp(f0,f1,len,1).*hanning(len).';   % default samp rate is 1 anyway
    c = logonwh((f0+f1)/2,f1-f0,len);   % goes from f0 to f1 over len samples
%%%%NOT NEEDED for big kernels    c = c-mean(c);  % force DC to zero
    clt(m,n) = abs(c*conj(b));   % ``energy'' in each of the chirps
                                 % MAGNITUDE CLT, NOT ENERGY????
                                 % but MAG. is more compressed in dynamic range
  end%for
end%for

