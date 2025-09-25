with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_IO; use Ada.Text_IO;

with module_compresser; use module_compresser; 
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with LCA; 

procedure Compresser is
   

   Octet_symbole : T_Octet; --variable pour stocker les octets du fichier d'origine 


   Arbre_null : T_Arbre; -- arbre intialiser à null
   
   Bits_Parcours_Infixe : Unbounded_String; 

   

   -- Variable pour lecture du fichier
   Option : Unbounded_String; 
   Nom_Fichier : Unbounded_String; 


   -- Variables pour le calcul des fréquences
   Liste_Frequence : T_ListeChainee;
   Curseur : T_ListeChainee;
   Fichier : Ada.Streams.Stream_IO.File_Type; 
   Symbole : Character; 
   Arbre : T_Arbre; 
   Arbre_recup : T_Arbre;     -- variable de stockage de l'abre


   -- Variables pour la recherche des fréquences minimum 
   L_Arbre1 : T_ListeChainee; 
   L_Arbre2 : T_ListeChainee; 

   min1 : Integer; 
   min2 : Integer; 

   StockageMin : Integer; 
   StockageL_Arbre : T_ListeChainee;

   Arbre_Actuel : T_Arbre; 



   

   -- Variable pour la création de l'Arbre d'Huffman
   NouvelArbre : T_Arbre; 
   ArbreHuffman : T_Arbre; 

   -- Variable pour la création du dictionnaire de codage : 
   package LCA_Compresser is new LCA(T_Cle => Character, T_Valeur=> T_Octet_Str);
   use LCA_Compresser;

   Dict_Codage : T_LCA; 

   -- Variables pour l'écriture du fichier compresser 
   S : Stream_Access;
   Texte_Code : Unbounded_String; 
   
   -- Procedure pour récupérer le codage d'huffamn
   procedure Code(Arbre : in out T_Arbre; Code_v : in T_Octet_Str;  Bits_Parcours_Infixe : in Unbounded_String) is 
      FG : T_Arbre; 
      FD : T_Arbre; 
   begin 
      -- Remplir le code de la fin de l'abre d'Huffman
      if Fin_Arbre(Arbre) then 
         Modifier_Code(Arbre,Code_v);
      else 
         -- Récupérer les fils pour pouvoir les modifier
         Recuperer_Fils_Gauche(FG , Arbre); 
         Recuperer_Fils_Droit(FD , Arbre); 

         -- Coder les fils 
         Code(FG ,Code_v& To_Unbounded_String("0") , Bits_Parcours_Infixe & To_Unbounded_String("0"));
         Code(FD, Code_v & To_Unbounded_String("1"), Bits_Parcours_Infixe & To_Unbounded_String("1"));         
      end if; 
   end Code; 



   
   
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

   
   -- Afficher un couple Symbole - Code du dictionnaire
   procedure Afficher_Couple (Cle : Character; Valeur : T_Octet_Str) is 
   begin 
         Afficher_Symbole(Cle);
         Put (" --> "); 
         Put (To_String(Valeur)); 
         New_Line; 
   end Afficher_Couple; 

   procedure Afficher_Dict is new Pour_Chaque(Afficher_Couple);  



   -- Ecrire le fichier.hff
   procedure Ecrire_Fichier(Nom_Fichier : in Unbounded_String; Dict_Codage : in T_LCA ; Bits_Parcours_Infixe : in Unbounded_String; Texte_Code : in Unbounded_String) is 

      Nom_Fichier_Code : constant String := To_String(Nom_Fichier) & ".hff";
      File : Ada.Streams.Stream_IO.File_Type;	
      S2 :  Stream_Access ;
	        
      -- Fonction qui à une suite de 8 bits retourne sa valeur en octet     
      function Conversion_Octet(Octet_Str : in T_Octet_Str) return T_Octet is 
         Octet : T_Octet;  
      begin 
         Octet := 0; 
         for poids in 1..8 loop
            Octet := (Octet * 2) or (Character'Pos(To_String(Octet_Str)(poids)) - Character'Pos('0')); 
         end loop;
         return Octet;
      end Conversion_Octet;

      
      -- Ajouter au fichier .hff la liste de caractères utilisés
      procedure Ajouter_Liste_Caracteres (Dict_Codage : in T_LCA ;  S : in Stream_Access) is 
         Avancee_Dict : T_LCA;   -- variable de parcours du dictionnaire
         Cle : Character;        
         Position : Integer;     -- position du caractère de fin de fichier

      begin 
         -- Enregistrer la postion du caractère de fin
         Avancee_Dict := Dict_Codage;
         Position := 0; 

         -- Parcourir le dictionnaire de codage pour récupérer position du caractère de fin
         while not Est_vide(Avancee_Dict) loop 
            Cle := Cle_Actuelle(Avancee_Dict); 
            if Cle /= '$' then 
               Position := Position + 1 ; 
            else 
               T_Octet'Write(S,T_Octet(Position));
            end if; 
            Avancee_Dict := Suivant(Avancee_Dict);
         end loop; 

         -- Enregistrer le reste des caractères 
         Avancee_Dict := Dict_Codage; 
         while not Est_Vide(Avancee_Dict) loop 
            Cle := Cle_Actuelle(Avancee_Dict); 
            if Cle /= '$' then
               T_Octet'Write(S,T_Octet(Character'Pos(Cle))); 
            else 
               null; 
            end if; 
            Avancee_Dict := Suivant(Avancee_Dict);
         end loop; 
         T_Octet'Write(S,T_Octet(Character'Pos(Cle))); 

      end Ajouter_Liste_Caracteres;


      -- Ajouter au fichier .hff le parcours infixe de l'arbre et le texte codé
      procedure Ajouter_Parcours_Et_Texte_Code(Bits_Parcours_Infixe : in Unbounded_String ; Texte_Code : in Unbounded_String; S : in Stream_Access) is
         Nb_Bits_Enregistrer : Integer; 
         Indice_curseur : Integer; 
         A_Enregistrer : Unbounded_String;
         Nb_Zeros_Ajouter : Integer;
         Liste_Zeros : Unbounded_String; 
      begin 
         
         A_Enregistrer := Bits_Parcours_Infixe & '1' & Texte_Code; 

         Nb_Bits_Enregistrer := Length(A_Enregistrer); 

        -- Déterminer les zéros à ajouter pour remplir le fichier d'octet
         Nb_Zeros_Ajouter := 8 - Nb_Bits_Enregistrer mod 8;
         Liste_Zeros := To_Unbounded_String(""); 
         for k in 1..Nb_Zeros_Ajouter loop
            Liste_Zeros := Liste_Zeros & To_Unbounded_String("0"); 
         end loop; 

         -- Créer la liste des bits à enregister dans le fichier
         A_Enregistrer := A_Enregistrer & Liste_Zeros;
         Nb_Bits_Enregistrer := Length(A_Enregistrer); 

         Indice_curseur := 1; 
         -- Parcourir la liste des bits et ajouter au fichier les octets
         while Indice_curseur <= Nb_Bits_Enregistrer loop  
            T_Octet'Write(S,Conversion_Octet(To_Unbounded_String(To_String(A_Enregistrer)(Indice_curseur..Indice_curseur+7)))); 
            Indice_Curseur := Indice_Curseur + 8; 
         end loop; 
      end Ajouter_Parcours_Et_Texte_Code;

   begin 

      -- Créer le fichier.hff
      Create(File, Out_File, Nom_Fichier_Code); 
      S2 := Stream(File);

      Ajouter_Liste_Caracteres(Dict_Codage,S2);      
      Ajouter_Parcours_Et_Texte_Code(Bits_Parcours_Infixe,Texte_Code,S2);
      Close(File); 
      
   end Ecrire_Fichier; 

