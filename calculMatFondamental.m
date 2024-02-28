function [F] = calculMatFondamental(Vect2DImage1,Vect2DImage3)

% Création de la matrice B
sz2D = 50; % Nombre de points
B = ones(sz2D, 9);

Vect2DImage1W1 = [ Vect2DImage1(1:50, :) ones(50,1)];
Vect2DImage3W1 = [ Vect2DImage3(1:50, :) ones(50,1)];

for i = 1:sz2D
    P1 = Vect2DImage1W1(i,:);
    P2 = Vect2DImage3W1(i,:);
   
   B(i,:) = [P1(1,1)*P2(1,1)
              P1(1,2)*P2(1,1)
              P2(1,1)
              P1(1,1)*P2(1,2)
              P1(1,2)*P2(1,2)
              P2(1,2)
              P1(1,1)
              P1(1,2)
              1];
   
end

[U,D,V]=svd(B);
f =V(:,end);
F13=reshape(f, 3, 3)';

%Résultat
F=F13/F13(3,3);