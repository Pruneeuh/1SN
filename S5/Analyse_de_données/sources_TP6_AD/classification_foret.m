% fonction classification_foret (pour l'exercice 2)

function Y_pred = classification_foret(foret, X)

    nb_arbres = length(foret);
    Y_predict =zeros(size(X,1),nb_arbres);
    for i = 1:nb_arbres 
        Y_predict(:,i)=classification_arbre(foret{i},X);
    end
    Y_pred=mode(Y_predict,2);

end