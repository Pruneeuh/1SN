% Fonction RANSAC_2droites (exercice_2.m)

function [rho_F_estime,theta_F_estime] = RANSAC_2droites(rho,theta,parametres)

    % Parametres de l'algorithme RANSAC :
    S_ecart = parametres(1); % seuil pour l'ecart (entre données et modèle)
    S_prop = parametres(2); % seuil pour la proportion (conforme)
    k_max = parametres(3); % nombre d'iterations
    n_donnees = length(rho);
    ecart_moyen_min = Inf;
      

    %Estimation du point de fuite
    for k=1:k_max
        %Estimation à partir de 2 droites
        
       idx=randperm(n_donnees,2);   %2 entiers aléatoires entre 1 et données
       
       [rho_F_2droites,theta_F_2droites,~] = estim_param_F(rho(idx),theta(idx));
        
       % Détermination du nb de données conformes
       ecart = abs(rho - rho_F_2droites .*cos(theta - theta_F_2droites));
       conformes = (ecart <= S_ecart);
       
       % Test si le modèle est sélectionné
       if mean(conformes) >= S_prop

            % Estimation de F à partir des données conformes
            rho_conforme= rho(conformes);
            theta_conforme = theta(conformes);    
            [rho_F_conforme,theta_F_conforme,ecart_moyen] = estim_param_F(rho_conforme,theta_conforme);

            % Recupérer les paramètres si l'écart moyen est le plus petit
            if ecart_moyen_min > ecart_moyen 
                rho_F_estime = rho_F_conforme;
                theta_F_estime = theta_F_conforme;
            end

       end
    end

end