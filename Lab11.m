% Clear Command Window
clc;
close all;

% Import the original color image
img = imread("/Users/sunnypark/Documents/Code/School/ECET369/Lab11/blk1_crp.jpg");

% Create an averaging filter size of 3x3
avg_filter = fspecial('average',[3,3]);

% Apply the averaging filter (created in line 9) to the imported color image
avg_clr_img = imfilter(img, avg_filter);

% Display both the imported original color image and the color image with averaging filter applied
figure;
subplot(1,2,1), imshow(img), title('Color Image');
subplot(1,2,2), imshow(avg_clr_img), title('Color Image with Averaging Filter');

% Convert the original color image to grayscale
grayimg = rgb2gray(avg_clr_img);

% Display both the color image with averaging filter applied and the grayscale image
figure;
subplot(1,2,1), imshow(avg_clr_img), title('Color Image with Averaging Filter');
subplot(1,2,2), imshow(grayimg), title('Grayscale Image');

% Apply median filter
med_img = medfilt2(grayimg);

% Display both the grayscale image and the grayscale image with median filter applied
figure;
subplot(1,2,1), imshow(grayimg), title('Grayscale Image');
subplot(1,2,2), imshow(med_img), title('Grayscale Image with Median Filter');

% Calculate the threshold value of the the grayscale image
grayimgthresh = graythresh(grayimg);

% binarize the grayscale image based on the previously calculated threshold
bw = imbinarize(grayimg, grayimgthresh);

% Verify connected components in binary image
bwimage = bwconncomp(bw);

% Display both the grayscale image with median filter applied and the binarized image
figure;
subplot(1,2,1), imshow(med_img), title('Grayscale Image with Median Filter Applied');
subplot(1,2,2), imshow(bw), title('Binarized Image');

% Calculate the centroid, area, and perimeter, and display them in a table
imgprop = regionprops("table", bw, 'Centroid', 'Area', 'Perimeter')

% Calculate the aspect ratio
aspectratio = imgprop.Area / (imgprop.Perimeter * imgprop.Perimeter);

% Display the aspectio ratio calculated in line 45
disp("The Aspect Ratio is: " + aspectratio);