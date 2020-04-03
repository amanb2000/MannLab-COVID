% displays color PostScript to screen  (diary to file)
%
% use: cclt(complex_clt)  % returns nothing

function dummy(cclt)  % returns nothing

MAG = scaler2_steve(abs(cclt));
ANG = scaler2_steve(angle(cclt),360);   % put in range 0..359

% put in the crosshairs
[M,N] = size(MAG);
MAG(:,N/2) = ones(MAG(:,N/2))*255;  % full magnitude
MAG(M/2,:) = ones(MAG(M/2,:))*255;  
[M,N] = size(ANG);
%%%ANG(:,N/2) = rem(ANG(:,N/2)+180,360);  % compliment or complement ???
ANG(:,N/2) = zeros(ANG(:,N/2));  % green crosshairs
%%%ANG(M/2,:) = rem(ANG(M/2,:)+180,360);
ANG(M/2,:) = zeros(ANG(M/2,:));  % green crosshairs

mag = tv2vec(MAG);
ang = tv2vec(ANG);

magphase2rgbhex(mag,ang);   %  put postscript onto screen

