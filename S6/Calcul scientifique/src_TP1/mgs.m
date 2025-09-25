%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% mgs.m
%--------------------------------------------------------------------------

function Q = mgs(A)

    % Recuperation du nombre de colonnes de A
    [~, m] = size(A);
    
    % Initialisation de la matrice Q avec la matrice A
    Q = A;
    for p=1:m 
        y = A(:,p);
        for i=1:p-1
            Ui = Q(:,i);
            y = y - dot(y,Ui)/(norm(Ui)^2) * Ui;
        end 
        y = y/norm(y);
        Q(:,p)=y; 
    end 
    %------------------------------------------------
    % A remplir
    % Algorithme de Gram-Schmidt modifie
    %------------------------------------------------

end