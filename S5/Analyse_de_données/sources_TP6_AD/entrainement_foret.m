% fonction entrainement_foret (pour l'exercice 2)

function foret = entrainement_foret(X,Y,nb_arbres,proportion_individus)

    % Initialisation de la foret
    foret = cell(1,nb_arbres);       
    nb_donnes_par_arbres = round(proportion_individus*size(Y,1));
    nb_variables_to_sample = round(sqrt(nb_arbres));

    for i=1:nb_arbres 
        indices_generes_alleatoirement = randperm(size(Y,1)); 
        indices = indices_generes_alleatoirement(1:nb_donnes_par_arbres);

        Xi = X(indices,:);
        Yi = Y(indices);

        foret{i} = fitctree(Xi,Yi,'NumVariablesToSample',nb_variables_to_sample);
    end
end