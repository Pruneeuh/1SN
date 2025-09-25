with LCA;

-- Définition de structures de données associatives à l'aide d'une table de hachage (TH)

generic
    Capacite : Integer; -- longueur du tableau
    type T_Cle_TH is private;
    type T_Valeur_TH is private;
    with function Hachage(Cle:T_Cle_TH) return Integer; -- Fonction qui retourne la case du tabelau dans lequel on placera la Clé

package TH is

    package LCA_TH is new LCA(T_Cle => T_Cle_TH, T_Valeur=> T_Valeur_TH);

    type T_TH is limited private;

	-- Initialiser une Sda.  La Sda est vide.
    procedure Initialiser_TH(Sda : out T_TH) with
            Post => Est_Vide_TH (Sda);

    	-- Détruire une Sda.  Elle ne devra plus être utilisée.
    procedure Detruire_TH(Sda : in out T_TH);

    -- La Sda est-elle vide ?
    function Est_vide_TH(Sda : in T_TH) return Boolean;

    	-- Obtenir le nombre d'éléments d'une Sda.
    function Taille_TH(Sda: in T_TH) return Integer with
            Post => Taille_TH'Result >= 0
			and (Taille_TH'Result = 0) = Est_Vide_TH (Sda);

    -- Enregistrer une valeur associée à une Clé dans une Sda.
	-- Si la clé est déjà présente dans la Sda, sa valeur est changée
    procedure Enregistrer_TH(Sda: in out T_TH; Cle: in T_Cle_TH; Valeur : in T_Valeur_TH) with
            Post => Cle_Presente_TH (Sda, Cle) and (La_Valeur_TH(Sda, Cle) = Valeur)   -- valeur insérée
				and (not (Cle_Presente_TH (Sda, Cle)'Old) or Taille_TH (Sda) = Taille_TH (Sda)'Old)
				and (Cle_Presente_TH (Sda, Cle)'Old or Taille_TH (Sda) = Taille_TH (Sda)'Old + 1);

    -- Supprimer la valeur associée à une Clé dans une Sda.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans la Sda
    procedure Supprimer_TH(Sda : in out T_TH; Cle: in T_Cle_TH) with
            Post =>  Taille_TH (Sda) = Taille_TH (Sda)'Old - 1 -- un élément de moins
			and not Cle_Presente_TH (Sda, Cle);         -- la clé a été supprimée

    	-- Savoir si une Clé est présente dans une Sda.
    function Cle_presente_TH(Sda : in T_TH;Cle : in T_Cle_TH) return Boolean;

    -- Obtenir la valeur associée à une Cle dans la Sda.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans l'Sda
    function La_Valeur_TH(Sda: in T_TH; Cle : in T_Cle_TH) return T_Valeur_TH;

    -- Afficher la Sda en révélant sa structure interne.

    generic
         with procedure Afficher_Cle_TH (Cle : in T_Cle_TH);
		with procedure Afficher_Donnee_TH (Valeur : in T_Valeur_TH);
    procedure Afficher_TH (Sda : in T_TH);

    	-- Appliquer un traitement (Traiter) pour chaque couple d'une Sda.
	generic
		with procedure Traiter_TH (Cle : in T_Cle_TH; Valeur: in T_Valeur_TH);
	procedure Pour_Chaque_TH (Sda : in T_TH);

private

    type T_TH is array (0..Capacite-1) of LCA_TH.T_LCA;


end TH;

