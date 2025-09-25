with LCA;
with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


procedure lca_sujet is

    package LCA_dict is new LCA(T_Cle => Unbounded_String, T_Valeur=> Integer);
    use LCA_dict;

    Sda : LCA_dict.T_LCA;

    procedure Afficher_Cle_dict(Cle:Unbounded_String) is
    begin
        Put(To_String(Cle));
    end Afficher_Cle_dict;

    procedure Afficher_Donnee_dict(Valeur:Integer) is
    begin
        Put(Valeur,1);
    end Afficher_Donnee_dict;

    procedure Afficher_debug_dict is new Afficher_Debug(Afficher_Cle => Afficher_Cle_dict, Afficher_Donnee=> Afficher_Donnee_dict);


begin
    Initialiser(Sda);
    Enregistrer(Sda,To_Unbounded_String("un"),1);
    Enregistrer(Sda,To_Unbounded_String("deux"),2);
    Afficher_debug_dict(Sda);

    Detruire(Sda);

end lca_sujet;
