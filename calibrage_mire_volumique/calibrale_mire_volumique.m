%Donnée 2D et 3D
Vect2D=load("2dpts_1.txt");
Vect3D=load("3dpts.txt");

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

%parametres intrinseques extraseques
M1=transpose(M(1,1:3));
M2 =transpose(M(2, 1:3));
M3 =transpose(M(3, 1:3));

u0= transpose(M1)*M3;
v0= transpose(M2)*M3;

AlphaV = sqrt(transpose(M2)*M2-v0^2);
Gamma = (transpose(M1)*M2-u0*v0)/AlphaV;
AlphaU = sqrt(transpose(M1)*M1-Gamma^2-u0^2);
