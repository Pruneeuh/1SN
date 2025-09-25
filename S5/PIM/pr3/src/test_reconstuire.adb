with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Wide_Wide_Unbounded.Wide_Wide_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

with module_decompresser; use module_decompresser;

procedure test_reconstuire is 
   Parcours1 :Unbounded_String :=  To_Unbounded_String("011000");
   Parcours2 :Unbounded_String :=  To_Unbounded_String("00111000");
   Parcours3 :Unbounded_String :=  To_Unbounded_String("000110111000");
   Parcours4 :Unbounded_String :=  To_Unbounded_String("00011011011000");
   Arbre1 : T_Arbre; 
   Arbre2 : T_Arbre; 
   Arbre3 : T_Arbre;  
   Arbre4 : T_Arbre; 
  

begin 
   reconstruire_Arbre(Arbre1,Parcours1); 
   Put_Line("reconstuire abre 1 ok");
   Afficher_Arbre ((Arbre1)); 

   reconstruire_Arbre(Arbre2,Parcours2); 
   Put_Line("reconstuire abre 2 ok");
   Afficher_Arbre(Arbre2); 

   reconstruire_Arbre(Arbre3,Parcours3); 
   Put_Line("reconstuire abre 3 ok");
   Afficher_Arbre ((Arbre3)); 

   reconstruire_Arbre(Arbre4,Parcours4); 
   Put_Line("reconstuire abre 4 ok");
   Afficher_Arbre ((Arbre4)); 


end test_reconstuire;