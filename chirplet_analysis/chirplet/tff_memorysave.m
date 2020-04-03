% does clt of each 512 pt segment
% adds CLT image file into composite, after bordering and scaling to 0..255
% then clears that CLT from memory, so memory requirement is just over 400by400
%
% call:   cltmi_memorysave(dat,id_titles,id_files)
% example id:
% id_titles = 'growler b98, range 25'
% id_files = 'b9825'
% or id_files = ''
%
% calls:  clt_cltmi_memorysave
%
% takes about 2h16 to run 64 images, 39by39, on 512pts each

disp('data assumed to be 32768 pts long')

function dummy(dat,id_titles,id_files)  % returns nothing

if ~isempty(id_files)
  id_files = [id_files '_'];
end%if

PLTNUM = 64;  % number of CLTs to be done (8 by 8 array of 64 512 pt CLTs)
              % to fit nicely on a page
eight = 8;  % number of composite images (eight by eight array of images)

clt_size = 39;  % big enough for 3/4 inch phys size on page
%%%%% test only .... clt_size = 9;

fracfreqlim = .08;  % worst case is extrema at begin of b98???? how extreme

clg
hold off
subplot(221)

composite = [];
rowcomposite = [];
eval(['delete CLTMF' id_files '.met'])
disp(['deleted CLTMF' id_files '.met  (multi contour plot file)'])
eval(['delete CLTMF' id_files '.txt'])
disp(['deleted CLTMF' id_files '.txt  (Multi Features)'])
eval(['delete CLTMI' id_files '.mat'])
disp(['deleted CLTMI' id_files '.mat   (Multi Image mat file)'])

rowpad = 255*ones(clt_size+2,9);  % will make whole image 400 by 400
colpad = 255*ones(9,(clt_size+2+9)*eight);  % +2 for black border

for pltnum = 1:PLTNUM   % 1:almost 32768 (less 512 samples)

disp(sprintf('working on image #%g of %g images',pltnum,PLTNUM))
  ind = (pltnum-1)*32768/PLTNUM + 1;
  b = dat(ind:ind+32768/PLTNUM-1); % 1:1+511, 512:512+511, ..., _:_+511

  clt = clt_cltmi_memorysave(b,fracfreqlim,clt_size,id_files);  % creates contour plot
  rowcomposite = [rowcomposite rowpad borderngrid(clt)]; % extra space to left
  if ~rem(pltnum,eight)
    composite = [composite;colpad;rowcomposite];  % extra space on top
    rowcomposite=[];
  end%if
  if ~rem(pltnum,4)
    hold on
    subplot
    if pltnum == 4
      tit=sprintf('contours of chirp GLTs;   frac. f. = [-%g to %g]',fracfreqlim,fracfreqlim);
    else
      tit=sprintf('contours of chirp GLTs  %g to %g',pltnum-3,pltnum);
    end%if
    title([id_titles ':  ' tit])
%%    meta cltm_growler  %  2 sets of 4 to a page, all pages in 1 file
    eval(['meta CLTMF' id_files])   % 2 sets of 4 to a page, all pages in 1 file
    hold off
    subplot(221)
  end%if
end%for

eval(['save CLTMI_' id_files ' composite'])

