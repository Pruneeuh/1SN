% Fonction calcul_G_et_R_moyen (exercice_3.m)

function [G, R_moyen, distances] = ...
         calcul_G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)

    xG=mean(x_donnees_bruitees)
    yG=mean(y_donnees_bruitees)
    G=[xG, yG]
    vectxG=ones(size(x_donnees_bruitees))*xG
    vectyG=ones(size(y_donnees_bruitees))*yG
    distance= sqrt((x_donnees_bruitees-vectxG).^2 + (y_donnees_bruitees-vectyG).^2)
    R_moyen=mean(distance)

end