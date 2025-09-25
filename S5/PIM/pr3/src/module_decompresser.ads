with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with LCA;

package module_decompresser is

   type T_ListeChainee is private;
   type T_Arbre is private; 
   subtype T_Octet_Str is Unbounded_String;  
   type T_Octet is mod 256;

   package LCA_Decompresser is new LCA(T_Cle => Character, T_Valeur=> T_Octet_Str);
   use LCA_Decompresser;

   -- Procédures associées au type T_ListeChainee : 

   --Initialiser une ListeChainee. La Listechainee est vide.
   procedure Initialiser (Liste : out T_ListeChainee) with
      Post => Longueur(Liste)=0;
   
   -- Quel est la longueur de la Liste Chainée (le nombre d'Arbre qu'elle contient)
   function Longueur (Liste : in T_ListeChainee) return Integer;

   -- Quel est l'élément suivant dans la listeChainee ?
   function Suivant (Liste : in T_ListeChainee) return T_ListeChainee with
      Pre => not Fin_Liste(Liste);

   -- Est ce qu'il y a un élément suivant dans ma listeChainee ?
   function Fin_Liste(Liste : in T_ListeChainee) return Boolean; 

   -- Quel est l'abre associé à la ListeChainée actuelle ?
   function LArbre(Liste : in T_ListeChainee) return T_Arbre with
      Pre => Longueur(Liste)>=1;

   -- Récupérer l'arbre en l'enregistrant dans une variable Arbre
   procedure Recuperer_LArbre(Arbre : out T_Arbre ; Liste : in T_ListeChainee) with 
      Pre => Longueur(Liste)>=1;


   -- Procédures associées au type T_Arbre : 

   -- Initialiser un arbre. L'arbre est vide
   procedure Initialiser_Arbre(Arbre : out T_Arbre); 

    -- Quel est le fils gauche de l'Arbre ?
   function Le_Fils_Gauche (Arbre : in T_Arbre) return T_Arbre;

   -- Quel est le fils droit de l'Arbre ? 
   function Le_Fils_Droit (Arbre : in T_Arbre) return T_Arbre;

   -- Enregistrer un Arbre avec son symbole, son code, son fils gauche et son fils_droit   
   procedure Enregistrer_Arbre (Arbre :in out T_Arbre; Symbole : in Character; Code : in T_Octet_Str; Fils_Gauche : in T_Arbre; Fils_Droit : in T_Arbre) with
      Post => Le_Fils_Gauche(Arbre)=Fils_Gauche and Le_Fils_Droit(Arbre)=Fils_Droit and Le_Code(Arbre)=Code and Le_Symbole(Arbre)=Symbole;

   -- Quel est le code associé à l'Arbre actuel ? 
   function Le_Code (Arbre : in T_Arbre) return T_Octet_Str; 

   -- Quel est le symbole associé à l'Arbre actuel ? 
   function Le_Symbole (Arbre : in T_Arbre) return Character; 

   -- Ajouter un arbre à la fin d'une ListeChainee
   procedure Ajouter_Liste (Liste : in out T_ListeChainee; Arbre : in T_Arbre) with
      Post => Longueur(Liste) = Longueur(Liste)'Old + 1; 

   
   -- Procédures associées à la liste des Symboles

   --Obtenir la longueur de la liste des Symbole décodés 
   function Longueur_ListeSymbole (Liste_Symbole : in Unbounded_String) return Integer;

   --Afficher les symboles décodés
   procedure Afficher_Caractere(Liste_Symbole : in Unbounded_String);

   --Recuperer le Symbole correspondant à une suite de bits 
   procedure Symbole_correspondant (Liste_bits : in Unbounded_String; ArbreHuffman : in out T_Arbre;symbole : out Character);

   


   -- Modifier le symbole associé à l'abre d'une liste
   procedure Modifier_Symbole (Arbre : in out T_Arbre; Symbole : in Character);

   -- créer un dictionnaire symbole code huffman à partir d'un arbre
   procedure Creer_Dict (Arbre : in T_Arbre; Dict : in out T_LCA); 
     
   function Fin_Arbre (Arbre : in T_Arbre) return Boolean;

   procedure Decodage(Texte_Code : in Unbounded_String; ArbreHuffman : in T_Arbre; Texte_Decode : out Unbounded_String);


   procedure Convertir_octet_bits(Octet : in out T_Octet;Suite_Bits : out Unbounded_String);

   procedure Changer_Symboles (Arbre : in out T_Arbre; Symboles_Utilises: in Unbounded_String; Position_Dollar : in Integer); 


   procedure reconstruire_Arbre (Arbre_Huffman : out T_Arbre; Bits_Parcours : in out Unbounded_String);

   procedure Afficher_Arbre(Arbre : in T_Arbre); 
   procedure Afficher_Symbole(Symbole : Character); 

private

      type T_Cellule1; 

      type T_Arbre is access T_Cellule1;

      type T_Cellule1 is record
            Symbole : Character;
            Code : T_Octet_Str;
            Fils_Gauche : T_Arbre;
            Fils_Droit : T_Arbre;
      end record;


      type T_Cellule2;

      type T_ListeChainee is access T_Cellule2 ;

      type T_Cellule2 is record
            Arbre : T_Arbre;
            Suivant : T_ListeChainee;
      end record;




end module_decompresser;
