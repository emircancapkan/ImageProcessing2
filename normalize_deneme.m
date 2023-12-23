function R= mynormalize(Image_rgb)
    Image_rgb = im2double(Image_rgb);

    [row, col, ~] = size(Image_rgb); % Get the dimensions of the image
    
    Image_red = Image_rgb(:,:,1);
    Image_green = Image_rgb(:,:,2);
    Image_blue = Image_rgb(:,:,3);
    
    for y = 1:row
        for x = 1:col
            Red = Image_red(y, x);
            Green = Image_green(y, x);
            Blue = Image_blue(y, x);
            
            % Check if the pixel is not black
            if (Red ~= 0 || Green ~= 0 || Blue ~= 0)
                NormalizedRed = Red / sqrt(Red^2 + Green^2 + Blue^2);
                NormalizedGreen = Green / sqrt(Red^2 + Green^2 + Blue^2);
                NormalizedBlue = Blue / sqrt(Red^2 + Green^2 + Blue^2);
                
                Image_red(y, x) = NormalizedRed;
                Image_green(y, x) = NormalizedGreen;
                Image_blue(y, x) = NormalizedBlue;
            end
        end
    end
    
    Image_rgb(:,:,1) = Image_red;
    Image_rgb(:,:,2) = Image_green;
    Image_rgb(:,:,3) = Image_blue;
    
    R = Image_rgb .* Image_rgb;
    R = uint8(R); % Adjusting the range to [0, 255]
end

