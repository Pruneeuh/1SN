% Fonction estim_param_Dyx_MC2 (exercice_2bis.m)

function [a_Dyx,b_Dyx,coeff_r2] = ...
                   estim_param_Dyx_MC2(x_donnees_bruitees,y_donnees_bruitees)

    varX = mean(x_donnees_bruitees.^2); 
    varY = mean(y_donnees_bruitees.^2); 
    cov = mean(x_donnees_bruitees .* y_donnees_bruitees); 

    r = cov / sqrt(varX*varY); 
    a_Dyx = r* sqrt(varY/varX); 
    b_Dyx = mean(y_donnees_bruitees) - a_Dyx*mean(x_donnees_bruitees);
    coeff_r2 = r^2; 
	

    
end