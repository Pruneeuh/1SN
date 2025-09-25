%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% cgs.m
%--------------------------------------------------------------------------

function Q = cgs(A)

    % Recuperation du nombre de colonnes de A
    [~, m] = size(A);
    
    % Initialisation de la matrice Q avec la matrice A
    Q = A;
    for p=1:m 
        z = zeros(m,1); 
        Vp = A(:,p);
        for i=1:p-1
            Ui = Q(:,i);
            z = z + dot(Vp,Ui)/(norm(Ui)^2) * Ui;
        end 
        Up = Vp - z;
        Up = Up/norm(Up);
        Q(:,p)=Up; 
    end 
    %------------------------------------------------
    % A remplir
    % Algorithme de Gram-Schmidt classique
    %------------------------------------------------

end