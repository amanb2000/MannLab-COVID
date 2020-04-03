% extracts features from cltm file   and does NOT do contour plots
% needs to load cltavg file which contains averages of CLTs of CLTM
% files b9825 and b9727
%
% format: features = cltmf_noplot(cltm,id_files) 
% ex:     features = cltmf_noplot(CLTM_b9825,'b9825')
% or:     features = cltmf_noplot(CLTM_b9825,'')
%
% saves features into file like "CLTMF_b9825.txt" or "CLTMF.txt"
function FEATURES = dummy(cltm,id_files)

load cltavg
cltavg2 = cltavg.*conj(cltavg); % compute energy real anyway
cltavg2 = cltavg2/sum(sum(cltavg2)); % unit L2 norm
cltavg = cltavg/sum(sum(cltavg)); % unit L1 norm

D = cltm(1,1);
L = cltm(2,1);  % number of GLTs to be done (8 by 8 array of 64 512 pt GLTs)
M = cltm(3,1);
N = cltm(4,1);
xlo = cltm(5,1);
xhi = cltm(6,1);
ylo = cltm(7,1);
yhi = cltm(8,1);
fracfreqlim = -xlo;  % assume all 4 are the same, eg -.08, .08, -.08, .08
if ((xlo+xhi)*(ylo+yhi))
  disp('WARNING... fracfreqlim not equal for x and y axes, or lo ~= -hi')
end%if
dis = sprintf('L = %g    M = %g   N = %g', L, M, N);
disp(['finished reading clt file:' dis])

clt_size = M;  % big enough for 3/4 inch phys size on page
if M ~= N
  disp('CLTs are NOT SQUARE ***will not work the way its currently implemented')
end%if

clg
hold off
subplot(221)

%%%%%%%%%%%if ~isempty(id_files)
%%%%%%%%  id_files = ['_' id_files];  % underscore to seperate, CLTM or,say, CLTM_b9825
%%%%%%%%%%%end%if
%%%%%%%%%%%%%55eval(['delete CLTMF' id_files '.mat'])
%%%%%%%%%%%%%%disp(['deleted CLTMF' id_files '.mat  (Multi Features .mat file)'])

FEATURES = NaN*ones(L,6);   % initialize to avoid repeated mallocs

for l = 1:L   % 1:almost 32768 (less 512 samples)

  disp(sprintf('working on CLT #%g of %g images',l,L))

  clt = cltm(:,2+(l-1)*N:1+l*N);

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
                 % we know cltmaxavg is at indices [25.36,14.33]
                 % which is (14.64,14.33) in (x,y) space  (ie f0 approx f1)
  pwr_in_wind = sum(sum(clt.*cltavg2.*conj(clt)));
                                     % true power since clt is actually mag.
                                     % but pwr is weighted by cltavg
  [max_within_wind Mmax Nmax] = max2(clt.*cltavg2);
  % Hypothesis 0: no chirp present (H0=pwr) ... H1: chirp present:
  H1 = clt(Mmax,Nmax)^2; %same as <c|b>*conj<c|b>
  %                                      to other features

  FEATURES(l,:) = [ent ext sle ext_forced_epoch sqrt(H1) pwr_in_wind];

  end%if
end%for

%%%eval(['save CLTMF' id_files ' FEATURES'])

