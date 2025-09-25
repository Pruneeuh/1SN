% fonction estim_param_vraisemblance (pour l'exercice 1)

function [mu,Sigma] = estim_param_vraisemblance(X)
    mu = mean(X);
    Sigma = (1/size(X,1))*((X-mu)'*(X-mu));

end