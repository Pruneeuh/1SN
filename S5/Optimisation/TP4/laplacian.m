function L = laplacian(nu,dx1,dx2,N1,N2)
%
%  Cette fonction construit la matrice de l'opérateur Laplacien 2D anisotrope
%
%  Inputs
%  ------
%
%  nu : nu=[nu1;nu2], coefficients de diffusivité dans les dierctions x1 et x2. 
%
%  dx1 : pas d'espace dans la direction x1.
%
%  dx2 : pas d'espace dans la direction x2.
%
%  N1 : nombre de points de grille dans la direction x1.
%
%  N2 : nombre de points de grilles dans la direction x2.
%
%  Outputs:
%  -------
%
%  L      : Matrice de l'opérateur Laplacien (dimension N1N2 x N1N2)
%
% 

% Initialisation
L=sparse([]);
nu1 = nu(1);
nu2 = nu(2);
a = 2*(nu1/dx1^2 + nu2/dx2^2);
b1 = nu1/dx1^2;
b2 = nu2/dx2^2;
A = zeros(N2,N2);
B = -b1*eye(N2,N2);
C = -b2*eye(N2,N2);

for i 1:N2
    A(i,i)=a;
    if i>1 
        A(i-1,i)=-b2;
        A(i,i-1)=-b2;
    end 
end 
L = zero(N1*N2);
for i 0:N1-1
    L(i*N2+1:(i+1)*N2,i*N2+1:(i+1)*N2)=A
end
for i 

end 


end    
