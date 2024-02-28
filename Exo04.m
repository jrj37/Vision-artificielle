%Initialisation des paramètres

PtsMire = load("mireXY.txt");
B = zeros(20,6);
NbPoints2D= 10;

%Calcul de la matrice B

for i = 1:NbPoints2D
    Pts2D = load("pts2D_"+i+".txt");
    H = calculHomographieMatrice(PtsMire,Pts2D,size(Pts2D,1));

    B(2*i-1,:) = [((H(1,1)^2)-(H(1,2)^2))
                  2*((H(2,1)*(H(1,1))-(H(2,2)*H(1,2))))
                  2*((H(3,1)*(H(1,1))-(H(3,2)*H(1,2))))
                  ((H(2,1)^2)-(H(2,2)^2))
                  2*((H(2,1)*(H(3,1))-(H(2,2)*H(3,2))))
                  ((H(3,1)^2)-(H(3,2)^2))];

    B(2*i,:)     = [H(1,2)*H(1,1)
                  H(1,2)*H(2,1) + H(2,2)*H(1,1)
                  H(1,2)*H(3,1) + H(3,2)*H(1,1)
                  H(2,2)*H(2,1)
                  H(2,2)*H(3,1) + H(3,2)*H(2,1)
                  H(3,2)*H(3,1)
                  ];

end

%Calcul du SVD pour trouver w
[U, D, V] = svd(B);
w = V(:,end);

%On redimensionne pour créer la matrice W avec les paramètres de w
W = [w(1,1) w(2,1) w(3,1);w(2,1) w(4,1) w(5,1);w(3,1) w(5,1) w(6,1)];

K = inv(W);
K = K/K(3,3);

%Estimation des paramètres intrinsèques
U0 = K(1,3);
V0 = K(2,3);
alphaV = sqrt(K(2,2) - V0^2);
Gamma = (K(1,2) - U0*V0)/alphaV;
alphaU = sqrt(K(1,1) - Gamma^2 - V0^2);

A =  [alphaU Gamma U0;0 alphaV V0; 0 0 1];

h2=H(2,1:3)';
%calcul du lambda
lambda = 1/(norm(inv(A)*h2));


