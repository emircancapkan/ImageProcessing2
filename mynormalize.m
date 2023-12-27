function normalized_hsi = mynormalize(hsi)
% % Normalize H, S, I components
% H = H / (2 * pi);
% S = S / max(S(:));
% I = I / max(I(:));

    % Normalize the input image to the range [0, 1]
    min_val = min(hsi(:));
    max_val = max(hsi(:));
    
    if max_val - min_val ~= 0
        normalized_hsi = (hsi - min_val) / (max_val - min_val);
    else
        % If the image is constant, return the same image
        normalized_hsi=hsi;
    end

end