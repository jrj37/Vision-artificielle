function [M] = CalculMat_projection(pts2D,pts3D)

%Donnée 2D et 3D
Vect2D=load(pts2D);
Vect3D=load(pts3D);

%Initialisation des vecteurs 2D

u = Vect2D(:, 1);
v = Vect2D(:, 2);

%Initialisation des vecteurs 3D

X = Vect3D(:, 1);
Y = Vect3D(:, 2);
Z = Vect3D(:, 3);

% Création de la matrice B
sz2D = length(X); % Nombre de points
B = zeros(2*sz2D, 12);

for i = 1:sz2D
    B(2*i-1, :) = [X(i), Y(i), Z(i), 1, 0, 0, 0, 0, -X(i)*u(i), -Y(i)*u(i), -Z(i)*u(i), -u(i)];
    B(2*i, :) = [0, 0, 0, 0, X(i), Y(i), Z(i), 1, -X(i)*v(i), -Y(i)*v(i), -Z(i)*v(i), -v(i)];
end

%On fait le svd de la matrice B
[U,D,V]=svd(B);

m =V(:,end);
NormM=norm(m);
%On redimensionne pour faire Mchapeau
Mchapeau = reshape(m, 4, 3)';

%On normalise Mchapeau pour obtenir M car marge erreur, il manque une constante 
m3= Mchapeau(3,1:3);
M=Mchapeau/norm(m3);