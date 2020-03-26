%A simple program for pseudo colouring 
%The program converts a gray level image (0-256)(single layer) to pseudo color image (3 layer)
%by altering the conditions and values, U can create more perfect pseudo color image.
clc;
clear all;
im=input('Enter the file name (gray level image) :','s');
k=imread(im);
[x y z]=size(k);
% z should be one for the input image
k=double(k);
for i=1:x
    for j=1:y
        if k(i,j)>=0 & k(i,j)<50
            m(i,j,1)=k(i,j)+60;
            m(i,j,2)=k(i,j)+10;
            m(i,j,3)=k(i,j)+20;
        end
        if k(i,j)>=50 & k(i,j)<100
            m(i,j,1)=k(i,j)+70;
            m(i,j,2)=k(i,j)+28;
            m(i,j,3)=k(i,j)+20;
        end
        if k(i,j)>=100 & k(i,j)<150
            m(i,j,1)=k(i,j)+104;
            m(i,j,2)=k(i,j)+30;
            m(i,j,3)=k(i,j)+30;
        end
        if k(i,j)>=150 & k(i,j)<200
            m(i,j,1)=k(i,j)+100;
            m(i,j,2)=k(i,j)+40;
            m(i,j,3)=k(i,j)+50;
        end
        if k(i,j)>=200 & k(i,j)<=256
            m(i,j,1)=k(i,j)+240;
            m(i,j,2)=k(i,j)+60;
            m(i,j,3)=k(i,j)+45;
        end
    end
end
figure,imshow(uint8(k),[]);
figure,imshow(uint8(m),[]);