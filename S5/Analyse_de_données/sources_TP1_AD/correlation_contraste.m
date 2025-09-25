% function correlation_contraste (pour exercice_1.m)

function [correlation,contraste] = correlation_contraste(X)
    X = X - repmat(mean(X),size(X,1),1);
    XR = X(:,1);
    XV = X(:,2);
    XB = X(:,3);
    mR = mean(XR); 
    mV = mean(XV); 
    mB = mean(XB);
    VarR = me(XR.^2) - mR^2; 
    VarV = mean(XV.^2) - mV^2; 
    VarB = mean(XB.^2) - mB^2; 
    CovRV = mean((XR-mR).*(XV-mV));
    CovRB = mean((XR-mR).*(XB-mB));
    CovBV = mean((XB-mB).*(XV-mV));
    sigma = [VarR, CovRV, CovRB ; 
             CovRV, VarV, CovBV; 
             CovRB, CovBV, VarB];
    correlation = [ 1 , CovRV/sqrt(VarR*VarV) , CovRB/sqrt(VarR*VarB);  
                  CovRV/sqrt(VarR*VarV) , 1  ,  CovBV/sqrt(VarV*VarB); 
                  CovRB/sqrt(VarR*VarB) , CovBV/sqrt(VarV*VarB) , 1  ]; 
    
    contraste = [ VarR, VarV, VarB]/ (VarR+VarB+VarV); 

end


