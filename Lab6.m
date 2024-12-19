% Clear Command Window
clc;

% Import and read the image file
img = imread("/Users/sunnypark/Documents/Code/School/ECET369/Lab6/bgwd5_crp.jpg");

% Extract R, G, B values
r = img(:,:,1); 
g = img(:,:,2); 
b = img(:,:,3);

% Display the four images: original, Red, Green, and Blue
figure;
subplot(2,2,1), imshow(img), title("Original Image");
subplot(2,2,2), imshow(r), title('Red');
subplot(2,2,3), imshow(g), title('Green');
subplot(2,2,4), imshow(b), title('Blue');

% Convert RGB to grayscale image
gray = rgb2gray(img);

% Display both the original image and grayscale image
figure;
subplot(1,2,1), imshow(img), title('Color Image');
subplot(1,2,2), imshow(gray), title('Grayscale Image');

% Display the four histograms: R, G, B, and grayscale
figure;
subplot(2,2,1), imhist(r), title('Red Histogram');
subplot(2,2,2), imhist(g), title('Green Histogram');
subplot(2,2,3), imhist(b), title('Blue Histogram');
subplot(2,2,4), imhist(gray), title('Gray Histogram');

% Save the histograms
savefig('/Users/sunnypark/Documents/Code/School/ECET369/Lab6/Lab6Histogram.fig');

% Calculating the histogram of R, G, B, and the grayscale
[countsr, binlocationsr] = imhist(r);
[countsg, binlocationsg] = imhist(g);
[countsb, binlocationsb] = imhist(b);
[countsgray, binlocationsgray] = imhist(gray);

% Combine the bin locations and counts for each histogram into a shared variable called "histogramdata"
histogramdata = [binlocationsr, countsr, binlocationsg, countsg, binlocationsb, countsb, countsgray, binlocationsgray];

% Save the histogram as an excel file
writematrix(histogramdata, '/Users/sunnypark/Documents/Code/School/ECET369/Lab6/HistogramData.xlsx');

% Calculate the mean, variance, and standard deviation for each of the R, G, B, and grayscale channels
[meanr, varr, stddevr] = calc(countsr);
[meang, varg, stddevg] = calc(countsg);
[meanb, varb, stddevb] = calc(countsb);
[meangray, vargray, stddevgray] = calc(countsgray);

% Display the calculated values
disp(['Mean for the red channel: ', num2str(meanr)]);
disp(['Variance for the red channel: ', num2str(varr)]);
disp(['Standard Deviation for the red channel: ', num2str(stddevr)]);

disp(['Mean for the green channel: ', num2str(meang)]);
disp(['Variance for the green channel: ', num2str(varg)]);
disp(['Standard Deviation for the green channel: ', num2str(stddevg)]);

disp(['Mean for the blue channel: ', num2str(meanb)]);
disp(['Variance for the blue channel: ', num2str(varb)]);
disp(['Standard Deviation for the blue channel: ', num2str(stddevb)]);

disp(['Mean for the grayscale Channel: ', num2str(meangray)]);
disp(['Variance for the grayscale Channel: ', num2str(vargray)]);
disp(['Standard Deviation for the grayscale Channel: ', num2str(stddevgray)]);