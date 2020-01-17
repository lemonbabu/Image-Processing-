function [outputArg1] = WienFilter(pic)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
wnr1 = im2double(pic);

LEN = 21;
THETA = 11;
PSF = fspecial('motion', LEN, THETA);
blurred = imfilter(wnr1, PSF, 'conv', 'circular');
axes (handles.MapQuantization);
imshow(blurred);
title('Blurred Image');

wnr1 = deconvwnr(blurred, PSF, 0);
figure,imshow(wnr1);
title('Restored Image');
end

