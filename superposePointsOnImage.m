function superposePointsOnImage(img, points, titleText)
    figure;
    imshow(img);
    title(titleText);
    
    hold on; % Permet de superposer les points sur l'image

    for i = 1:size(points, 1)
        x = points(i, 1); % Coordonnée x du point i
        y = points(i, 2); % Coordonnée y du point i

        % Utiliser la fonction plot pour afficher le point (x, y) comme un '+'
        plot(x, y, 'r+'); % 'r+' signifie un 'plus' (+) rouge
    end

    hold off;
end