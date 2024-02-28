%Calcul de la matrice de projection pour la caméra 1 et la caméra 2

M1=CalculMat_projection('2dpts_1.txt','3dpts.txt');
M2=CalculMat_projection('2dpts_2.txt','3dpts.txt');

%Constrcution des vecteurs de la scène

Vect2D_Cam1_Sc=load('2dpts-scene_1.txt');
Vect2D_Cam2_Sc=load('2dpts-scene_2.txt');

    n=size(Vect2D_Cam1_Sc);
    taille = size(Vect2D_Cam1_Sc,1);
%ax=b 

scene3D = zeros(taille,3); %pour calcul scène 3D

for i = 1:n

    u1 = Vect2D_Cam1_Sc(i,1);
    v1 = Vect2D_Cam1_Sc(i,2);
    u2 = Vect2D_Cam2_Sc(i,1);
    v2 = Vect2D_Cam2_Sc(i,2);
    
    A = [(M1(1,1)-M1(3,1)*u1) (M1(1,2)-M1(3,2)*u1) (M1(1,3)-M1(3,3)*u1);
         (M1(2,1)-M1(3,1)*v1) (M1(2,2)-M1(3,2)*v1) (M1(2,3)-M1(3,3)*v1);
         (M2(1,1)-M2(3,1)*u2) (M2(1,2)-M2(3,2)*u2) (M2(1,3)-M2(3,3)*u2);
         (M2(2,1)-M2(3,1)*v2) (M2(2,2)-M2(3,2)*v2) (M2(2,3)-M2(3,3)*v2)];
    
    b = [(M1(3,4)*u1-M1(1,4));(M1(3,4)*v1-M1(2,4));(M2(3,4)*u2-M2(1,4));
         (M2(3,4)*v2-M2(2,4))];

    X = (A\b)';
    scene3D(i,:) = X;

end

%affichage de la scène 3D

figure(1);
plot3(scene3D(:,1),scene3D(:,2),scene3D(:,3),'b');
