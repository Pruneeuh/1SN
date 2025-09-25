
-- Définition de structures de données associatives sous forme d'une liste
-- chaînée associative (LCA).
generic
	type T_Cle is private;
   type T_Valeur is private;
   
package LCA is

	type T_LCA is private;

	-- Initialiser une Sda.  La Sda est vide.
	procedure Initialiser(Sda: out T_LCA) with
		Post => Est_Vide (Sda);


	-- Détruire une Sda.  Elle ne devra plus être utilisée.
	procedure Detruire (Sda : in out T_LCA);


	-- Est-ce qu'une Sda est vide ?
	function Est_Vide (Sda : in T_LCA) return Boolean;

   function Taille (Sda : in T_LCA) return Integer;

	-- Enregistrer une valeur associée à une Clé dans une Sda.
	-- Si la clé est déjà présente dans la Sda, sa valeur est changée.
	procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Valeur : in T_Valeur) with
		Post => Cle_Presente (Sda, Cle) and (La_Valeur (Sda, Cle) = Valeur)   -- valeur insérée
				and (not (Cle_Presente (Sda, Cle)'Old) or Taille (Sda) = Taille (Sda)'Old)
				and (Cle_Presente (Sda, Cle)'Old or Taille (Sda) = Taille (Sda)'Old + 1);

	
   function Cle_Presente (sda : in T_LCA ; Cle : in T_Cle) return Boolean; 

	function La_Valeur (Sda : in T_LCA ; Cle : in T_Cle) return T_Valeur;

   procedure Concatener(Sda1 : in out T_LCA ; Sda2 : in T_LCA); 


	-- Appliquer un traitement (Traiter) pour chaque couple d'une Sda.
	generic
		with procedure Traiter (Cle : in T_Cle; Valeur: in T_Valeur);
	procedure Pour_Chaque (Sda : in T_LCA);


	-- Afficher la Sda en révélant sa structure interne.
	-- Voici un exemple d'affichage.
	-- -->["un" : 1]-->["deux" : 2]-->["trois" : 3]-->["quatre" : 4]--E
	generic
		with procedure Afficher_Cle (Cle : in T_Cle);
		with procedure Afficher_Donnee (Valeur : in T_Valeur);
	procedure Afficher_Debug (Sda : in T_LCA);

   -- Quel est la clé associé au parcours du dictionnaire 
   function Cle_Actuelle(Sda : in T_LCA) return T_Cle; 

   -- Quel est la cellule suivante dans le dictionnaire ? 
   function Suivant(Sda: in T_LCA) return T_LCA; 

private
   type T_Cellule; 
    
   type T_LCA is access T_Cellule;
    
   type T_Cellule is 
      record 
         Cle : T_Cle; 
         Valeur : T_Valeur; 
         Suivant : T_LCA; 
      end record; 
end LCA;