begin
   --Initialiser un arbre null 
   Initialiser_Arbre(Arbre_null); 

   -- Récupérer le fichier 
   Nom_Fichier := To_Unbounded_String(Argument(Argument_Count)); 

   -- Récupérer l'option 
   if Argument_Count = 2 then 
      Option := To_Unbounded_String(Argument(1));
   else 
      Option := To_Unbounded_String("-b");
      -- ON A UN PROBLEME EXCEPTION !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! (si dernir argument est pas ficher txt)
   end if; 

   --Ouvrir le fichier
   Open (File => Fichier, Mode => In_File, Name => To_String(Nom_Fichier));
   S := Stream(Fichier);

   -- Générer le tableau des fréquences
   
   -- Initialiser le tableau des fréquences 
    Initialiser(Liste_Frequence);

    
    -- Parcourir le fichier 
   while not End_Of_File(Fichier) loop

      -- Récupérer le symbole
      Octet_symbole := T_Octet'Input(S);
      Symbole := Character'Val(Octet_symbole);

      -- Mettre à jour la listeChainee
      Curseur := Liste_Frequence; 

      -- Rechercher le symbole ou la fin de la listeChainee
      while not Fin_Liste(Curseur) and then Le_Symbole(LArbre(Curseur))/=Symbole loop
         Curseur := Suivant(Curseur);
      end loop;

      if Fin_Liste(Curseur) then 
            -- Créer un nouvel arbre 
            Initialiser_Arbre(Arbre);
            Enregistrer_Arbre(Arbre,Symbole,1,To_Unbounded_String("0"),Arbre_null,Arbre_null);
            -- Créer une nouvelle cellule
            Ajouter_Liste(Liste_Frequence,Arbre);
            
      else
         -- Mettre à jour la fréquence
         Recuperer_LArbre(Arbre_recup,Curseur);
         Modifier_Frequence(Arbre_recup,La_Frequence(Arbre_recup) + 1); 
      
      end if; 
         
   end loop; 

   Close(Fichier);


   -- Ajouter le caractère de fin de fichier
   Enregistrer_Arbre(Arbre, '$', 0, To_Unbounded_String("0"),Arbre_null,Arbre_null); 
   Ajouter_Liste(Liste_Frequence,Arbre); 
   
   -- Construire l'arbre de Huffman 
   while Longueur(Liste_Frequence) > 1 loop
      -- Rechercher 2 plus faible fréquencess 

      --Initialiser variable de minimum (on a min1 < min2)
      if La_Frequence(LArbre(Liste_Frequence)) < La_Frequence(LArbre(Suivant(Liste_Frequence))) then 
         L_Arbre1 := Liste_Frequence; 
         L_Arbre2 := Suivant(Liste_Frequence); 
         min1 := La_Frequence(LArbre(L_Arbre1)); 
         min2 := La_Frequence(LArbre(L_Arbre2)); 
         Curseur := Suivant(L_Arbre2);
      else 
         L_Arbre2 := Liste_Frequence; 
         L_Arbre1 := Suivant(Liste_Frequence); 
         min1 := La_Frequence(LArbre(L_Arbre1)); 
         min2 := La_Frequence(LArbre(L_Arbre2)); 
         Curseur := Suivant(L_Arbre1); 
      end if;       

      -- Parcourir la liste pour rechercher les 2 mins
      while not Fin_Liste(Curseur) loop
         Arbre_Actuel := LArbre(Curseur); 
         if La_Frequence(Arbre_Actuel) < min2 then 
            min2 := La_Frequence(Arbre_Actuel); 
            L_Arbre2 := Curseur; 
         else 
            null; 
         end if; 

         if min1 > min2 then 
            -- Inverser les deux minimums 
            StockageL_Arbre := L_Arbre1; 
            StockageMin := min1; 
            L_Arbre1 := L_Arbre2; 
            min1 := min2; 
            L_Arbre2 := StockageL_Arbre; 
            min2 := StockageMin; 
         else 
            null; 
         end if; 

         Curseur := Suivant(Curseur);
      end loop;
       
      
     
       
      -- Construire la nouvelle branche 

      Enregistrer_Arbre(NouvelArbre,'0',min1+min2,To_Unbounded_String("0"),LArbre(L_Arbre1),LArbre(L_Arbre2));

      Ajouter_Liste(Liste_Frequence,NouvelArbre);
      


      -- Supprimer les 2 cellules 
      Supprimer_Cellule (Liste_Frequence,L_Arbre1); 

      Supprimer_Cellule (Liste_Frequence,L_Arbre2); 
   
   end loop; 


   -- Récupérer l'arbre

   ArbreHuffman := LArbre(Liste_Frequence); 

    -- Créer la table de codage 
   Bits_Parcours_Infixe := To_Unbounded_String("");
   Code(ArbreHuffman,To_Unbounded_String(""),Bits_Parcours_Infixe);
   
   Initialiser(Dict_Codage);
   Creer_Dict (ArbreHuffman, Dict_Codage); 

   -- Afficher l'arbre d'Huffman si besoin 
   if Option = "-s" then 
      null; 
   else 
      Put_Line("Arbre d'Huffman :");
      Afficher_Arbre(ArbreHuffman); 
      New_Line; 
      Put_Line("Table de codage");
      Afficher_Dict(Dict_Codage); 
      New_Line; 
   end if; 

   -- Coder le texte 
   Open (File => Fichier, Mode => In_File, Name => To_String(Nom_Fichier));
   S := Stream(Fichier);

   Texte_Code :=To_Unbounded_String("");

   while not End_Of_File(Fichier) loop
      Octet_symbole := T_Octet'Input(S);
      Symbole := Character'Val(Octet_symbole);
      Texte_Code := Texte_Code & La_Valeur(Dict_Codage, Symbole); 
   end loop; 

   Close(Fichier);
   Texte_Code := Texte_Code & La_Valeur(Dict_Codage, '$');

   Recuperer_Parcours_Arbre(ArbreHuffman, Bits_Parcours_Infixe);

   if Option ="-s" then 
      null; 
   else 
      Put("Bits_Parcours : ");
      Put(To_String(Bits_Parcours_Infixe));
      New_Line;
   end if; 
   
   Ecrire_Fichier(Nom_Fichier, Dict_Codage, Bits_Parcours_Infixe, Texte_Code);
   Put_Line("Fin de la compression");



end Compresser;
