% Clear workspace and command window
clc;
close all;

% Import the original color image
unknownImg = imread("/Users/sunnypark/Documents/Code/School/ECET369/FinalProject/sample5.jpg");

% Display the original image
figure;
imshow(unknownImg);
title('Original Image');

% Create an averaging filter size of 3x3
img_avg_filter = fspecial('average', [3, 3]);

% Apply the averaging filter to the color image
avg_applied_img = imfilter(unknownImg, img_avg_filter);

% Convert the color image to grayscale
grayImg = rgb2gray(avg_applied_img);

% Obtain the rows and columns of the grayscale image
[r, c] = size(grayImg);

% Invert the pixel values of the grayscale image
invertGrayImg = 255 - grayImg;

% Apply Sobel Edge Detection on the inverted grayscale image
sobelEdge = edge(invertGrayImg, 'sobel');

% Display inverted grayscale image and Sobel edge detection results
figure;
subplot(1, 2, 1), imshow(invertGrayImg), title('Inverted Grayscale Image');
subplot(1, 2, 2), imshow(sobelEdge), title('Sobel Edge Detection');

% Threshold to create a binary image
binImg = imbinarize(grayImg);

% Fill holes and remove small objects
binImg = bwareaopen(binImg, 100);
binImg = imfill(binImg, 'holes');

% Display binary image
figure;
imshow(binImg);
title('Binary Image');

% Detect edges using the Canny method
edgeImg = edge(binImg, 'Canny');

% Display edge detection result
figure;
imshow(edgeImg);
title('Edge Detection');

% Extract geometric properties
stats = regionprops(binImg, 'Area', 'Perimeter', 'Eccentricity', 'Circularity', 'BoundingBox');

% Assume we analyze the largest connected component
[~, largestIdx] = max([stats.Area]);
area = stats(largestIdx).Area;
perimeter = stats(largestIdx).Perimeter;
eccentricity = stats(largestIdx).Eccentricity;
circularity = stats(largestIdx).Circularity;

% Display extracted features
disp('Extracted Features:');
disp(['Area: ', num2str(area)]);
disp(['Perimeter: ', num2str(perimeter)]);
disp(['Eccentricity: ', num2str(eccentricity)]);
disp(['Circularity: ', num2str(circularity)]);

% Shape classification based on circularity and eccentricity
if circularity > 0.8 && eccentricity < 0.5
    shape = 'Circle';
else
    shape = 'Square';
end

% Display shape classification result
disp(['The object is classified as: ', shape]);

% Show the final result on the image
figure;
imshow(unknownImg);
title(['Classified as: ', shape]);
