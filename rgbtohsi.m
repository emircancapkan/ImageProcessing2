function HSI = rgbtohsi(normalizedImage)
    R = normalizedImage(:, :, 1);
    G = normalizedImage(:, :, 2);
    B = normalizedImage(:, :, 3);

    I = (R + G + B) / 3;
    minRGB = min(normalizedImage, [], 3);
    S = 1 - (3 * minRGB) ./ (R + G + B + eps); % Adding eps to avoid division by zero
    
    theta = acos(0.5 * ((R - G) + (R - B)) ./ sqrt((R - G).^2 + (R - B) .* (G - B) + eps)); % Adding eps to avoid division by zero
    H = theta;
    H(B > G) = 2 * pi - H(B > G);
    H = H / (2 * pi);

    %HSI
    HSI=zeros(size(normalizedImage));
    HSI(:,:,1)=H;
    HSI(:,:,2)=S;
    HSI(:,:,3)=I;
end

