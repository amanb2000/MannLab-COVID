% format: cltm2eps(CLTM,psfile) 
%
% cltm2eps(variablename, string)
% Examples:
% cltm2eps(CLTM)   % output to default eps file:  deleteme.eps
% cltm2eps(CLTM, 'CLTM_b9825.eps')
% (no longer using the automatic appending CLTM_ before given filename)
%
% places the 64 images into rows one after the other on 8 by 8 group

function dummy(CLTM,psfile)

D   = CLTM(1,1);  % hypermatrix dimension is always 3
if (D~=3) disp('WARNING*** hypermat does not have dim = 3 in first col header')
end%if
L   = CLTM(2,1);  % number of GLTs to be done (8 by 8 array of 64 512 pt GLTs)
M   = CLTM(3,1);
N   = CLTM(4,1);
xlo = CLTM(5,1);
xhi = CLTM(6,1);
ylo = CLTM(7,1);
yhi = CLTM(8,1);
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

if isempty(psfile)
  psfile = 'deleteme.eps';  % default file
  disp('no psfile specified so I am defaulting to deleteme.eps')
end%if

eight = 8;  % number of composite images (eight by eight array of images)

composite = [];
rowcomposite = [];
eval(['delete ' psfile])
disp(['deleted ' psfile  '(so img2eps won''t have problem)'])

rowpad = 255*ones(clt_size+2,9);  % will make whole image 400 by 400
colpad = 255*ones(9,(clt_size+2+9)*eight);  % +2 for black border

for l = 1:L   % index of the clt number

disp(sprintf('cltm2eps: concatenating image   # %g   of    %g    images',l,L))

  clt = CLTM(:,2+(l-1)*N:1+l*N);

  rowcomposite = [rowcomposite rowpad borderngrid(clt)]; % extra space to left
  if ~rem(l,eight)
    composite = [composite;colpad;rowcomposite];  % extra space on top
    rowcomposite=[];
  end%if
end%for

composite=composite.';  % transpose for reading by mat2ras.c in proper order

eval(['save deleteme composite'])
disp('wrote out composite transpose into file deleteme.mat')
!/home/mcbuff/steve/matc/mat2ras deleteme.mat deleteme.ras
disp('converted deleteme.mat to deleteme.ras')
eval('delete deleteme.mat')
disp('deleted deleteme.mat')
!/home/mcbuff/steve/reduce/reduce deleteme.ras 32 deleteme
[y x] = size(composite); %  x=N  and  y=M
eval(['!tv -L6 -W6 -U1.25 -V3.75 -x' num2str(x) ' -y' num2str(y) ' deleteme > ' psfile])
eval('delete deleteme')
disp('deleted deleteme')

disp(['cltm2eps done: created deleteme.ras and the PostScript file: ' psfile])

