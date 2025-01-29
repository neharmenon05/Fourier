.% Read the images
image1 = imread('1.png'); % First image
image2 = imread('2.png'); % Second image

% Convert to grayscale if the images are RGB
if size(image1, 3) == 3
    image1 = rgb2gray(image1);
end

if size(image2, 3) == 3
    image2 = rgb2gray(image2);
end

% Resize the second image to match the size of the first image
image2 = imresize(image2, size(image1));

% Compute the Fourier transform of both images
F1 = fft2(double(image1));
F2 = fft2(double(image2));

% Extract magnitude and phase
magnitude1 = abs(F1);
phase1 = angle(F1);

magnitude2 = abs(F2);
phase2 = angle(F2);

% Create the overlay image using magnitude of the first image and phase of the second image
overlay_F = magnitude1 .* exp(1i * phase2);

% Perform the inverse Fourier transform
overlay_image = ifft2(overlay_F);
overlay_image = abs(overlay_image); % Take the absolute value to get the real part

% Overlay the original images with color channels
overlay_rgb = cat(3, im2uint8(image1), im2uint8(zeros(size(image1))), im2uint8(image2));

% Display the images
figure;
subplot(1, 3, 1);
imshow(image1, []);
title('Original Image 1');

subplot(1, 3, 2);
imshow(image2, []);
title('Original Image 2');

subplot(1, 3, 3);
imshow(overlay_rgb);
title('Overlay Image');
