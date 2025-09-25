% Fonction tirages_aleatoires (exercice_3.m)

function [tirages_C,tirages_R] = tirages_aleatoires_uniformes(n_tirages,G,R_moyen)
    
    tirages_C=(rand(2,n_tirages)-1/2)*2*R_moyen+G';
    tirages_R=rand(1,n_tirages)*R_moyen+1/2*R_moyen;

end