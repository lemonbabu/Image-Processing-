function [pic_negative] = negative(pic)
%NAGETIVE Summary of this function goes here
%   Detailed explanation goes here
[x,y,z] = size(pic);
if(z==1)
    ;
else
    pic = rgb2gray(pic);
end
max_gray = max(max(pic));
max_gray = im2double(max_gray);
pic = im2double(pic);
for i = 1:x
    for j = 1:y
        pic_negative(i,j)= max_gray - pic(i,j);
        end
    end
end
