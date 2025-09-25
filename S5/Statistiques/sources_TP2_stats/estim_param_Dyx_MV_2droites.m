% Fonction estim_param_Dyx_MV_2droites (exercice_2.m) 

function [a_Dyx_1,b_Dyx_1,a_Dyx_2,b_Dyx_2] = ... 
         estim_param_Dyx_MV_2droites(x_donnees_bruitees,y_donnees_bruitees,sigma, ...
                                     tirages_G_1,tirages_psi_1,tirages_G_2,tirages_psi_2)    
    
    residus_1 = y_donnees_bruitees - tirages_G_1(2,:) - tan(tirages_psi_1).*(x_donnees_bruitees-tirages_G_1(1,:));
    residus_2 = y_donnees_bruitees - tirages_G_2(2,:) - tan(tirages_psi_2).*(x_donnees_bruitees-tirages_G_2(1,:));
    somme = sum(log(exp(-residus_2.^2/(2*sigma^2)) + exp(-residus_1.^2/(2*sigma^2)) )); 
    [~,arg_max]=max(somme);

    psi_1 = tirages_psi_1(arg_max);
    psi_2 = tirages_psi_1(arg_max);
    G_1 = tirages_G_1(:,arg_max);
    G_2 = tirages_G_2(:,arg_max);

    a_Dyx_1 = tan(psi_1); 
    a_Dyx_2 = tan(psi_2);

    b_Dyx_1 = G_1(2) - a_Dyx_1*G_1(1);
    b_Dyx_2 = G_2(2) - a_Dyx_2*G_2(1);



end