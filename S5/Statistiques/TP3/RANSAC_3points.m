% Fonction RANSAC_3points (exercice_3)

function [C_estime,R_estime] = RANSAC_3points(x_donnees_bruitees,y_donnees_bruitees,parametres)

    % Parametres de l'algorithme RANSAC :
    S_ecart = parametres(1); % seuil pour l'ecart
    S_prop = parametres(2); % seuil pour la proportion
    k_max = parametres(3); % nombre d'iterations
    n_tirages = parametres(4); 
    n_donnees = size(x_donnees_bruitees,1);
    ecart_moyen_min = Inf;


   for k=1:k_max 
       idx=randperm(n_donnees,2);
       [G_3pts, R_moyen_3pts, distances] = calcul_G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);
       [tirages_C_3pts,tirages_R_3pts] = tirages_aleatoires_uniformes(n_tirages,G_3pts,R_moyen_3pts);
       [C_estime_3pts,R_estime_3pts,ecart_moyen_3pts] = estimation_C_et_R(x_donnees_bruitees(idx),y_donnees_bruitees(idx),tirages_C_3pts,tirages_R_3pts);
       
   end
end