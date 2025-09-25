% Fonction estim_param_F (exercice_1.m)

function [rho_F,theta_F,ecart_moyen] = estim_param_F(rho,theta)
    
    A = [cos(theta) sin(theta)];
    B = rho;

    X = A \ B;       %matrice pseudo inverse
    
    xF = X(1);
    yF = X(2);

    rho_F = sqrt(xF^2 + yF^2);
    theta_F = atan2(yF,xF);

    ecart_moyen = mean(abs(A*X - B));
    
end