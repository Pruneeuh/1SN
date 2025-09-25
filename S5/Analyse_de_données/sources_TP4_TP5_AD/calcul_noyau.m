% fonction calcul_noyau (pour l'exercice 3)

function K = calcul_noyau(Xj,Xi,sigma)
    nj = size(Xj,1); 
    ni = size(Xi,1); 
    norme = zeros(nj,ni); 
    for k = 1:size(Xi,2)
        norme_ = norme + (repmat(Xj(:,k),1,ni)-repmat(Xi(:,k)',nj,1)).^2; 
    end 
    K = exp(-norme_/(2*sigma^2));
end