function [A] = medianFilter(pic)
%MEDIANFILTER Summary of this function goes here
%   Detailed explanation goes here

A = im2double(pic);
[m n] = size(A);
Med = [];
%Modified filter 
for i=2:m-1
    for j=2:n-1
            Med(1) = A(i-1,j-1);
            Med(2) =A(i-1,j) ;
            Med(3) = A(i-1,j+1);
            Med(4) = A(i,j-1);
            Med(5) = A(i,j+1);
            Med(6) = A(i+1, j-1);
            Med(7) = A(i+1,j);
            Med(8) = A(i+1,j+1);
            A(i,j) = median(Med);
    end
end