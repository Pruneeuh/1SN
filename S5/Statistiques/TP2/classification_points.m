% Fonction classification_points (exercice_3.m)

function [x_classe_1,y_classe_1,x_classe_2,y_classe_2] = classification_points ...
              (x_donnees_bruitees,y_donnees_bruitees,probas_classe_1,probas_classe_2)

    [~,arg_max]=max([probas_classe_1 probas_classe_2],[],2); 


    x_classe_1 = x_donnees_bruitees(arg_max==1);
    y_classe_1 = y_donnees_bruitees(arg_max==1);

    x_classe_2 = x_donnees_bruitees(arg_max==2);
    y_classe_2 = y_donnees_bruitees(arg_max==2);

end