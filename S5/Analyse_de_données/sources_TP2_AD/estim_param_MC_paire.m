% fonction estim_param_MC_paire (pour exercice_2.m)

function parametres = estim_param_MC_paire(d,x,y_inf,y_sup)
    p = size(x,1); 
    Ainfsup = zeros(p,d-1);
    for k=1:(d-1)
        Ainfsup(:,k) = vecteur_bernstein(x,d,k);
    end
    A = [ Ainfsup zeros(p,d-1) vecteur_bernstein(x,d,d) ; zeros(p,d-1) Ainfsup vecteur_bernstein(x,d,d)];

    Binf = y_inf - y_inf(1) *vecteur_bernstein(x,d,0);
    Bsup = y_sup - y_sup(1) * vecteur_bernstein(x,d,0);

    B = [Binf ; Bsup];
   

    parametres = mldivide(A,B); 

end
