% Fonction reconstruction_image (exercice_3.m)

function I_reconstruite = reconstruction_image(I_encodee,dictionnaire,hauteur_I,largeur_I)

   I_decodee = huffmandeco(I_encodee,dictionnaire);
   I_reconstruite = reshape(I_decodee,hauteur_I,largeur_I);
end