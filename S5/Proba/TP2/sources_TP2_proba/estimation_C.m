% Fonction estimation_C (exercice_2.m)

function C_estime = estimation_C(x_donnees_bruitees,y_donnees_bruitees,tirages_C,R_moyen)
    
   n_donnees=size(x_donnees_bruitees,1);
   n_tirages=size(tirages_C,2); 
   ecarts_x=repmat(x_donnees_bruitees,1,n_tirages)-repmat(tirages_C(1,:),n_donnees,1);
   ecarts_y=repmat(y_donnees_bruitees,1,n_tirages)-repmat(tirages_C(2,:),n_donnees,1);
   distance=sqrt(ecarts_x.^2+ecarts_y.^2);
   residus=distance-R_moyen; 
   somme_carre_residus=sum(residus.^2);
   [~,indice_min]=min(somme_carre_residus);
   C_estime=tirages_C(:,indice_min);
end