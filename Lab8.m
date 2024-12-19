% Clear Command Window
clc;

% Import and read the image file
img = imread("/Users/sunnypark/Documents/Code/School/ECET369/Lab8/wood_img.jpg");

% Display imported original color image
imshow(img), title('Color Image');

% Create an average filter of size 3x3
lb_avg_filter = fspecial('average',[3,3]);

% Apply the average filter to the original color image
avg_clr_img = imfilter(img, lb_avg_filter);

% Convert the original color image to grayscale
grayimg = rgb2gray(avg_clr_img);

% Display both the original color image and the color image with the average filter applied
figure;
subplot(1,2,1), imshow(img), title('Color Image');
subplot(1,2,2), imshow(avig_clr_img), title('Average Filtered Color Image');

% Display both the average filtered color image and the grayscale image
figure;
subplot(1,2,1), imshow(avg_clr_img), title('Average Filtered Color Image');
subplot(1,2,2), imshow(grayimg), title('Grayscale Image');

% Calculate the threshold value of the the grayscale image
grayimgthresh = graythresh(grayimg);

% binarize the grayscale image based on the previously calculated threshold
bw = imbinarize(grayimg, grayimgthresh);

% Display both the grayscale image and the binary image
figure;
subplot(1,2,1), imshow(grayimg), title('Grayscale Image');
subplot(1,2,2), imshow(bw), title('B/W Image');

% Convert the scaled threshold to 8-bit scale
sth = grayimgthresh * 255;

% Get the number of rows and columns in the grayscale image
[r, c] = size(grayimg);

% Create a copy of the original grayscale image
copygrayimg = grayimg;

% lines 51 to 61: loop through each pixel of in the grayscale image
% loop through each row of the image
for i = 1:r
    % loop through each column of the image
    for j = 1:c
        % Extract the pixel intensity at (i, j)
        pixel = grayimg(i, j);
        % if pixel intensity is smaller or equal to STH
        if(pixel <= sth)
            % Set pixel intensity to black (0)
            grayimg(i, j) = 0;

        else
            % else keep the original grayscale image
            grayimg(i, j) = pixel;
        end
    end
end

% Display both the grayscale image and the segmented image side by side
figure;
subplot(1,2,1), imshow(copygrayimg), title('Grayscale Image');
subplot(1,2,2), imshow(grayimg), title('Segmented Image');