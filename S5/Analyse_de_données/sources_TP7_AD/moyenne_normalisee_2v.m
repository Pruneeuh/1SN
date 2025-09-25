% fonction moyenne_normalisee_2v (pour l'exercice 1)

function x = moyenne_normalisee_2v(I)

    R = I(:,:,1);
    V = I(:,:,2);
    B = I(:,:,3);
    [Nl,Nc,~]=size(I);

    Rv = R(:);
    Vv = V(:);
    Bv = B(:);
    
    xe = zeros(Nl*Nc,2);

    for i = 1:Nl*Nc 
        maxi = max([1; Rv(i)+Vv(i)+Bv(i)]);
        xe(i,:)=1/maxi*[Rv(i) Vv(i)];
        
    end

    Rm=mean(xe(:,1));
    Vm=mean(xe(:,2));
    x=[Rm;Vm];


end
