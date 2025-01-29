function compress_image_with_slider()
    % Load and display the original image
    image = imread('compression.jpg');
    grayImage = rgb2gray(image);
    
    % Create a figure window with two subplots
    hFig = figure('Name', 'Image Compression with Slider', 'NumberTitle', 'off');
    hAx1 = subplot(1, 2, 1);
    imshow(grayImage, 'Parent', hAx1);
    title(hAx1, 'Original Image');
    
    hAx2 = subplot(1, 2, 2);
    hImg2 = imshow(grayImage, 'Parent', hAx2);
    title(hAx2, 'Compressed Image');
    
    % Create a slider
    hSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 0.1, 'Value', 0.005, ...
                        'Units', 'normalized', 'Position', [0.15 0.01 0.7 0.05]);
    
    % Add a listener to the slider to call the update function when the value changes
    addlistener(hSlider, 'Value', 'PostSet', @(src, event) updateImage(hImg2, grayImage, get(event.AffectedObject, 'Value')));
    
    % Initial update
    updateImage(hImg2, grayImage, get(hSlider, 'Value'));
    
    function updateImage(hImg, grayImage, threshold)
        % Perform FFT on the grayscale image
        fourierImage = fft2(grayImage);
        
        % Apply threshold to compress the image
        maxVal = max(abs(fourierImage(:)));
        fourierImage(abs(fourierImage) < threshold * maxVal) = 0;
        
        % Perform inverse FFT to get the compressed image
        compressedImage = ifft2(fourierImage);
        
        % Update the image display with the compressed image
        set(hImg, 'CData', abs(compressedImage));
    end
end
