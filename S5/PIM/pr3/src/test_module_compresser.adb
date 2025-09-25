with module_compresser; use module_compresser; 
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure test_module is

   Arbre1 : T_Arbre;
   Arbre2 : T_Arbre;
   Arbre3 : T_Arbre; 

    procedure Tester_Initialiser is
        Liste : T_ListeChainee;
    begin
        Initialiser(Liste);
        pragma Assert(Longueur(Liste)=0);
    end Tester_Initialiser;

    procedure Tester_Enregistrer_Supprimer is
        Liste : T_ListeChainee;
        Arbre : T_Arbre;
        Fils_Droit : T_Arbre; 
        Fils_Gauche : T_Arbre; 
        
    begin
         Initialiser_Arbre(Fils_Droit); 
         Initialiser_Arbre(Fils_Gauche);  
         Initialiser_Arbre(Arbre); 
         Enregistrer_Arbre(Arbre, 'g', 2, To_Unbounded_String("01010001"), Fils_Gauche, Fils_Droit);

         Ajouter_Liste(Liste,Arbre);
         
         pragma Assert(Longueur(Liste)=1);

         Enregistrer_Arbre(Arbre, 'p', 3, To_Unbounded_String("00010"), Fils_Gauche, Fils_Gauche);
         Ajouter_Liste(Liste,Arbre);

         pragma Assert(Longueur(Liste)=2);

         Supprimer_Arbre(Arbre);
         pragma Assert(Longueur(Liste)=1);

    end Tester_Enregistrer_Supprimer;


    procedure Tester_Fils is
         Fils_Droit : T_Arbre; 
         Fils_Gauche : T_Arbre; 

    begin
        Initialiser_Arbre(Fils_Droit); 
        Initialiser_Arbre(Fils_Gauche);  
        
        Enregistrer_Arbre(Arbre2,'p',3,To_Unbounded_String("1001010"),Fils_Gauche, Fils_Droit);

        Enregistrer_Arbre(Arbre3, 'm', 5, To_Unbounded_String("101101"), Fils_Gauche, Fils_Droit);

        Enregistrer_Arbre(Arbre1,'g',2,To_Unbounded_String("1010"),Arbre3, Arbre2);

        pragma Assert(Arbre_Vide(Le_Fils_Gauche(Arbre1)));
        pragma Assert(Le_Fils_Droit(Arbre1)=Arbre2);

        Recuperer_Fils_Gauche(Fils_Gauche, Arbre1); 
        Recuperer_Fils_Droit(Fils_Droit, Arbre1); 

        pragma Assert(Arbre_Vide(Fils_Gauche)); 
        pragma Assert(Fils_Droit = Arbre2); 

        Afficher_Arbre(Arbre1);

    end Tester_Fils;

   procedure Tester_Suivant is
      Liste : T_ListeChainee; 
   begin 
      Ajouter_Liste(Liste, Arbre1); 
      Ajouter_Liste(Liste, Arbre2); 
      pragma Assert (LArbre(Suivant(Liste))=Arbre2);
   end Tester_Suivant;

   procedure Tester_FinArbre is 
   begin
      pragma Assert(Fin_Arbre(Arbre1)=False);
      pragma Assert(Fin_Arbre(Arbre2)=True);
   end Tester_FinArbre;
   
   procedure Tester_FinListe is 
      Liste : T_ListeChainee;
      Arbre : T_Arbre; 
      Fils_Droit : T_Arbre; 
      Fils_Gauche : T_Arbre; 

   begin 
      Initialiser_Arbre(Fils_Droit); 
      Initialiser_Arbre(Fils_Gauche);  
      Ajouter_Liste(Liste,Arbre1); 
      Enregistrer_Arbre(Arbre,'g', 2, To_Unbounded_String("010"), Fils_Gauche, Fils_Droit);
      Ajouter_Liste(Liste,Arbre);
      pragma Assert(Fin_Liste(Liste)=False); 
      pragma Assert(Fin_Liste(Liste)=True); 
   end Tester_FinListe;

   procedure Tester_ArbreVide is 
      ArbreVide : T_Arbre; 
   begin 
      Initialiser_Arbre(ArbreVide); 
      pragma Assert(Arbre_Vide(ArbreVide)); 
   end Tester_ArbreVide;
   
   procedure Tester_Modifications is 
      Arbre_a_modifier : T_Arbre; 
      Fils : T_Arbre; 
   begin 
      Initialiser_Arbre(Fils);
      Enregistrer_Arbre(Arbre_a_modifier, 's', 3, To_Unbounded_String("01101"), Fils, Fils);

      pragma Assert(Le_Symbole(Arbre_a_modifier)='s');
      pragma Assert(Le_Code(Arbre_a_modifier)=To_Unbounded_String("01101"));
      pragma Assert(La_Frequence(Arbre_a_modifier)=3); 

      Modifier_Code(Arbre_a_modifier,To_Unbounded_String("00"));

      pragma Assert(Le_Code(Arbre_a_modifier)=To_Unbounded_String("00"));

      Modifier_Frequence(Arbre_a_modifier,10); 

      pragma Assert (La_Frequence(Arbre_a_modifier)=10); 
   end Tester_Modifications;

  

begin
    Tester_Initialiser;
    Tester_Enregistrer_Supprimer;
    Tester_Fils;
    Tester_Suivant; 
    Tester_FinArbre;
    Tester_FinListe;
    Tester_ArbreVide; 
    Tester_Modifications; 
    Put_Line("Tests ok");
end test_module;
