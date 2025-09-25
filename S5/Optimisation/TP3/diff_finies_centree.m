% Auteur : J. Gergaud
% décembre 2017
% -----------------------------
% 



function Jac= diff_finies_centree(fun, x, option)
%
% Cette fonction calcule les différences finies centrées sur un schéma
% Paramètres en entrées
% fun : fonction dont on cherche à calculer la matrice jacobienne
%       fonction de IR^n à valeurs dans IR^m
% x   : point où l'on veut calculer la matrice jacobienne
% option : précision du calcul de fun (ndigits)
%
% Paramètre en sortie
% Jac : Matrice jacobienne approximé par les différences finies
%        real(m,n)
% ------------------------------------
I=eye(length(x));
Jac = zeros(length(fun(x)),length(x));
for j = 1:length(x)
    h=sqrt(max(eps,10^(-option)))*max(abs(x(j)),1)*sgn(x(j));
    C=(fun(x+h*I(:,j))-fun(x-h*I(:,j)))/(2*h); 
    Jac(:,j)=C;
end

end

function s = sgn(x)
% fonction signe qui renvoie 1 si x = 0
if x==0
  s = 1;
else 
  s = sign(x);
end
end





