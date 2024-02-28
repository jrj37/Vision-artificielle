function [H] = calculHomographieMatrice(PtsScene,PtsImage, NbPoints)
    B = zeros(2*NbPoints, 9);

     X = PtsScene(:, 1);
     Y = PtsScene(:, 2);
     u = PtsImage(:, 1);
     v = PtsImage(:, 2);

    for i=1:NbPoints
        B(2*i-1, :) = [X(i) Y(i) 1 0 0 0 -u(i)*X(i) -u(i)*Y(i) -u(i)];
        B(2*i, :) = [0 0 0 X(i) Y(i) 1 -v(i)*X(i) -v(i)*Y(i) -v(i)];
    end
    
    [U, D, V] = svd(B);
    
    H = reshape(V(:, end), 3, 3)';
end
