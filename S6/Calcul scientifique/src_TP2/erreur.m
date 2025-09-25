%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP2 - Factorisation LU
% descente.m
%---------------------------------------------------------------------------

function [err_d,err_i] = erreur(A,b,x,x_exact,norm_A)
%---------------------------------------------------------------------------
% Calcul des erreurs directe err_d et inverse err_i
% x_exact tel que A x_exact=b; x solution numerique
%---------------------------------------------------------------------------
       
     % Erreur directe (distance entre sol approx et sol vraie)
     err_d=norm(x_exact-x)/norm(x_exact);
     
     % Erreur inverse
     [n,~]=size(A);

     L = tril(A,-1)+eye(n);
     U = triu(A);
     err_i=norm(L*U*x-b)/(norm_A*norm(x)+norm(b));
end
