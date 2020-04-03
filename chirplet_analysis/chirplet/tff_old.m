% cltm: creates 3dim mat. of CLTs,  L by clt_size by clt_size, eg. 64by39by39
% with clt_size  (eg 39) extra samples appended to beginnig to store dimensions
% and xlo,xhi,ylo,yhi
% 3dim mat is stored as block row: eg. 64by(1+39*39)
%
% fracfreqlim = .08,  the fractional freq lim, full clt is fracfreqlim = .5
% used for xlo,xhi,ylo,yhi
%
% call:   cltm(data, file_id)
%         form of id_file: id_file = 'b9825'
%         would save in CLTM_b9825, or CLTM if id_file = ''
%
% calls:  clt_cltm.m   which does each of the CLTs

function dummy(dat,id_file)  % returns nothing

disp('data assumed to be 32768 pts long')

% takes about 2h16 to run 64 images, 39by39, on 512pts each

D = 3;
L = 64;  % number of CLTs to be done (1 by 64 array of 39by39 pt CLTs of 512pts)
              % to fit nicely on a page when composited with cltmi

clt_size = 39;  % big enough for 3/4 inch phys size on page
%%%clt_size = 9,  disp('TESTING ON SMALLER 9by9 CLTs')

fracfreqlim = .08;  % worst case is extrema at begin of b98???? how extreme

if ~isempty(id_file)
  id_file = ['_' id_file];  % append underscore between for eg: CLTM_b98...
end%if

eval(['delete  CLTM' id_file '.mat'])
disp(['deleted CLTM' id_file '.mat          (Multi Image mat file)'])

CLTM = NaN * ones(clt_size, 1);   % LATER SHOULD initialize to not repeat malloc
CLTM(1,1) = D;  % dimension =3
CLTM(2,1) = L;
CLTM(3,1) = clt_size;
CLTM(4,1) = clt_size;

CLTM(5,1) = -fracfreqlim;
CLTM(6,1) = fracfreqlim;
CLTM(7,1) = -fracfreqlim;
CLTM(8,1) = fracfreqlim;

% leave the rest all NaN for now

for l = 1:L

disp(sprintf('working on image #%g of %g images',l,L))
  ind = (l-1)*32768/L + 1;
  b = dat(ind:ind+32768/L-1); % 1:1+511, 512:512+511, ..., _:_+511

  clt = clt_cltm(b,fracfreqlim,clt_size,l,L);  % creates single clt;l,L for disp
  CLTM = [CLTM clt]; %   repeated malloc change size, but easier

end%for l

eval(['save CLTM' id_file ' CLTM'])

