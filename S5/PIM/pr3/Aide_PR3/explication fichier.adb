    Fichier : Ada.Streams.Stream_IO.File_Type; 
    S : Stream_Access;  
    Octet_symbole : T_Octet; --variable pour stocker les octets du fichier d'origine 
    Symbole : Character; 

-- LECTURE
   Open (File => Fichier, Mode => In_File, Name => To_String(Nom_Fichier));
   S := Stream(Fichier);   --permet de faire le lien entre le fichier et notre programme

   while not End_Of_File(Fichier) loop 
   ---fonction déjà existante dans le ada.strams
      Octet_symbole := T_Octet'Input(S);        -- recupère la valeur de l'octet actuel
      Symbole := Character'Val(Octet_symbole);  -- récupère le symbole associé 
   end loop; 

   Close(Fichier);

--ECRITURE
   Nom_Fichier: constant String := To_String(Nom_Fichier) & ".hff";
   Fichier : Ada.Streams.Stream_IO.File_Type;	
   S2 :  Stream_Access ;

   Create(Fichier, Out_File, Nom_Fichier);
   S2 := Stream(Fichier);

      T_Octet'Write(S,T_Octet(Position));       -- pour écrire à partir d'un nb
      T_Octet'Write(S,T_Octet(Character'Pos(Cle)))    --pour écrire à partir d'un Caractère

      T_Octet'Write(S,Conversion_Octet(To_Unbounded_String(To_String(A_Enregistrer)(Indice_curseur..Indice_curseur+7)))); 
      -- pour écrire à partir d'une str qui contient une liste de bit (l.199 compresser.adb)
      -- avec conversion_octet qui transforme une unb_str en t_octet

   Close(Fichier):

   -- à la ligne LF 
