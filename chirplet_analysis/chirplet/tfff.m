% extracts features from tff file   and does contour plots
% needs to load cltavg file which contains
% averages of all FFs in both tff target files b9825 and b9727
%
% format: features = tfff(tff,id_files,id_titles)
% ex:     features = tfff(tff_b9825,'b9825','growler b98 range 25')
% or:     features = tfff(tff_b9825,'','growler b98 range 25')
% saves features into file like "tfff_b9825.txt" or "tfff.txt"
% and titles all the contour plots with id_titles

function FEATURES = dummy(tff,id_files,id_titles)

load cltavg
cltavg2 = cltavg.*conj(cltavg); % compute energy real anyway
cltavg2 = cltavg2/sum(sum(cltavg2)); % unit L2 norm
cltavg = cltavg/sum(sum(cltavg)); % unit L1 norm

D = tff(1,1);
L = tff(2,1);  % number of GLTs to be done (8 by 8 array of 64 512 pt GLTs)
M = tff(3,1);
N = tff(4,1);
xlo = tff(5,1);
xhi = tff(6,1);
ylo = tff(7,1);
yhi = tff(8,1);
fracfreqlim = -xlo;  % assume all 4 are the same, eg -.08, .08, -.08, .08
if ((xlo+xhi)*(ylo+yhi))
  disp('WARNING... fracfreqlim not equal for x and y axes, or lo ~= -hi')
end%if
dis = sprintf('L = %g    M = %g   N = %g', L, M, N);
disp(['finished reading clt file:' dis])

eight = 8;  % number of composite images (eight by eight array of images)

clt_size = M;  % big enough for 3/4 inch phys size on page
if M ~= N
  disp('CLTs are NOT SQUARE ***will not work the way its currently implemented')
end%if

clg
hold off
subplot(221)

%%%composite = [];
%%%rowcomposite = [];

if ~isempty(id_files)
  id_files = ['_' id_files];  % underscore to seperate, tff or,say, tff_b9825
end%if
eval(['delete tff' id_files '.met'])
disp(['deleted tff' id_files '.met  (multi contour plot file)'])
eval(['delete tfff' id_files '.txt'])
disp(['deleted tfff' id_files '.txt  (Multi Features created by tff)'])
%%%eval(['delete tffi' id_files '.mat'])
%%%disp(['deleted tffi' id_files '.mat   (Multi Image mat file)'])

%%%rowpad = 255*ones(clt_size+2,9);  % will make whole image 400 by 400
%%%colpad = 255*ones(9,(clt_size+2+9)*eight);  % +2 for black border

FEATURES = NaN*ones(L,6);   % initialize to avoid repeated mallocs

for l = 1:L   % 1:almost 32768 (less 512 samples)

  disp(sprintf('working on CLT #%g of %g images',l,L))

  clt = tff(:,2+(l-1)*N:1+l*N);

  %%%-------------------------------------------------------------------------
  %%% part originally in separate function -----------------------------------
  axis('square')

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % GLT info to display under each subplot   %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % non "bootstrapped" features
  ent = entropynor1(clt.^2);  % take (normalized)entropy of POWER ``spectrum''
  [dx dy dxy2] = extent2(clt);
  ext = dx*dy; % should it be extent2(clt.^2)???
  sle = dxy2; % slenderness    ...  should it be from extent2(clt.^2)???

  % bootstrapped parameters
  % depend on cltavg (cltavg window from all previous "target" eg b9825, b9727...)
  ext_forced_epoch = extent2(clt,[25.36,14.33]);  % use INDEX not xy coords
                 % we know tffaxavg is at indices [25.36,14.33]
                 % which is (14.64,14.33) in (x,y) space  (ie f0 approx f1)
  pwr_in_wind = sum(sum(clt.*cltavg2.*conj(clt)));
                                     % true power since clt is actually mag.
                                     % but pwr is weighted by cltavg
  [max_within_wind Mmax Nmax] = max2(clt.*cltavg2);
  % Hypothesis 0: no chirp present (H0=pwr) ... H1: chirp present:
%%%  H1 = clt(Mmax,Nmax)^2*cltavg2(Mmax,Nmax); %same as <c|b>*conj<c|b>
%%%  H1overH0 = H1/pwr_in_wind; % measure of peakyness: independent of pwr in wind
  H1 = clt(Mmax,Nmax)^2; %same as <c|b>*conj<c|b>
  %                                      to other features

  d = '       '; % delimiter between numbers for file

  f1 = [num2str(ent) d num2str(ext) d num2str(sle)]; % non bootstrapped features
%%%  f2 = [num2str(ext_forced_epoch) d num2str(H1overH0) d num2str(pwr_in_wind)];
  f2 = [num2str(ext_forced_epoch) d num2str(sqrt(H1)) d num2str(pwr_in_wind)];
  features = [f1 d f2]; % all features
  filnam = ['tfff' id_files];
  fprintf([filnam '.txt'],[features '\n'])

  FEATURES(l,:) = [ent ext sle ext_forced_epoch sqrt(H1) pwr_in_wind];

  % redo with less precision for the contour plots
  d = ' '; % delimiter between numbers for contour plots

  f1 = [num2str(round(ent*100)/100) d num2str(round(ext)) d num2str(round(sle))]; % non bootstrapped features
%%%  f2 = [num2str(round(ext_forced_epoch)) d num2str(round(H1overH0*100)/100) d num2str(round(pwr_in_wind))];
  f2 = [num2str(round(ext_forced_epoch)) d num2str(sqrt(round(H1))) d num2str(round(pwr_in_wind))];
  features = [f1 d f2]; % all features

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % CONTOUR PLOTS                               %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  contour(clt)  % no labels to be put in here
  hold on
  plot(1:clt_size,1:clt_size,'.')   % diag line  f0 = f1
  x = (clt_size+1)/2 - floor(clt_size/10):  (clt_size+1)/2 + floor(clt_size/10);
  y = (clt_size+1)/2 + floor(clt_size/10):-1: (clt_size+1)/2-floor(clt_size/10);
  plot(x,y,'.')  % tick mark (part of line  f0 = -f1 (fdiff=0))
  xlabel(features)
  hold off
  grid
  %%%------------------------------------------------------------------------

  %%% rowcomposite = [rowcomposite rowpad borderngrid(clt)]; %extra space to lef
  %%%  if ~rem(l,eight)
  %%%    composite = [composite;colpad;rowcomposite];  % extra space on top
  %%%    rowcomposite=[];
  %%%  end%if
  if ~rem(l,4)
    hold on
    subplot
    if l == 4
      tit=sprintf('contours of chirp GLTs;   frac. f. = [-%g to %g]',fracfreqlim,fracfreqlim);
    else
      tit=sprintf('contours of chirp GLTs  %g to %g',l-3,l);
    end%if
    title([id_titles ':  ' tit])
%%    meta gltm_growler  %  2 sets of 4 to a page, all pages in 1 file
    eval(['meta tff' id_files]) %  2 sets of 4 to a page, all pages in 1 file
    hold off
    subplot(221)
  end%if
end%for

%%% eval(['save tffi' id_files ' composite'])

