% Fonction parametres_correlation (exercice_1.m)

function [r,a,b] = parametres_correlation(Vd,Vg)
    V_moyenne_Vg=ones(70864,1)*mean(Vg);
    variance_Vg=mean(Vg.^2-V_moyenne_Vg.^2);
    sigma_Vg=sqrt(variance_Vg);

    V_moyenne_Vd=ones(70864,1)*mean(Vd);
    variance_Vd=mean(Vd.^2-V_moyenne_Vd.^2);
    sigma_Vd=sqrt(variance_Vd);

    cov=mean(Vg.*Vd-V_moyenne_Vg.*V_moyenne_Vd);
    r=cov/(sigma_Vd*sigma_Vg);

    a=cov/sigma_Vd^2;
    b=mean(Vg)-(cov/sigma_Vd^2)*mean(Vd);
end