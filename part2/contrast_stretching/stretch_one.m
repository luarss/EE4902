%%% Contrast stretching using equation.


%function [imout]=stretch(imagein)
close all; clc; clear all;

imagein = imread('3.jpg');
imagein1 = imagein;

s=size(imagein);
imagein=double(imagein);

min_in = min(imagein(:));
max_in = max(imagein(:));

imageout=zeros(s(1),s(2));
a=min(imagein(:));%find min and max pixel values to determine stretch constants
b=max(imagein(:));

imagein = (imagein > a).*imagein;%set values less than a to zero
imagein = (imagein >= b)*255+(imagein<b).*imagein;%set values more than b to 255
imageout = uint8(255*(a-imagein)/(a-b));%do the stretch

min_out = min(imageout(:));
max_out = max(imageout(:));

% display plots
figure
subplot(2,2,1), imshow(imagein1), title('Original Image');
subplot(2,2,2), imshow(imageout), title('Stretched Image');
subplot(2,2,3), imhist(imagein1(:,:,1)), title('Histogram of Original Image');
subplot(2,2,4), imhist(imageout(:,:,1)), title('Histogram of Stretched Image');
