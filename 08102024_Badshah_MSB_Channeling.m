
clc; clear;

%%%%
%%%% Loading the image
img = imread('chips.png');
imshow(img)

% b. Print the pixel value of the image for all 3 channels (R, G, B) at (300,300)
pvr = img(300,300,1);
pvg = img(300,300,2);
pvb = img(300,300,3);
sprintf('pixel value red is %d',pvr)
sprintf('pixel value green is %d',pvg)
sprintf('pixel value blue is %d',pvb)

% c. Use subplot function to display the original image, image in red channel,
% image in green channel, and image in blue channel of this image
R_channel = img(:, :, 1); % Red channel
G_channel = img(:, :, 2); % Green channel
B_channel = img(:, :, 3); % Blue channel
figure;
subplot(2, 2, 1); imshow(img); title('Original Image');
subplot(2, 2, 2); imshow(R_channel); title('Red Channel');
subplot(2, 2, 3); imshow(G_channel); title('Green Channel');
subplot(2, 2, 4); imshow(B_channel); title('Blue Channel');
% d. Convert the image to grayscale
imgGray = rgb2gray(img);
figure;
imshow(imgGray); title('Grayscale Image');

% e. Rotate the grayscale image clockwise by 45 degrees
imgGrayRotated = imrotate(imgGray, -45); % Negative angle for clockwise rotation
figure;
imshow(imgGrayRotated); title('Rotated Grayscale Image (45° Clockwise)');