%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP2 - Factorisation LU
% remontee.m
%---------------------------------------------------------------------------

function x = remontee(U,b)
%---------------------------------------------------------------------------
% Resoudre U x = b avec 
% U triangulaire superieure, b second membre.
%---------------------------------------------------------------------------
       
     %Initialisation
     [n, ~] = size(U);
     x=b;
     x(n)=b(n)/U(n,n);
     for i=n:-1:1
         x(i)=x(i)/U(i,i);
         for j=i-1:-1:1
             x(i)=x(i)-U(i,j)*x(j);
         end
       
     end

   
end
