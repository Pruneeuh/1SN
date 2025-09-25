% fonction modelisation_vraisemblance (pour l'exercice 1)

function modele_V = modelisation_vraisemblance(X,mu,Sigma)
    modele_V=[];
    for j = 1:size(X,1)
        modele_V(j,:)=1/(2*pi*sqrt(det(Sigma)))*exp(-(1/2)*(X(j,:)-mu)*(Sigma^(-1))*(X(j,:)-mu)');
    end

end