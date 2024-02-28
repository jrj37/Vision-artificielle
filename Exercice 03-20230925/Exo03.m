Vect2Dimage=load('pts2dimage.txt');
Vect2DSc=load('pts2dscene.txt');

Taille=size(Vect2Dimage,1);

%Initialisation des vecteurs 2D de la scene 
u=Vect2DSc(:,1);
v=Vect2DSc(:,2);

%Initialisation des vecteurs 2D de l'image
X=Vect2Dimage(:,1);
Y=Vect2Dimage(:,2);

%Création de la matrice B
B = zeros(Taille, 9);

for i = 1:Taille/2
    B(2*i-1, :) = [X(i), Y(i), 1, 0, 0, 0, -X(i)*u(i), -Y(i)*u(i), -u(i)];
    B(2*i, :) = [0, 0, 0, X(i), Y(i), 1, -X(i)*v(i), -Y(i)*v(i), -v(i)];
end

%Calcul du SVD et construction de la matrice H
[U,D,V]=svd(B);
h=V(:,end);
H= reshape(h, 3, 3)';

%Construction de la matrice Vect 
sz= size(Vect2Dimage,1);
I=ones(sz,1);
Vect= [Vect2Dimage,I];

%erreurs euclidiennes
P=(H*Vect')';
err= P./P(:,3); %On normalise 
err=err(:,1:2);
Erreur=norm(err-Vect2DSc);



    

