with Ada.Unchecked_Deallocation;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body module_compresser is 

   -- Procédures associées au type T_ListeChainee : 

   procedure Initialiser (Liste : out T_ListeChainee) is 
   begin 
      Liste := null; 
   end Initialiser; 


   procedure Free_Liste is new Ada.Unchecked_Deallocation (T_Cellule2, T_ListeChainee);

   procedure Supprimer_Liste (Liste : in out T_ListeChainee) is 
   begin 
      if Liste /= null then 
         Supprimer_Liste(Liste.all.Suivant); 
         Free_Liste(Liste); 
      else  
         null; 
      end if; 
   end Supprimer_Liste; 


   function Longueur (Liste : in T_ListeChainee) return Integer is
   begin 
      if Liste = null then 
         return 0; 
      else 
         return 1 +  Longueur(Liste.all.Suivant); 
      end if; 
   end Longueur; 


   function Suivant (Liste : in T_ListeChainee) return T_ListeChainee is 
   begin    
      return Liste.all.Suivant; 
   end Suivant; 


   function Fin_Liste(Liste : in T_ListeChainee) return Boolean is 
   begin   
      return Longueur(Liste) = 0; 
   end Fin_Liste;


   function LArbre(Liste : in T_ListeChainee) return T_Arbre is 
   begin 
      return Liste.all.Arbre; 
   end LArbre; 

   procedure Recuperer_LArbre(Arbre : out T_Arbre ; Liste : in T_ListeChainee) is 
   begin 
      Arbre := Liste.all.Arbre; 
   end Recuperer_LArbre;

   
   -- Procédures associées au type T_Arbre : 

   procedure Free_Arbre is new Ada.Unchecked_Deallocation (T_Cellule1, T_Arbre);

   procedure Supprimer_Arbre (Arbre : in out T_Arbre) is 
   begin 
      if Arbre /= null then 
         
         Supprimer_Arbre(Arbre.all.Fils_Gauche);    
         Supprimer_Arbre(Arbre.all.Fils_Droit); 
         Free_Arbre(Arbre); 
      else 
         null; 
      end if; 
   end Supprimer_Arbre;

   procedure Supprimer_Cellule(Liste : in out T_ListeChainee; Element_a_supprimer : in T_Listechainee ) is 
      Parcours : T_ListeChainee;
   begin 
      if Liste = Element_a_supprimer then 
         Liste := Liste.all.Suivant; 
      else 
         Parcours := Liste; 
         while Parcours.all.Suivant /=  Element_a_supprimer loop
            Parcours := Parcours.all.Suivant;
         end loop; 
         Parcours.all.Suivant := Element_a_supprimer.all.Suivant; 
      end if; 
   end Supprimer_Cellule; 

   procedure Enregistrer_Arbre (Arbre : in out T_Arbre; Symbole : in Character; Frequence : in Integer; Code : in T_Octet_Str; Fils_Gauche : in T_Arbre; Fils_Droit : in T_Arbre) is  
   begin
      Arbre := new T_Cellule1;
      Arbre.all.Symbole := Symbole; 
      Arbre.all.Frequence := Frequence; 
      Arbre.all.Code := Code; 
      Arbre.all.Fils_Gauche := Fils_Gauche; 
      Arbre.all.Fils_Droit := Fils_Droit; 
   end Enregistrer_Arbre; 


   function Le_Fils_Gauche (Arbre : in T_Arbre) return T_Arbre is 
   begin 
      return Arbre.all.Fils_Gauche; 
   end Le_Fils_Gauche; 

   procedure Recuperer_Fils_Gauche(Fils_Gauche : out T_Arbre ; Arbre : in T_Arbre) is 
   begin 
      Fils_Gauche := Arbre.all.Fils_Gauche; 
   end Recuperer_Fils_Gauche;


   function Le_Fils_Droit (Arbre : in T_Arbre) return T_Arbre is 
   begin 
      return Arbre.all.Fils_Droit; 
   end Le_Fils_Droit;
   

   procedure Recuperer_Fils_Droit(Fils_Droit : out T_Arbre ; Arbre : in T_Arbre) is 
   begin 
      Fils_Droit := Arbre.all.Fils_Droit; 
   end Recuperer_Fils_Droit;


   function Fin_Arbre (Arbre : in T_Arbre) return Boolean is 
   begin 
      return Arbre.all.Fils_Gauche = null and Arbre.all.Fils_Droit=null; 
   end Fin_Arbre;

   function Arbre_Vide (Arbre : in T_Arbre) return Boolean is 
   begin 
      return Arbre = null; 
   end Arbre_Vide;

   function Le_Code (Arbre : in T_Arbre) return T_Octet_Str is 
   begin 
      return Arbre.all.Code; 
   end Le_Code;


    function Le_Symbole (Arbre : in T_Arbre) return Character is 
   begin 
      return Arbre.all.Symbole; 
   end Le_Symbole; 


   function La_Frequence(Arbre : in T_Arbre) return Integer is 
   begin 
      return Arbre.all.Frequence; 
   end La_Frequence; 


   procedure Modifier_Code (Arbre : in out T_Arbre ; Code : in T_Octet_Str) is 
   begin 
      Arbre.all.Code := Code; 
   end Modifier_Code;


   procedure Modifier_Frequence (Arbre : in out T_Arbre ; Frequence : in Integer) is 
   begin 
      Arbre.all.Frequence := Frequence; 
   end Modifier_Frequence;

   
   procedure Ajouter_Liste(Liste : in out T_ListeChainee ; Arbre : in T_Arbre) is
      Parcours : T_ListeChainee; 
      Nouvelle_Cellule : T_ListeChainee;

   begin 
      Nouvelle_Cellule := new T_Cellule2; 
      Nouvelle_Cellule.all.Arbre := Arbre; 
      Nouvelle_Cellule.all.Suivant := null; 

      if Liste = null then
         Liste := Nouvelle_Cellule; 
      else
         Parcours := Liste; 
         while Parcours.all.Suivant /= null loop
            Parcours := Parcours.all.Suivant; 
         end loop; 
         Parcours.all.Suivant := Nouvelle_Cellule; 
      end if; 
   end Ajouter_Liste;  
   
   procedure Afficher_Arbre(Arbre : in T_Arbre) is
      procedure Afficher (SS_Arbre : in T_Arbre; c:in Integer; Nb_Espaces : in Integer) is
         Curseur : T_Arbre;
         FG : T_Arbre;
         FD: T_Arbre;         
      begin
         Curseur := SS_Arbre;
         if Curseur /= Null then
            FG := Curseur.all.Fils_Gauche;
            FD := Curseur.all.Fils_Droit;

            if Nb_Espaces > 0 then
               for i in 1..Nb_Espaces loop
                  Put("|       ");
               end loop;
            end if;
            Put("\--");
            Put(c,1);
            Put("--(");
            Put(Curseur.all.Frequence,1);
            Put(")");
            if Fin_Arbre(Curseur) then
               Afficher_Symbole(Curseur.all.Symbole);
            end if; 
            New_Line;

            if FG/=Null then
               if FG.all.Fils_Gauche=Null then

                  for i in 1..Nb_Espaces+1 loop
                     put("|       ");
                  end loop;
                  Put("\--0--(");
                  Put(FG.all.Frequence,1);
                  Put(")");
                  if Fin_Arbre(FG) then
                     Afficher_Symbole(FG.all.Symbole);
                  end if; 
                  New_Line;
         
               else 
                  Afficher(FG,0,Nb_Espaces+1);
               end if; 
               Afficher(FD,1,Nb_Espaces+1);
            end if;
              
         end if;
      end Afficher;
   begin
      Put("(");
      Put(Arbre.all.Frequence,1);
      Put(")");
      New_Line;
      Afficher(Arbre.all.Fils_Gauche,0,0);
      Afficher(Arbre.all.Fils_Droit,1,0);

   end Afficher_Arbre;

   

   procedure Recuperer_Parcours_Arbre(Arbre : in T_Arbre ; Bits_Parcours : in out Unbounded_String) is 
      FG : T_Arbre; 
      FD : T_Arbre; 

   begin 
      if Arbre /= null then
         FG := Arbre.all.Fils_Gauche; 
         FD := Arbre.all.Fils_Droit; 
         if  FG /= null then 
            Bits_Parcours := Bits_Parcours & '0';
            Recuperer_Parcours_Arbre(FG,Bits_Parcours);
         end if; 
         if FD /= null then 
            Bits_Parcours := Bits_Parcours & '1';
            Recuperer_Parcours_Arbre(FD,Bits_Parcours);
         end if; 
      end if;  
      
   end Recuperer_Parcours_Arbre; 

   procedure Initialiser_Arbre(Arbre : out T_Arbre) is 
   begin 
      Arbre := null; 
   end Initialiser_Arbre;

   procedure Afficher_Symbole(Symbole : Character) is 
   begin 
      if Character'Pos(Symbole) /= 10 and Symbole /= '$' then 
         Put("'");
         Put(Symbole);
         Put("'");
      elsif Character'Pos(Symbole) = 10 then
         Put("'\n'");
      elsif Symbole = '$' then 
         Put("'\$'");
      end if; 
end Afficher_Symbole; 

-- pour pouvoir tester notre ficher décompresser (sans réuussir à reconstruire l'abre d'Huffman)
procedure Decodage(Texte_Code : in Unbounded_String; ArbreHuffman : in T_Arbre; Texte_Decode : out Unbounded_String) is 
      curseur : T_Arbre; 
      indice : integer; 
      symbole : Character; 
   begin 
      Texte_Decode := To_Unbounded_String("");
      indice := 1; 
      symbole := 'b'; 
      while symbole /= '$' loop
         Put(symbole);
         New_Line;
         curseur := ArbreHuffman; 
         while not Fin_Arbre(curseur) loop
            if To_String(Texte_Code)(indice) = '0' then 
               curseur := curseur.all.Fils_Gauche; 
            else 
               curseur := curseur.all.Fils_Droit; 
            end if; 
            indice := indice + 1; 
         end loop; 
         symbole := curseur.all.Symbole; 
         Texte_Decode := Texte_Decode & symbole;
         -- faudra faire attention au saut de ligne pour l'ériture fichier 

      end loop; 
   end Decodage;


end module_compresser; 
