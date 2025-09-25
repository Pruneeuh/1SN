% function ACP (pour exercice_2.m)

function [C,bornes_C,coefficients_RVG2gris] = ACP(X)
    
    X = X - repmat(mean(X),size(X,1),1);
    XR = X(:,1);
    XV = X(:,2);
    XB = X(:,3);
    mR = mean(XR); 
    mV = mean(XV); 
    mB = mean(XB);
    VarR = mean(XR.^2) - mR^2; 
    VarV = mean(XV.^2) - mV^2; 
    VarB = mean(XB.^2) - mB^2; 
    CovRV = mean((XR-mR).*(XV-mV));
    CovRB = mean((XR-mR).*(XB-mB));
    CovBV = mean((XB-mB).*(XV-mV));
    sigma = [VarR, CovRV, CovRB ; 
             CovRV, VarV, CovBV; 
             CovRB, CovBV, VarB];

    [W,D]=eig(sigma);
    [Dsort,Indice]=sort(diag(D),'descend'); 
    
    W = [W(:,Indice(1)); W(:,Indice(2)); W(:,Indice(3))];

    C = (W*X')*W'; % changement de base ?????

    bornes_C =[min(min(C));max(max(C))];

    coefficients_RVG2gris = W(:,1)/norm(W(:,1)); 

end
