clc; clear %command window

%%%% 2. "Noisy" image
% a. Load the "noisy.png" image from the folder
noisy_img = imread('noisy.png');

% b. Use Gaussian filter to reduce the noise from the image
denoised_img = imgaussfilt(noisy_img, 2); % Apply Gaussian filter with sigma = 2

% c. Show both the images before and after reducing the noise
figure;
subplot(1, 2, 1); imshow(noisy_img); title('Original Noisy Image');
subplot(1, 2, 2); imshow(denoised_img); title('Denoised Image');

% d. Save the denoised image using imwrite function
imwrite(denoised_img, 'denoised_noisy.png');
fprintf('Denoised image saved as "denoised_noisy.png".\n');
