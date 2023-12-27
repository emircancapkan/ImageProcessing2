function mymorph(selectedColormap,img)
    switch selectedColormap
        case 'Turbo colormap'
            % Display the image using imshow
            imshow(img);
            % Apply a colormap (replace 'jet' with the desired colormap name)
            colormap('turbo');
            colorbar;

        case 'Winter colormap'
            % Display the image using imshow
            imshow(img);
            % Apply a colormap (replace 'jet' with the desired colormap name)
            colormap('winter');
            colorbar;

        case 'Abyss colormap'
            % Display the image using imshow
            imshow(img);
            % Apply a colormap (replace 'jet' with the desired colormap name)
            colormap('abyss');
            colorbar;

        case 'Cool colormap'
            % Display the image using imshow
            imshow(img);
            % Apply a colormap (replace 'jet' with the desired colormap name)
            colormap('cool');
            colorbar;

        case 'Jet colormap'
            % Display the image using imshow
            imshow(img);
            % Apply a colormap (replace 'jet' with the desired colormap name)
            colormap('jet');
            colorbar;
    end
end

