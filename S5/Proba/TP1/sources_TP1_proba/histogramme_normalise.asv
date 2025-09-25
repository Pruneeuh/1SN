% Fonction histogramme_normalise (exercice_2.m)

function [vecteur_Imin_a_Imax,vecteur_frequences] = histogramme_normalise(I)
    Imin=min(I(:));
    Imax=max(I(:));
    vecteur_Imin_a_Imax=[Imin:1:Imax+1];
    vecteur_occ=histcounts(I,vecteur_Imin_a_Imax);
    vecteur_frequences=vecteur_occ/sum(vecteur_occ);
    vecteur_Imin_a_Imax=[Imin:1:Imax];

end