%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP2 - Factorisation LU
% descente.m
%---------------------------------------------------------------------------

function x = descente(L,p,b)
%---------------------------------------------------------------------------
% Resoudre L x = Pb avec 
% L triangulaire inferieure avec diagonale de 1, b second membre,
% et p vecteur des indices de permutation des lignes.
%---------------------------------------------------------------------------
       
     %Initialisation
     [n, ~] = size(L);
     x=b;
     for j=1:n 
         %x(j)=x(j)/L(j,j);
         for i=j+1:n
             x(i)=x(i)-L(i,j)*x(j);
         end
     end
     
end
