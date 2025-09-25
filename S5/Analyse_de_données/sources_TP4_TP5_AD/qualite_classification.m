% fonction qualite_classification (pour l'exercice 1)

function [pourcentage_bonnes_classifications_total, ...
          pourcentage_bonnes_classifications_fibrome, ...
          pourcentage_bonnes_classifications_melanome] ...
          = qualite_classification(Y_pred,Y)

    FBC = (Y_pred == 1) & (Y == 1);
    MBC = (Y_pred ~= 1) & (Y ~= 1 );
    F = (Y==1);
    M =  (Y~=1);
    pourcentage_bonnes_classifications_fibrome = 100*sum(FBC)/sum(F);
    pourcentage_bonnes_classifications_melanome = 100*sum(MBC)/sum(M);
    pourcentage_bonnes_classifications_total = 100*(sum(FBC)+sum(MBC))/(sum(F)+sum(M));


end