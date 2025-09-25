% Fonction vectorisation_par_colonne (exercice_1.m)

function [Vd,Vg] = vectorisation_par_colonne(I)
    Vd = I(:, 1:end-1);
    Vg = I(: , 2:end);
    Vd=Vd(:);
    Vg=Vg(:);
   
end