with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;


package body module_decompresser is 

   -- Procédures associées au type T_ListeChainee : 

   procedure Initialiser (Liste : out T_ListeChainee) is 
   begin 
      Liste := null; 
   end Initialiser; 


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
    function Le_Fils_Gauche (Arbre : in T_Arbre) return T_Arbre is 
   begin 
      return Arbre.all.Fils_Gauche; 
   end Le_Fils_Gauche; 

   function Le_Fils_Droit (Arbre : in T_Arbre) return T_Arbre is 
   begin 
      return Arbre.all.Fils_Droit; 
   end Le_Fils_Droit;

   procedure Enregistrer_Arbre (Arbre : in out T_Arbre; Symbole : in Character; Code : in T_Octet_Str; Fils_Gauche : in T_Arbre; Fils_Droit : in T_Arbre) is  
   begin
      Arbre := new T_Cellule1;
      Arbre.all.Symbole := Symbole;  
      Arbre.all.Code := Code; 
      Arbre.all.Fils_Gauche := Fils_Gauche; 
      Arbre.all.Fils_Droit := Fils_Droit; 
   end Enregistrer_Arbre; 

   function Le_Code (Arbre : in T_Arbre) return T_Octet_Str is 
   begin 
      return Arbre.all.Code; 
   end Le_Code;

   procedure Initialiser_Arbre(Arbre : out T_Arbre) is 
   begin 
      Arbre := null; 
   end Initialiser_Arbre;


   function Le_Symbole (Arbre : in T_Arbre) return Character is 
   begin 
      return Arbre.all.Symbole; 
   end Le_Symbole; 

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

   -- Procédures associées à la liste des Symboles 

   function Longueur_ListeSymbole (Liste_Symbole : in Unbounded_String) return Integer is 
   begin 
      return Length(Liste_Symbole);
   end Longueur_ListeSymbole;

   

   procedure Afficher_Caractere(Liste_Symbole : in Unbounded_String) is 
   begin 
      for i in 1..Longueur_ListeSymbole(Liste_Symbole) loop 
         if To_String(Liste_Symbole)(i) = 'n' then 
            New_Line;
         else
            Put(To_String(Liste_Symbole)(i));
         end if; 
      end loop;
   end Afficher_Caractere; 

   procedure Symbole_correspondant (Liste_bits : in Unbounded_String; ArbreHuffman : in out T_Arbre; Symbole : out Character) is 
      curseur : T_Arbre;
   begin
      curseur := ArbreHuffman; 
      for i in 1..Longueur_ListeSymbole(Liste_bits) loop 
         if To_String(Liste_bits)(i)='1' then 
            curseur := curseur.all.Fils_Droit;
         else 
            curseur := curseur.all.Fils_Gauche;
         end if;  
      end loop;
      Symbole := Le_Symbole(curseur);
   end Symbole_correspondant; 

   
   

   procedure Modifier_Symbole (Arbre : in out T_Arbre; Symbole : in Character) is 
   begin 
      Arbre.all.Symbole := Symbole; 
   end Modifier_Symbole;



   procedure reconstruire_Arbre (Arbre_Huffman : out T_Arbre; Bits_Parcours : in out Unbounded_String) is 

      procedure Reconstuire(Racine : in T_Arbre; Arbre : in out T_Arbre ; Bits_Parcours : in  out Unbounded_String ; Indice : in Integer ; Fin : in out Boolean) is 
         
         procedure Trouver_sans_fils_droit(Arbre : in T_Arbre ; Sans_FD : out T_Arbre ; Trouve : in out Boolean) is
            Curseur : T_Arbre;
         begin 
            Initialiser_Arbre(Sans_FD);
            Curseur := Arbre;
            if Curseur /= null then   
               if Curseur.all.Fils_Gauche /= null then
                  Trouver_sans_fils_droit (Curseur.all.Fils_Gauche, Sans_FD, Trouve);
                  if not Trouve then
                     if Curseur.all.Fils_Droit = null then
                        Sans_FD := Curseur; 
                        Trouve := True;
                     else
                        Trouver_sans_fils_droit (Curseur.all.Fils_Droit, Sans_FD, Trouve); 
                     end if; 
                  end if; 
               end if;
            end if;
         end Trouver_sans_fils_droit; 
         
         Bit_Actuel : constant Character := To_String(Bits_Parcours)(Indice);
         Bit_Suivant : constant Character :=  To_String(Bits_Parcours)(Indice + 1);
         Code : Unbounded_String := To_Unbounded_String ("");
         Arbre_null : T_Arbre; 
         Trouve : Boolean; 
         Sans_FD : T_Arbre ;

         FG : T_Arbre; 
         FD : T_Arbre; 

      begin 
         Initialiser_Arbre(Arbre_null);

         
         Code := Code & Bit_Actuel;

         if not Fin then 
            
            if Bit_Actuel = '0' then 
               Enregistrer_Arbre (FG, '?', Code, Arbre_null, Arbre_null);
               Arbre.all.Fils_Gauche := FG; 
               if Bit_Suivant = '0' then 
                  Reconstuire (Racine, Arbre.all.Fils_Gauche, Bits_Parcours, Indice+1,Fin);
               else 
                  Reconstuire (Racine, Arbre, Bits_Parcours, Indice+1,Fin);
               end if; 

            else -- bit_actuel = '1'
               Trouve := False; 
               Trouver_sans_fils_droit (Racine, Sans_FD,Trouve);
               if not Trouve then 
                 
                  Fin := True;
                  Bits_Parcours := To_Unbounded_String(To_String(Bits_Parcours)(indice+1..Length(Bits_Parcours)));
               else 
                 
                  Enregistrer_Arbre (FD,'?',Code, Arbre_null, Arbre_null); 
                  Sans_FD.all.Fils_Droit := FD; 
                  -- trouver nouveau sans fils droit 
                  Reconstuire (Racine, Sans_FD.all.Fils_Droit, Bits_Parcours, Indice + 1,Fin); 
               end if; 
            end if;
         end if; 
      end Reconstuire;


      Arbre_null : T_Arbre; 
      Fin : Boolean; 
      Premier_bit : Unbounded_String := To_Unbounded_String ("");
      
   begin 
      Initialiser_Arbre(Arbre_null);
      Initialiser_Arbre(Arbre_Huffman); 

      Premier_bit := Premier_bit & '0';

      

      Enregistrer_Arbre(Arbre_Huffman,'R', Premier_bit,Arbre_null, Arbre_null); 
      Fin := False;
      Reconstuire (Arbre_Huffman,Arbre_Huffman, Bits_Parcours , 1, Fin); 


   end reconstruire_Arbre;


   

   function Fin_Arbre (Arbre : in T_Arbre) return Boolean is 
   begin 
      return Arbre.all.Fils_Gauche = null and Arbre.all.Fils_Droit=null; 
   end Fin_Arbre;

     -- Procédure pour créer le dictionnaire de codage : 
   procedure Creer_Dict (Arbre : in T_Arbre; Dict : in out T_LCA) is 
      DictFG : T_LCA;   -- Dictionnaire associé au fils gauche
      DictFD : T_LCA;   -- Dictionnaire associé au fils droit

   begin
      -- Enregistrer le code associé au symbole de la fin de l'arbre 
      if Fin_Arbre(Arbre) then 
         Enregistrer(Dict,Le_Symbole(Arbre),Le_Code(Arbre));
      
      -- regrouper les dictionnaires associés au fils gauche et fils droit
      else 
         Creer_Dict(Le_Fils_Gauche(Arbre),DictFG);
         Creer_Dict(Le_Fils_Droit(Arbre), DictFD);
         Concatener(DictFG,DictFD);
         Dict := DictFG; 
      end if; 
   end Creer_Dict; 

   procedure Decodage(Texte_Code : in Unbounded_String; ArbreHuffman : in T_Arbre; Texte_Decode : out Unbounded_String) is 
      curseur : T_Arbre; 
      indice : integer; 
      symbole : Character; 
   begin 
      Texte_Decode := To_Unbounded_String("");
      indice := 1; 
      symbole := 'b'; 
      while symbole /= '$' loop
        
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

   procedure Convertir_octet_bits(Octet : in out T_Octet;Suite_Bits : out Unbounded_String)  is
      
      Bit : T_Octet; 
   begin 
      Suite_Bits:= To_Unbounded_String ("");

      for i in 1..8 loop 
         Bit := Octet / 128;
         Suite_Bits := Suite_Bits & Character'Val(Integer(Bit)+48);
         Octet := Octet*2; 
      end loop; 
       
   end Convertir_octet_bits;

   procedure Changer_Symboles (Arbre : in out T_Arbre; Symboles_Utilises: in Unbounded_String; Position_Dollar : in Integer) is 
      indice : integer := 1; 
      procedure Symbole_Feuille(ss_Arbre : in T_Arbre; Symboles_Utilises: in Unbounded_String; indice : in out integer; Position_Dollar :in Integer) is 
         Curseur : T_Arbre;
         FG : T_Arbre;
         FD : T_Arbre;
         ind : Integer;
      begin 
         Curseur := ss_Arbre; 
         if Curseur /=null then 
            FG := Curseur.all.Fils_Gauche;
            FD := Curseur.all.Fils_Droit;
            if Fin_Arbre(Curseur) then 
              
      
               ind := indice;
              
               
               if indice > Position_Dollar +1 then
                  ind := ind - 1;
               end if;
             
               if indice = Position_Dollar+1 then --
                  Modifier_Symbole (Curseur, '$');
               else
                  Modifier_Symbole (Curseur, To_String(Symboles_Utilises)(ind));
               end if; 
               indice := indice + 1;
               
                
            else
               Symbole_Feuille (FG,Symboles_Utilises, indice,Position_Dollar);
               Symbole_Feuille (FD, Symboles_Utilises, indice,Position_Dollar);
            end if;
         end if; 
      end Symbole_Feuille;
   begin

      Symbole_Feuille (Arbre, Symboles_Utilises, indice,Position_Dollar);
   end Changer_Symboles;

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
            
            if Fin_Arbre(Curseur) then
               Afficher_Symbole(Curseur.all.Symbole);
            end if; 
            New_Line;

            if FG/=Null then
               if FG.all.Fils_Gauche=Null then

                  for i in 1..Nb_Espaces+1 loop
                     put("|       ");
                  end loop;
                  Put("\--0--");
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
      New_Line;
      Afficher(Arbre.all.Fils_Gauche,0,0);
      Afficher(Arbre.all.Fils_Droit,1,0);

   end Afficher_Arbre;
      

end module_decompresser; 
