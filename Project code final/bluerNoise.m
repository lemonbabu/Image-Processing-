function [I] = bluerNoise(pic)
%BLUERNOISE Summary of this function goes here
%   Detailed explanation goes here
wnr1 = im2double(pic);

LEN = 21;
THETA = 11;
PSF = fspecial('motion', LEN, THETA);
I = imfilter(wnr1, PSF, 'conv', 'circular');
end

