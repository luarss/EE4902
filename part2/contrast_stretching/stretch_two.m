%%% Contrast Stretching using LUT

close all; clc; clear all;

imagein = imread('image1.jpg');

min_in = min(imagein(:));
max_in = max(imagein(:));

%function [map]=stretch2(imagein)
map=zeros(256);
a=double(min(imagein(:)));%find min and max pixel values to determine stretch constants
b=double(max(imagein(:)));
map = 0:255/(b-a):255;%remap values to 0,255
map(1:a) = 0;%everything else is 0 or 255
map(b:255) = 255;
map = transpose(map)/255 * [1 1 1];%change this to an appropriate colormap of the form (255 x 3)

% further processing
imageout = imagein(:,:,1);

min_out = min(map(:))*255;
max_out = max(map(:))*255;
figure
imshow(imageout, map);

stretched_Image = imadjust(imagein, stretchlim(imagein, [0, 1]),[]);

figure
subplot(2,2,1), imshow(imagein), title('Original Image');
subplot(2,2,2), imshow(stretched_Image), title('Stretched Image');
subplot(2,2,3), imhist(imagein(:,:,1)), title('Histogram of Original Image');
subplot(2,2,4), imhist(stretched_Image(:,:,1)), title('Histogram of Stretched Image');

