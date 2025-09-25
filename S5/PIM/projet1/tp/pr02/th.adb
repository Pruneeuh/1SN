with Ada.Text_IO ; use Ada.Text_IO ;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;


package body TH is

    procedure Afficher_TH(Sda:T_TH) is
        procedure Afficher_Debug_TH is new LCA_TH.Afficher_Debug(Afficher_Cle => Afficher_Cle_TH, Afficher_Donnee=> Afficher_Donnee_TH);
    begin
        for indice in 0..Capacite-1 loop
            Put(indice,1);
            Afficher_Debug_TH(Sda(indice));
            New_Line;
        end loop;
    end Afficher_TH;

    procedure Initialiser_TH(Sda : out T_TH) is
    begin
        for indice in 0..Capacite-1 loop
            LCA_TH.Initialiser(Sda(indice));
        end loop;
    end Initialiser_TH;

    procedure Detruire_TH (Sda : in out T_TH) is
    begin
        for indice in 0..Capacite-1 loop
            LCA_TH.Detruire(Sda(indice));
        end loop;
    end Detruire_TH;


    function Est_vide_TH(Sda : in T_TH) return Boolean is
        Vide : Boolean;
        Indice : Integer;
    begin
        Vide := True;
        Indice := 0;
        while Vide /= False loop
            Vide := LCA_TH.Est_Vide(Sda(indice));
        end loop;
        return Vide;
    end Est_vide_TH;


function Taille_TH(Sda: in T_TH) return Integer is
        Taille : Integer;
    begin
        Taille := 0;
        for indice in 0..Capacite-1 loop
        Taille := Taille + LCA_TH.Taille(Sda(indice));
    end loop;
    return Taille;
end Taille_TH;


procedure Enregistrer_TH(Sda: in out T_TH; Cle: in T_Cle_TH; Valeur : in T_Valeur_TH) is
    Position_Tab : Integer;
begin
    Position_Tab := Hachage(Cle);
    LCA_TH.Enregistrer(Sda(Position_Tab),Cle,Valeur);
end Enregistrer_Th;



procedure Supprimer_TH(Sda : in out T_TH; Cle: in T_Cle_TH) is
    Position_Tab : Integer;
begin
    Position_Tab := Hachage(Cle);
    LCA_TH.Supprimer(Sda(Position_Tab),Cle);
end Supprimer_Th;


function Cle_presente_TH(Sda : in T_TH ;Cle : in T_Cle_TH ) return Boolean is
    Position_Tab : Integer;
begin
    Position_Tab := Hachage(Cle);
    return LCA_TH.Cle_Presente(Sda(Position_Tab),Cle);
end Cle_presente_TH;


function La_Valeur_TH(Sda: in T_TH; Cle : in T_Cle_TH) return T_Valeur_TH is
    Position_Tab : Integer;
begin
    Position_Tab := Hachage(Cle);
    return LCA_TH.La_Valeur(Sda(Position_Tab),Cle);
end La_Valeur_TH;

procedure Pour_Chaque_TH(Sda : T_TH) is
    procedure Traiter is new LCA_TH.Pour_Chaque(Traiter_TH);
begin
    for indice in 0..Capacite-1 loop
            Traiter(Sda(indice));
    end loop;
end Pour_Chaque_TH;

end TH;

