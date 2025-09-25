% fonction estim_param_MC (pour exercice_1.m)

function parametres = estim_param_MC(d,x,y)
    p = size(x,1);
    A = zeros(p,d); 
    for k=1:d
        A(:,k) = vecteur_bernstein(x,d,k);
    end 
    B = y - y(1,1) *vecteur_bernstein(x,d,0);
    parametres = mldivide(A,B);
end
