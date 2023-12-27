function HSI = rgbtohsi(rgb_img)
    rgb_img=double(rgb_img);
    r = rgb_img(:,:,1) / 255;
    g = rgb_img(:,:,2) / 255;
    b = rgb_img(:,:,3) / 255;
    
    % to find components of the image first we can find the intensity
    intensity = (r + g + b) / 3;

    minRGB = min(min(r, g), b);
    saturation = 1 - minRGB ./ (intensity + eps);           %saturation of the hsi image

    %hue component of the hsi image 
    denominator = sqrt((r - g).^2 + (r - b) .* (g - b));
    theta = acos(0.5 * ((r - g) + (r - b)) ./ (denominator + eps));

    %check the tetta value and according to this value find the hue
    hue = theta;
    hue(b > g) = 2 * pi - hue(b > g);
    hue = hue / (2 * pi);

    %assign the found values to the output values
    H = hue;
    S = saturation;
    I = intensity;
    HSI = cat(3, H, S, I);

end