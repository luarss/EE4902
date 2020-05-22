clear all; clc; close all;

image1 = imread('shoe1.jfif');
image2 = imread('shoe2.jfif');
% image1 = imread('tree1.jpg');
% image2 = imread('tree2.jpg');
% image1 = imread('stripes1.jpg');
% image2 = imread('stripes2.jpg');

% Ensuring both images same size.
size1 = size(image1);
size2 = size(image2);
h = min(size1(1), size2(1));
w = min(size1(2), size2(2));
image1 = im2double(image1(1:h,1:w,:));
image2 = im2double(image2(1:h,1:w,:));

% sigma for filter
sigma = 2.5;

% First output: Gaussian of combined inputs
image3 = image1 + image2;
image3 = imgaussfilt(image3, sigma);

% Second output: Combined outputs from separate inputs
image4 = imgaussfilt(image1, sigma) + imgaussfilt(image2, sigma);

% Display
image_diff = image4 - image3;
diff_sum = sum(image_diff(:));
%figure
%imshow(image_diff)

figure
subplot(2,2,1), imshow(image1), title('image 1');
subplot(2,2,2), imshow(image2), title('image 2');
subplot(2,2,3), imshow(image3), title('Case A');
subplot(2,2,4), imshow(image4), title('Case B');

