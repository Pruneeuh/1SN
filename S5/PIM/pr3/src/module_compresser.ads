with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package module_compresser is

   type T_ListeChainee is private;
   type T_Arbre is private; 
   subtype T_Octet_Str is Unbounded_String;  
   type T_Octet is mod 256; for T_Octet'Size use 8;



   -- Procédures associées au type T_ListeChainee : 

   --Initialiser une ListeChainee. La Listechainee est vide.
   procedure Initialiser (Liste : out T_ListeChainee) with
      Post => Longueur(Liste)=0;

   -- Détruire une Listechainee. Elle ne doit plus être utilisée.
   procedure Supprimer_Liste (Liste : in out T_ListeChainee);

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

   -- Détruire une cellule donnée de la ListeChainee
   procedure Supprimer_Cellule(Liste : in out T_ListeChainee; Element_a_supprimer : in T_Listechainee ) with
      Pre => Longueur(Liste)>=1; 




   -- Procédures associées au type T_Arbre : 

   -- Détruire un arbre. Il ne devra plus être utilisé
   procedure Supprimer_Arbre (Arbre : in out T_Arbre); 

   -- Initialiser un arbre. L'arbre est vide
   procedure Initialiser_Arbre(Arbre : out T_Arbre); 


   -- Enregistrer un Arbre avec son symbole, sa fréquence, son code, son fils gauche et son fils_droit   
   procedure Enregistrer_Arbre (Arbre :in out T_Arbre; Symbole : in Character; Frequence : in Integer; Code : in T_Octet_Str; Fils_Gauche : in T_Arbre; Fils_Droit : in T_Arbre) with
      Post => Le_Fils_Gauche(Arbre)=Fils_Gauche and Le_Fils_Droit(Arbre)=Fils_Droit and Le_Code(Arbre)=Code and La_Frequence(Arbre)=Frequence and Le_Symbole(Arbre)=Symbole;

   -- Afficher un Arbre en donnant l'arboressecance avec ses fils.
   procedure Afficher_Arbre (Arbre : in T_Arbre);

   -- Quel est le fils gauche de l'Arbre ?
   function Le_Fils_Gauche (Arbre : in T_Arbre) return T_Arbre;

   -- Quel est le fils droit de l'Arbre ? 
   function Le_Fils_Droit (Arbre : in T_Arbre) return T_Arbre;

   -- Récupérer le Fils Gauche en l'enregistrant dans une variable Fils_Gauche
   procedure Recuperer_Fils_Gauche(Fils_Gauche : out T_Arbre ; Arbre : in T_Arbre) with
      Pre => not Fin_Arbre(Arbre),
      Post=> (Fils_Gauche=Le_Fils_Gauche(Arbre));
   
   -- Récupérer le Fils Gauche en l'enregistrant dans une variable Fils_Gauche
   procedure Recuperer_Fils_Droit(Fils_Droit : out T_Arbre ; Arbre : in T_Arbre) with
      Pre => not Fin_Arbre(Arbre),
      Post=> (Fils_Droit=Le_Fils_Droit(Arbre));

   -- Est ce que l'arbre possède des Fils ? 
   function Fin_Arbre (Arbre : in T_Arbre) return Boolean; 

   -- Est ce que l'arbre est vide ? 
   function Arbre_Vide (Arbre : in T_Arbre) return Boolean;

   -- Quel est le code associé à l'Arbre actuel ? 
   function Le_Code (Arbre : in T_Arbre) return T_Octet_Str; 

   -- Quel est le symbole associé à l'Arbre actuel ? 
   function Le_Symbole (Arbre : in T_Arbre) return Character; 

   -- Quel est la fréquence associée à l'Arbre actuel ? 
   function La_Frequence(Arbre : in T_Arbre) return Integer; 

   -- Modifier le code associé à l'abre actuel
   procedure Modifier_Code (Arbre : in out T_Arbre ; Code : in T_Octet_Str) with 
      Post => Le_Code(Arbre)=Code;

   -- Modifier la fréquence associée à l'abre actuel
   procedure Modifier_Frequence(Arbre : in out T_Arbre ; Frequence : in Integer) with  
      Post => La_Frequence(Arbre)=Frequence; 

   -- Ajouter un arbre à la fin d'une ListeChainee
   procedure Ajouter_Liste (Liste : in out T_ListeChainee; Arbre : in T_Arbre) with
      Post => Longueur(Liste) = Longueur(Liste)'Old + 1; 


 
   procedure Recuperer_Parcours_Arbre(Arbre : in T_Arbre ; Bits_Parcours : in out Unbounded_String);

   procedure Afficher_Symbole(Symbole : Character); 

-- pour pouvoir tester notre ficher décompresser (sans réuussir à reconstruire l'abre d'Huffman)
   procedure Decodage(Texte_Code : in Unbounded_String; ArbreHuffman : in T_Arbre; Texte_Decode : out Unbounded_String);



   private

      type T_Cellule1; 

      type T_Arbre is access T_Cellule1;

      type T_Cellule1 is record
            Symbole : Character;
            Frequence : Integer;
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


end module_compresser;
