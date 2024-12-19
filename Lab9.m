% Clear Command Window
clc;
close all;

% Segment 1
% Import and read the color leaf image file
leafimg = imread("/Users/sunnypark/Documents/Code/School/ECET369/Lab9/leaf-lab5.jpg");

% Create an averaging filter size of 3x3
leaf_avg_filter = fspecial('average',[3,3]);

% Apply the averaging filter (created in line 10) to the leaf color image
leafavg_clr_img = imfilter(leafimg, leaf_avg_filter);

% Convert the leaf color image to grayscale
leafgrayimg = rgb2gray(leafavg_clr_img);

% Display both the color leaf image and the grayscale leag image
figure;
subplot(1,2,1), imshow(leafimg), title('Color Leaf Image');
subplot(1,2,2), imshow(leafgrayimg), title('Grayscale Leaf Image');

% Obtain the rows and columns of the grayscale leaf image
[r, c] = size(leafgrayimg);

% Loop through each row of the image
for i = 1:r
   % Loop through each column of the image
   for j = 1:c
       % Invert the pixel value of the grayscale image
       lab9_gray(i, j) = 255 - leafgrayimg(i, j);
   end
end

% Display both the grayscale leaf image and the inverted grayscale leaf image
figure;
subplot(1,2,1), imshow(leafgrayimg), title('Grayscale Leaf Image');
subplot(1,2,2), imshow(lab9_gray), title('Inverted Grayscale Leaf Image');

% Apply Sobel Edge Detection on the inverted grayscale leaf image
sobeledge = edge(lab9_gray, 'sobel');
figure;
subplot(1,2,1), imshow(lab9_gray), title('Inverted Grayscale Leaf Image');
subplot(1,2,2), imshow(sobeledge), title('Sobel Edge Detection');

% Apply Roberts Edge Detection on the inverted grayscale leaf image
robertsedge = edge(lab9_gray, 'roberts');
figure;
subplot(1,2,1), imshow(lab9_gray), title('Inverted Grayscale Leaf Image');
subplot(1,2,2), imshow(robertsedge), title('Roberts Edge Detection');

% Apply Prewitt Edge Detection on the inverted grayscale leaf image
prewittedge = edge(lab9_gray, 'prewitt');
figure;
subplot(1,2,1), imshow(lab9_gray), title('Inverted Grayscale Leaf Image');
subplot(1,2,2), imshow(prewittedge), title('Prewitt Edge Detection');

% Apply Canny Edge Detection on the inverted grayscale leaf image
cannyedge = edge(lab9_gray, 'canny');
figure;
subplot(1,2,1), imshow(lab9_gray), title('Inverted Grayscale Leaf Image');
subplot(1,2,2), imshow(cannyedge), title('Canny Edge Detection');


% Segment 2
% Import and read the wood color-image file
woodimg = imread("/Users/sunnypark/Documents/Code/School/ECET369/Lab9/bgwd5_crp.jpg");

% Convert the wood color-image to grayscale image
woodgrayimg = rgb2gray(woodimg);

% Create an averaging filter size of 3x3
avgfilter = fspecial('average',[3,3]);

% Apply the averaging filter (created in line 72) to the wood color-image
woodavgfilter = imfilter(woodgrayimg, avgfilter);
x = woodavgfilter;

% Create the Laplacian Edge Detection
lapedgedetect = fspecial('laplacian', 0.2);

% Autothresholding
grayimgthresh = graythresh(woodgrayimg);

% Scaling the threshold value so that it matches the range 0 to 255
sth = grayimgthresh * 255;

% Obtain the rows and columns of the grayscale wood image
[r, c] = size(woodgrayimg);

% Copying the grayscale wood image to a different variable
copygrayimg = woodgrayimg;

% Loop through each row of the image
for i = 1:r
   % Loop through each column of the image
   for j = 1:c
       % Obtain pixel value of the grayscale wood image
       pixel = copygrayimg(i, j);
       % if pixel value is less than the scaled threshold:
       if(pixel <= sth)
           % Set the grayscale wood image to zero (black)
           copygrayimg(i, j) = 0;
       else
           % The pixel value remains unchanged
           copygrayimg(i, j) = pixel;
       end
   end
end

% Apply Laplacian Edge Detection
laplacianedge = imfilter(woodgrayimg,lapedgedetect, 'replicate');

% Display both the wood color-image
figure;
subplot(1,2,1); imshow(woodimg), title('Color Wood Image');
subplot(1,2,2); imshow(x), title('Average Filter Wood Image');

% Display both wood image with  averaging filter applied and the grayscale wood image
figure;
subplot(1,2,1); imshow(x), title('Average Filter Wood Image');
subplot(1,2,2); imshow(woodgrayimg), title('Grayscale Wood Image');

% Display both the grayscale image and the background segmented wood image
figure;
subplot(1,2,1); imshow(woodgrayimg), title('Grayscale Wood Image');
subplot(1,2,2); imshow(copygrayimg), title('Background Segmented Wood Image');

% Display both the background segmented wood image and the image with LapLacian Edge Detection applied
figure;
subplot(1,2,1); imshow(copygrayimg), title('Background Segmented Wood Image');
subplot(1,2,2); imshow(laplacianedge), title('Laplacian Edge Detection');