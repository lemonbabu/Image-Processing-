function [I] = imadjust(pic)
%IMADJUST Summary of this function goes here
%   Detailed explanation goes here
i = pic(:,:,1);
rtemp = min(i);         % find the min. value of pixels in all the columns (row vector)
rmin = min(rtemp);      % find the min. value of pixel in the image
rtemp = max(i);         % find the max. value of pixels in all the columns (row vector)
rmax = max(rtemp);      % find the max. value of pixel in the image
m = 255/(rmax - rmin);  % find the slope of line joining point (0,255) to (rmin,rmax)
c = 255 - m*rmax;       % find the intercept of the straight line with the axis
I = m*i + c;        % transform the image according to new slope

end

