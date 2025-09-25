with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body LCA is

    procedure Free is
		new Ada.Unchecked_Deallocation (T_Cellule, T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda := Null;
	end Initialiser;


	procedure Detruire (Sda : in out T_LCA) is
	begin
        if Sda /= Null then
            Detruire(Sda.all.Suivant);
            Free(Sda);
        else
            Null;
        end if;
    end Detruire;


    procedure Afficher_Debug (Sda : in T_LCA) is
    begin

        -- Afficher la fin de la Sda
        if Sda = null then
            Put("--E");
        else
            -- Afficher un couple Clé-Valeur de la Sda
            Put("-->[""");
            Afficher_Cle(Sda.all.Cle);
            Put(""" : ");
            Afficher_Donnee(Sda.all.Valeur);
            Put("]");

            -- Afficher le reste de la Sda
            Afficher_Debug(Sda.all.Suivant);
        end if;
	end Afficher_Debug;


	function Est_Vide (Sda : T_LCA) return Boolean is
	begin
		return Sda = Null;
	end;


	function Taille (Sda : in T_LCA) return Integer is
	begin
                if Sda = null then
                    return 0;
                else
                    return 1 + Taille(Sda.all.Suivant);
                end if;
	end Taille;


     procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Valeur : in T_Valeur) is
        Nouvelle_Cellule : T_LCA;
        Parcours : T_LCA;
     begin
        Parcours := Sda;

        -- Parcourir la liste jusqu'à la Clé ou la fin
        while Parcours /= null and then Parcours.all.Cle /= Cle loop
                Parcours := Parcours.all.Suivant;
        end loop;
        if Parcours /= null then -- Traiter le cas où la Clé existait déjà
            Parcours.all.Valeur := Valeur;
        else
            -- Creer nouvelle cellule (allocation et initialisation)
            Nouvelle_Cellule := new T_Cellule;
            Nouvelle_Cellule.all.Cle := Cle;
            Nouvelle_Cellule.all.Valeur := Valeur;
            Nouvelle_Cellule.all.Suivant := Sda ;
            Sda := Nouvelle_Cellule;
        end if;

	end Enregistrer;


	function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
	begin
          if Sda = null then
               return False;
          else
               if Sda.Cle = Cle then
                   return True;
               else
                   return Cle_Presente(Sda.Suivant, Cle);
               end if;
          end if;
    end;


    function La_Valeur (Sda : in T_LCA ; Cle : in T_Cle) return T_Valeur is
        Parcours : T_LCA;

    begin
        -- Parcourir la liste jusqu'à la Clé ou la fin
        Parcours := Sda;
        while Parcours /= null and then Parcours.all.Cle /= Cle loop
                Parcours := Parcours.all.Suivant;
        end loop;

        if Parcours = null then
            raise Cle_Absente_Exception;
        else
            return Parcours.all.Valeur;
        end if;
	end La_Valeur;


    procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
            Parcours : T_LCA;
            Precedent : T_LCA;
    begin
        -- Verifier la présence de la Clé
        if not Cle_Presente(Sda,Cle) then
            raise Cle_Absente_Exception;
        else
            Parcours := Sda;
            if Parcours.all.Cle = Cle then -- Si la clé est dans la première cellule
                -- Supprimer la Cellule contant la clé
                Sda := Parcours.all.Suivant;
            else
                -- Parcourir la Sda jusqu'à la Clé
                while Parcours.All.Cle /= Cle loop
                    Precedent := Parcours;
                    Parcours := Parcours.all.Suivant;
                end loop;
                -- Supprimer ma cellule contenant la Clé
                Precedent.all.Suivant := Parcours.all.Suivant;
                Parcours.all.Suivant := null;
            end if;

        end if;
	end Supprimer;


    procedure Pour_Chaque (Sda : in T_LCA) is
           Parcours : T_LCA;
    begin
        Parcours := Sda;
        -- Parcourir la Sda
        while Parcours /= null loop
            begin
                Traiter(Parcours.all.Cle, Parcours.all.Valeur);
            exception
                 when others => Put_Line("Erreur de traitement sur un couple");
            end;
            Parcours := Parcours.all.Suivant;
        end loop;

	end Pour_Chaque;
end LCA;
