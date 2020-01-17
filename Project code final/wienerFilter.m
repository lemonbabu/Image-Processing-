function [A] = wienerFilter(pic)
%WIENERFILTER Summary of this function goes here
%   Detailed explanation goes here
LEN = 21;
THETA = 11;
PSF = fspecial('motion', LEN, THETA);

A = deconvwnr(pic, PSF, 0);
end

