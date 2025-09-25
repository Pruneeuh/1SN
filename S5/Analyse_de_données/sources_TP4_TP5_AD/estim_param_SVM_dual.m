% fonction estim_param_SVM_dual (pour l'exercice 1)

function [X_VS,w,c,code_retour] = estim_param_SVM_dual(X,Y)
    H = diag(Y)*(X*X')*diag(Y);
    size(H);
    f = ones(length(Y),1);
    size(f);
    Aeq = Y';
    beq = 0 ; 
    [alpha,~,code_retour,~]= quadprog(H, -f, [],[], Aeq,beq,[],[]);
    
    indicealpha = find(alpha > 1e-6); 


    X_VS = X(indicealpha,:); 
    Y_VS = Y(indicealpha,:);
    alpha_VS = alpha(indicealpha,:);

    w = X_VS*diag(Y_VS)*alpha_VS; 

    c = w'*X_VS(1,:) - Y_VS(1); 

end
