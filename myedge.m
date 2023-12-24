function R = myedge(selectedOperation,I,diagonalOrNot,threshold,threshold_val)

    switch selectedOperation
        case 'Prewitt'
            % Prewitt edge detection on intensity
            switch diagonalOrNot
                case 'With diagonal'
                    Gx = [-1 -1 -1; 0 0 0; 1 1 1]; % with diagonal gradients
                    Gy = [-1 0 1; -1 0 1; -1 0 1];
                case 'Without diagonal'
                    Gx = [-1 0 1; -1 0 1; -1 0 1]; % without diagonal gradients
                    Gy = [-1 -1 -1; 0 0 0; 1 1 1];
            end
        
            % Apply convolution on intensity
            gradient_x = conv2(I, Gx, 'same');
            gradient_y = conv2(I, Gy, 'same');
        
            % Compute magnitude
            gradient_magnitude = sqrt(gradient_x.^2 + gradient_y.^2);
        
            % Normalize the magnitude to the range [0, 255]
            normalized_magnitude = (gradient_magnitude - min(gradient_magnitude(:))) / (max(gradient_magnitude(:)) - min(gradient_magnitude(:))) * 255;
        
            % Convert the result to uint8
            R = uint8(normalized_magnitude);
        
            %----------------------------------------------------------------------
            switch threshold
                case 'Basic Global Thresholding'
                % Apply basic global thresholding
                thresholded_image_basic = R > threshold_val;
                R = thresholded_image_basic;

                case 'Global Thresholding Otsu'
                % % Apply optimal global thresholding using Otsu's method
                threshold_otsu = graythresh(R);
                thresholded_image_otsu = R > (threshold_otsu * 255);
                R=thresholded_image_otsu;
            end
        
        case 'Kirsch'
            % Prewitt edge detection on intensity
            switch diagonalOrNot
                case 'With diagonal'
                    Gx = [-1 -1 -1; 0 0 0; 1 1 1]; % with diagonal gradients
                    Gy = [-1 0 1; -1 0 1; -1 0 1];
                case 'Without diagonal'
                    Gx = [-1 0 1; -1 0 1; -1 0 1]; % without diagonal gradients
                    Gy = [-1 -1 -1; 0 0 0; 1 1 1];
            end
        
            % Apply convolution on intensity
            gradient_x = conv2(I, Gx, 'same');
            gradient_y = conv2(I, Gy, 'same');
        
            % Compute magnitude
            gradient_magnitude = sqrt(gradient_x.^2 + gradient_y.^2);
        
            % Normalize the magnitude to the range [0, 255]
            normalized_magnitude = (gradient_magnitude - min(gradient_magnitude(:))) / (max(gradient_magnitude(:)) - min(gradient_magnitude(:))) * 255;
        
            % Convert the result to uint8
            R = uint8(normalized_magnitude);
        
        %----------------------------------------------------------------------
            switch threshold
                case 'Basic Global Thresholding'
                % Apply basic global thresholding
                thresholded_image_basic = R > threshold_val;
                R = thresholded_image_basic;

                case 'Global Thresholding Otsu'
                % % Apply optimal global thresholding using Otsu's method
                threshold_otsu = graythresh(R);
                thresholded_image_otsu = R > (threshold_otsu * 255);
                R=thresholded_image_otsu;
            end   
    end
end

