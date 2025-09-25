% fonction estim_param_SVM_noyau (pour l'exercice 3)

function [X_VS,Y_VS,Alpha_VS,c,code_retour] = estim_param_SVM_noyau(X,Y,sigma)
    K= calcul_noyau (X,X,sigma); 
    H = Y*Y'*K;
    size(H)
    f = ones(length(X),1); 
    Aeq = Y'; 
    beq = 0; 
    [alpha,~,code_retour,~]= quadprog(H, -f, [],[], Aeq,beq,[],[]);
    indicealpha = find(alpha > 10^(-6)); 
    X_VS = X(indicealpha); 
    Y_VS = Y(indicealpha);
    Alpha_VS = alpha(indicealpha,:); 
    K_VS = calcul_noyau(X_VS,X_VS(1,:),sigma);
    
    c = sum((Alpha_VS*Y_VS')*K_VS' - 1./Y_VS)

end
