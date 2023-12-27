function marr_hildreth_edge_detector(image_path, std, n, threshold_factor)
    % Read the image
    I = imread(image_path);
    I = im2double(I); % Convert to double for processing

    % Step 1: Create the LoG kernel
    [X, Y] = meshgrid(-floor(n/2):floor(n/2), -floor(n/2):floor(n/2));
    LoG = -(1/(pi*std^4)) * (1 - (X.^2 + Y.^2)/(2*std^2)) .* exp(-(X.^2 + Y.^2)/(2*std^2));

    % Step 2: Filter the image with the Gaussian lowpass kernel
    blurredImage = imfilter(I, LoG, 'same', 'replicate');

    % Step 3: Apply Laplacian (second derivative)
    % This is already part of the LoG filter, so no further action is needed here

    % Step 4: Find zero crossings
    zeroCrossingImage = zero_crossings(blurredImage, threshold_factor);

    % Display results
    figure, imshow(I), title('Original Image');
    figure, imshow(blurredImage, []), title('LoG Filtered Image');
    figure, imshow(zeroCrossingImage), title('Zero Crossings');
end

function zeroCrossingImage = zero_crossings(image, threshold_factor)
    % Calculate the threshold based on the factor and the maximum value in the image
    threshold = threshold_factor * max(image(:));
    
    % Initialize the zero crossing image
    zeroCrossingImage = false(size(image));
    
    % Pad the image to avoid border issues
    paddedImage = padarray(image, [1, 1], 'replicate');

    % Iterate over the image
    for i = 2:size(paddedImage, 1) - 1
        for j = 2:size(paddedImage, 2) - 1
            % Extract the 3x3 neighborhood
            neighborhood = paddedImage(i-1:i+1, j-1:j+1);
            centerPixel = neighborhood(2, 2);
            
            % Check for sign changes and threshold in the neighborhood
            if any(neighborhood(:) > threshold) && any(neighborhood(:) < -threshold)
                if sign(centerPixel) ~= sign(neighborhood(1,2)) || sign(centerPixel) ~= sign(neighborhood(3,2)) || ...
                   sign(centerPixel) ~= sign(neighborhood(2,1)) || sign(centerPixel) ~= sign(neighborhood(2,3)) || ...
                   sign(centerPixel) ~= sign(neighborhood(1,1)) || sign(centerPixel) ~= sign(neighborhood(3,3)) || ...
                   sign(centerPixel) ~= sign(neighborhood(1,3)) || sign(centerPixel) ~= sign(neighborhood(3,1))
                    zeroCrossingImage(i-1, j-1) = true;
                end
            end
        end
    end
end
