with Ada.Text_IO ; use Ada.Text_IO ;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;

with TH;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


procedure th_sujet is

    Capacite_sujet : constant Integer := 11;

    function Hachage(Cle:Unbounded_String) return Integer is
        Position_Tab : Integer;
    begin
        Position_Tab := Length(Cle);
        if Position_Tab > Capacite_sujet  - 1 then
            Position_Tab := Position_Tab mod Capacite_sujet ;
        else
            null;
        end if;
        return Position_Tab;
    end Hachage;

    package TH_sujet is new TH(Capacite =>Capacite_sujet ,Hachage=>Hachage,T_Cle_TH=>Unbounded_String,T_Valeur_TH=>Integer);
    use TH_sujet;

    procedure Afficher_Cle_TH(Cle:Unbounded_String) is
    begin
        Put(To_String(Cle));
    end Afficher_Cle_TH;

    procedure Afficher_Donnee_TH(Valeur:Integer) is
    begin
        Put(Valeur,1);
    end Afficher_Donnee_TH;

    procedure Afficher_TH2 is new Afficher_TH(Afficher_Cle_TH, Afficher_Donnee_TH);



    Sda : TH_sujet.T_TH;
begin

    Initialiser_TH(Sda);

    Enregistrer_TH(Sda,To_Unbounded_String("un"),1);
    Enregistrer_TH(Sda,To_Unbounded_String("deux"),2);
    Enregistrer_TH(Sda,To_Unbounded_String("trois"),3);
    Enregistrer_TH(Sda,To_Unbounded_String("quatre"),4);
    Enregistrer_TH(Sda,To_Unbounded_String("cinq"),5);
    Enregistrer_TH(Sda,To_Unbounded_String("quatre-vingt-dix-neuf"),99);
    Enregistrer_TH(Sda,To_Unbounded_String("vingt-et-un"),21);

    Afficher_TH2(Sda);

    Detruire_TH(Sda);

end th_sujet;

