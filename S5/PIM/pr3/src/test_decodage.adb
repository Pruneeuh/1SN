with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_IO; use Ada.Text_IO;

with module_compresser; use module_compresser; 
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


procedure test_decodage is 
   
   procedure Ecrire_Fichier_Decode (Nom_Fichier : in Unbounded_String; Texte_Decode : in out Unbounded_String) is
      Nom_Fichier_Decode : constant String := To_String(Nom_Fichier) &".hff.d";
      Fichier2 : Ada.Streams.Stream_IO.File_Type;
      S2: Stream_Access;
      
      procedure Ajouter_Caractere (Texte_Decode : in out Unbounded_String; S: in Stream_Access) is -- une fois text décode -> écire fichier
         i : integer := 1;
      begin 
         while not (To_String(Texte_Decode)(i) = '$') loop
            Character'Write(S,To_String(Texte_Decode)(i));
            i := i+1;
         end loop;
      end Ajouter_Caractere;
   begin 
      Create(Fichier2, Out_File, Nom_Fichier_Decode);
      S2 := Stream(Fichier2);

      Ajouter_Caractere(Texte_Decode,S2);
      Close(Fichier2);
   end Ecrire_Fichier_Decode;

   procedure Afficher_Texte_Decode (Texte_Decode : in Unbounded_String) is 
      i : integer := 1;
   begin
      while not(To_String(Texte_Decode)(i)= '$' )loop
        
         Put(To_String(Texte_Decode)(i));
       
         i:= i +1;
      end loop;
   end Afficher_Texte_Decode;

   Octet_symbole : T_Octet; --variable pour stocker les octets du fichier d'origine 


   Arbre_null : T_Arbre; -- arbre intialiser à null
    
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

   Parcours_Texte : Unbounded_String;
   Texte_Decode : Unbounded_String;

   S : Stream_Access;



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

   Afficher_Arbre (ArbreHuffman);

   Parcours_Texte :=To_Unbounded_String("1000110110000101111101111001101111100100110111110101111001101001110100001001111010101010101111001010101111011111100100101011011000111100000010101010011000011100101011011000111110001000000");
   Decodage(Parcours_Texte, ArbreHuffman, Texte_Decode);
   
   Put_Line("decodage ok");
   

   Ecrire_Fichier_Decode(Nom_Fichier, Texte_Decode); 

   if Option = "-s" then 
      null; 
   else
      Afficher_Texte_Decode(Texte_Decode); 
   end if; 

   
end test_decodage;