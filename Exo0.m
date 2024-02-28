
%Récupération des points de la matrice de projection et des points 3D
proj_matrice=load('proj_mat1.txt');
Pts3D=load("3dpts.txt");

%On créé la matrice avec les 1 en plus
sz= size(Pts3D,1);
MatrixWith1=ones(sz,1);
Pts3DWith1=[Pts3D,MatrixWith1];

%On obtient u et v
RES=proj_matrice*transpose(Pts3DWith1);
u = RES(1, :);
v = RES(2, :);

%Graphique de l'image obtenue
plot(u, v, 'b*');

title("Visualisation de l'image");
xlabel('u');
ylabel('v');
