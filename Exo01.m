%Chargement matrice de rotation et vecteur de translation
R=load("R1.txt");
t=load("t1.txt");
%1 Matrice A avec les paramètres intrinsèques
A=[800 0 256; 0 800 256;0 0 1];

%2 verifier si matrice rotation
I=transpose(R)*R;
detR=det(R);
%3Construction de la matrice de projection M
M=A*[R -R*t];
Test= [R -R*t];
