% Read an image
img = imread("1.jpg");

% Convert to grayscale if necessary
if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

% Compute the Fourier Transform
img_fft = fftshift(fft2(double(img_gray)));

% Display the magnitude spectrum
magnitude_spectrum = log(abs(img_fft) + 1); % Take the logarithm for visualization
figure;
subplot(3, 2, 1);
imshow(magnitude_spectrum, []);
title('Magnitude Spectrum');

% Apply a high-pass filter in the frequency domain to enhance edges
% Define a Gaussian high-pass filter
[M, N] = size(img_gray);
sigma = 10; % You can adjust this parameter for the desired amount of smoothing
[X, Y] = meshgrid(1:N, 1:M);
centerX = ceil(N/2);
centerY = ceil(M/2);
gaussian_highpass = 1 - exp(-((X-centerX).^2 + (Y-centerY).^2) / (2*sigma^2));

% Apply the high-pass filter in the frequency domain
img_fft_filtered = img_fft .* gaussian_highpass;

% Compute the inverse Fourier Transform
img_filtered = ifft2(ifftshift(img_fft_filtered));
img_filtered_abs = abs(img_filtered);

% Display the filtered image
subplot(3, 2, 2);
imshow(abs(img_filtered), []);
title('Filtered Image');

% Edge Detection
edges = edge(abs(img_filtered), 'sobel');
subplot(3, 2, 3);
imshow(edges);
title('Edges');

% Corner Detection
corners = detectHarrisFeatures(abs(img_filtered));
subplot(3, 2, 4);
imshow(img_gray);
hold on;
plot(corners.selectStrongest(50));
title('Corners');

% Blob Detection
blobs = detectSURFFeatures(abs(img_filtered));
subplot(3, 2, 5);
imshow(img_gray);
hold on;
plot(blobs.selectStrongest(50));
title('Blobs');

% Interest Points
points = detectFASTFeatures(abs(img_filtered));
subplot(3, 2, 6);
imshow(img_gray);
hold on;
plot(points.selectStrongest(50));
title('Interest Points');
