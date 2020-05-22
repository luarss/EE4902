clear all; clc; close all;

% Reading image
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

% convert to 2d array
image1 = image1(:,:,1);
image2 = image2(:,:,1);

%add noise which may not be need
%image3 = imnoise(H,'salt & pepper',0.02);
%image4 = imnoise(I,'salt & pepper',0.02);
%median filter

image3 = image1 + image2;
image3 = medfilt2(image3);

image4 = medfilt2(image1) + medfilt2(image2);

% add noise 
%image8 = imnoise(image7,'salt & pepper',0.02);
%mediam filter combined image

%find difference
image_diff = image4 - image3;
diff_sum = sum(image_diff(:));

%plot
figure
subplot(2,2,1), imshow(image1), title('image1');
subplot(2,2,2), imshow(image2), title('image2');
subplot(2,2,3), imshow(image3), title('Case C');
subplot(2,2,4), imshow(image4), title('Case D');