% Fonction estim_param_Dyx_MC (exercice_1.m)

function [a_Dyx,b_Dyx] = ...
                   estim_param_Dyx_MC(x_donnees_bruitees,y_donnees_bruitees)

    A = [x_donnees_bruitees  ones(length(x_donnees_bruitees),1)];
    B = y_donnees_bruitees; 
    X = A \ B; 
    a_Dyx = X(1);
    b_Dyx = X(2);     
end