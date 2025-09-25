% Fonction ensemble_E_recursif (exercie_1.m)

function [E,contour,G_somme] = ensemble_E_recursif(E,contour,G_somme,i,j,...
                                                   voisins,G_x,G_y,card_max,cos_alpha)

    % Mise à 0 de la valeur contour du pixel courant pour ne pas retourner dessus
    contour(i,j) = 0;
    % Nombre de voisins (ici 8)
    nb_voisins = size(voisins,1);
    % Initialisation du comptage des 8 voisins a parcourir
    k = 1;
    while ((k<=nb_voisins) && (size(E,1)<=card_max))
        voisin=[i,j]+voisins(k,:);
        if contour(voisin(1),voisin(2))==1 
            normeG=norm([G_x(voisin) G_y(voisin)]);
            norme_somme=norm(G_somme);
            if (dot([G_x(voisin),G_y(voisin)],G_somme))/(normeG*norme_somme)>= cos_alpha
                E=[E;voisin];
                G_somme=G_somme+[G_x(voisin);G_y(voisin)];
                [E,contour,G_somme] = ensemble_E_recursif(E,contour,G_somme,voisin(1),voisin(2),voisins,G_x,G_y,card_max,cos_alpha);
            end
        end
        k=k+1;
    end


   
    

    
end