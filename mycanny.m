function edgeImage = mycanny(inputImage, n, std, lowThreshRatio, highThreshRatio)
    % Convert image to grayscale if it is not already
    if size(inputImage, 3) == 3
        inputImage = rgb2gray(inputImage);
    end
    
    % Apply Gaussian filter for smoothing
    gaussFilter = fspecial('gaussian', n, std);
    smoothedImage = imfilter(inputImage, gaussFilter, 'same');

    % Calculate gradients using Sobel operator
    [Gx, Gy] = imgradientxy(double(smoothedImage), 'sobel');
    Gmag = hypot(Gx, Gy);
    Gdir = atan2(Gy, Gx) * 180 / pi;

    % Non-Maximum Suppression
    suppressedImage = nonMaxSuppression(Gmag, Gdir);

    % Determine high and low thresholds
    highThreshold = max(suppressedImage(:)) * highThreshRatio;
    lowThreshold = highThreshold * lowThreshRatio;

    % Hysteresis Thresholding
    edgeImage = hysteresisThresholding(suppressedImage, lowThreshold, highThreshold);
end

function output = nonMaxSuppression(mag, dir)
    % Initialize output image
    [rows, cols] = size(mag);
    output = zeros(rows, cols);

    % Adjust directions to nearest 0, 45, 90, or 135 degree
    adjustedDir = mod(dir + 180, 180);  % Adjust angles to [0, 180) interval
    for i = 2:rows-1
        for j = 2:cols-1
            q = 255;
            r = 255;

            % Neighbour pixels for non-maximum suppression
            if (0 <= adjustedDir(i, j) < 22.5) || (157.5 <= adjustedDir(i, j) <= 180)
                q = mag(i, j+1);
                r = mag(i, j-1);
            elseif (22.5 <= adjustedDir(i, j) < 67.5)
                q = mag(i+1, j-1);
                r = mag(i-1, j+1);
            elseif (67.5 <= adjustedDir(i, j) < 112.5)
                q = mag(i+1, j);
                r = mag(i-1, j);
            elseif (112.5 <= adjustedDir(i, j) < 157.5)
                q = mag(i-1, j-1);
                r = mag(i+1, j+1);
            end

            % Suppress non-maximum values
            if (mag(i, j) >= q) && (mag(i, j) >= r)
                output(i, j) = mag(i, j);
            else
                output(i, j) = 0;
            end
        end
    end
end

function output = hysteresisThresholding(img, lowThresh, highThresh)
    output = zeros(size(img));
    strongEdges = img > highThresh;
    weakEdges = (img >= lowThresh) & ~strongEdges;

    [rows, cols] = size(img);
    for i = 2:rows-1
        for j = 2:cols-1
            if weakEdges(i, j)
                if any(any(strongEdges(i-1:i+1, j-1:j+1)))
                    output(i, j) = 1;
                end
            elseif strongEdges(i, j)
                output(i, j) = 1;
            end
        end
    end
end
