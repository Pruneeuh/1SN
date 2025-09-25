% fonction calcul_bon_partitionnement (pour l'exercice 1)

function meilleur_pourcentage_partitionnement = calcul_bon_partitionnement(Y_pred,Y)
    size(Y_pred)
    % créer le vecteur composé tt classes
    
    maxi=0;
    nb_classes=max(Y_pred);

    classes=zeros(1,nb_classes);
    for i=1:nb_classes
        classes(i)=i;
    end
    
    % créer matrice tt permutations
    permutations=perms(classes);
    
    %pour chaque permutation
    for i=1:size(permutations,1)

        % créer le Y_pred_permut avec la permutations i 
        Y_pred_permut=zeros(1,length(Y_pred));
        for j=1:length(Y_pred)
            Y_pred_permut(j)=permutations(i,Y_pred(j));
        end

        % calcul du nb de bon partitionnement
        dif = Y - Y_pred_permut;
     
        nb_ok=sum(dif==0);
        
        %maj du max
        if nb_ok > maxi
            maxi = nb_ok;
        end
        
    end
    %recupère le meilleur pourcentage
    meilleur_pourcentage_partitionnement = (maxi/length(Y_pred))*100;
        
    


end