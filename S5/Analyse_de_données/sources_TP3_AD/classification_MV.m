% fonction classification_MV (pour l'exercice 2)

function Y_pred_MV = classification_MV(X,mu_1,Sigma_1,mu_2,Sigma_2)
    modele_V1 = modelisation_vraisemblance(X,mu_1,Sigma_1);
    modele_V2 = modelisation_vraisemblance(X,mu_2,Sigma_2);
    modele_V = [modele_V1 modele_V2];
    
    [~,indice]=max(modele_V,[],2);

    Y_pred_MV = indice;

    
end
