with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_IO; use Ada.Text_IO;
with module_decompresser; use module_decompresser; 
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Decompresser is 
   Arbre_null : T_Arbre; -- arbre intialiser à null
   --Octet : T_Octet; --octet récupéré dans le fichier 
   Nom_Fichier : Unbounded_String;  
   Fichier : Ada.Streams.Stream_IO.File_Type;
   --Texte_code : Unbounded_String;
   --SuiteBits : Unbounded_String;
   Arbre_Huffman : T_Arbre;
   --Liste_Symbole : Unbounded_String;
   Option : Unbounded_String;
   
   Lecture_symbole : Boolean; 
   Symboles_Utilises : Unbounded_String; 
   Parcours_Texte : Unbounded_String; 

   S : Stream_Access;
   Symbole : Character ;
   Octet_symbole : T_Octet; 
   Texte_Decode : Unbounded_String; 


   Position_Dollar_char : Integer; 

   Suite_Bits : Unbounded_String; 


   
   procedure Ecrire_Fichier_Decode (Nom_Fichier : in Unbounded_String; Texte_Decode : in out Unbounded_String) is
      Nom_Fichier_Decode : constant String := To_String(Nom_Fichier) &".d";
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



begin
   --initialisation d'un arbre nul
   Initialiser_Arbre(Arbre_null);

   --On recupère le nom du fichier 
   Nom_Fichier := To_Unbounded_String(Argument(Argument_Count)); 

   -- Récupérer l'option 
   if Argument_Count = 2 then 
      Option := To_Unbounded_String(Argument(1));
   else 
      Option := To_Unbounded_String("-b");
   end if; 

   Symboles_Utilises := To_Unbounded_String("");
   Open (Fichier, In_File,To_String(Nom_Fichier));
   S := Stream(Fichier); 
   Lecture_symbole := True; 
   Parcours_Texte := To_Unbounded_String(""); -- parcours de l'abre et le texte codé 

   Position_Dollar_char := Integer(T_Octet'Input(S));
   Symbole := '$';
   

   while not End_Of_File(Fichier) loop
      Octet_symbole := T_Octet'Input(S);

      if Character'Val(Octet_symbole) /= Symbole and Lecture_symbole then  
         Symbole := Character'Val(Octet_symbole);
         Symboles_Utilises := Symboles_Utilises & Symbole; 
   

      elsif Character'Val(Octet_symbole) = Symbole then 
         Lecture_symbole := False; 

      else 
         Convertir_octet_bits(Octet_symbole, Suite_Bits);
         Parcours_Texte := Parcours_Texte & Suite_Bits; --on chercher à le convertir en suite de bits 
      end if; 
   end loop; 
   Close(Fichier); 
   
   

   --Recuperer la liste des arbres reconstruits
   reconstruire_Arbre(Arbre_Huffman,Parcours_Texte); -- IL Y A UN PB IL EST LA 

  
   

   --On met les symboles dans les feuilles
   Changer_Symboles (Arbre_Huffman,Symboles_Utilises,Position_Dollar_char);    
  
   
   --Decoder le fichier et l'enregister dans .d
   Decodage(Parcours_Texte, Arbre_Huffman, Texte_Decode);

   if Option = "-s" then 
      null; 
   else
      Put("Arbre reconstuit : ");
      Afficher_Arbre(Arbre_Huffman);
      New_Line; 
      Put_Line("Texte décodé : "); 
      Afficher_Texte_Decode(Texte_Decode); 
   end if; 


   Ecrire_Fichier_Decode(Nom_Fichier, Texte_Decode); 
   New_Line;  
   Put_Line("Fin de la décompression");

end Decompresser;
