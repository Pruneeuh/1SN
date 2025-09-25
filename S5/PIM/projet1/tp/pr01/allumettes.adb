with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Alea;

--------------------------------------------------------------------------------
--  Auteur   : MAMALET Prune 
--  Objectif : Joueur au jeu des 13 allumettes avec plusieurs niveaux de jeu
--------------------------------------------------------------------------------

procedure Allumettes is
    Paquet_Allumettes : CONSTANT := 5; -- nombre d'allumettes par paquet à l'affichage
    Nombre_Max : CONSTANT := 3; --nombre maximum d'allumettes que l'on peut prendre 
    Nombre_Barre : CONSTANT := 3; -- nombre de barre d'allumettes à l'affichage 
    Nombre_initial : CONSTANT := 13; --nombre initial d'allumettes 
    
	Nombre_Allumettes : Integer ;   --nombre d'allumettes restant dans le jeu
	Choix : Character ;     -- type de partie choisie 
	Joueur : Boolean ;      -- si le joueur est l'ordinateur variable est à true 
	Reponse : Character ;   -- choix de l'utilisateur sur le premier joueur 
	Choix_Allumette : Integer ; -- nombre d'allumettes choisi par le joueur dans le tour actuel
	Erreur : Boolean ; -- variable a true si il y a eu une erreur dans le tour (ie un message de l'arbitre affiché)

	package Alea_1_3 is
    	new Alea (1, Nombre_Max);
	use Alea_1_3;

begin
	    -- initialiser une partie
    	Nombre_Allumettes := Nombre_initial;
    	
    	-- choisir le niveau
    	Put("Niveau de l'ordinateur (n)aïf, (d)istrait, (r)apide ou (e)xpert ? ");
    	Get(Choix);
    	case Choix is
        	when 'n' | 'N' => Put("Mon niveau est naïf.");
        	when 'd' | 'D' => Put("Mon niveau est distrait.");
        	when 'r' | 'R' => Put("Mon niveau est rapide.");
        	when others => Put("Mon niveau est expert.");
    	end case;

    	-- choisir le premier joueur
    	New_Line;
    	Put("Est-ce que vous commencez (o/n) ? ");
    	Get(Reponse);
    	Joueur := (Reponse = 'n' or Reponse ='N');

	loop
    	-- jouer un tour
    	if erreur=false then
    	    --	afficher allumettes
    	    for k in 1..Nombre_Barre loop
        	    -- afficher une ligne d'allumettes    
        	    New_line;
        	    for i in 1..Nombre_Allumettes loop
            	    --afficher une barre de chaque allumettes
            	    Put("|");
            	    if i mod Paquet_Allumettes = 0 and i/=Nombre_Allumettes then
                	    Put("   ");
                    elsif i/=Nombre_Allumettes then
                        Put(" ");
                    else
                        null;
            	    end if;
        	    end loop;
    	    end loop;
    	    New_Line;
        end if; 
    	if Joueur then
        	-- Jouer le tour de l'ordinateur
        	
        	case Choix is
            	when 'n' | 'N' =>  --Jouer en mode naïf
                    loop
                    	Get_Random_Number(Choix_Allumette);
                    exit when Choix_Allumette <= Nombre_Allumettes;
                    end loop;
            	when 'd' | 'D' => -- Jouer en mode distrait
            	    Get_Random_Number(Choix_Allumette); 
            	when 'r' | 'R' => -- Jouer en mode rapide
                	if Nombre_Allumettes >= Nombre_Max then
                        Choix_Allumette :=Nombre_Max;
                	else
                    	Choix_Allumette := Nombre_Allumettes;
                	end if;
            	when others => --Jouer en mode expert
                    case Nombre_Allumettes mod Nombre_Max+1 is
                        when 0 => Choix_Allumette :=Nombre_Max;
                        when 2 => Choix_Allumette :=2 ;
                        when others => Choix_Allumette :=1 ;
                    end case;
        	end case;
            
            -- Afficher le choix de l'ordinateur
        	New_Line; 
        	Put("Je prends ");
        	Put(Choix_Allumette, 1);
        	if Choix_Allumette = 1 then
        	    Put(" allumette.");
        	else 
        	    Put(" allumettes.");
        	end if; 
        	New_Line;
    	else
    	
        	--Jouer le tour de l'utilisateur
        	New_Line;
        	Put("Combien d'allumettes prenez-vous ? ");
        	Get(Choix_Allumette);
    	end if;
    	
    	-- Analyser le choix
    	if Choix_Allumette >0 and Choix_Allumette <= Nombre_Max and Choix_Allumette <= Nombre_Allumettes then
        	Joueur := not(Joueur);
        	Nombre_Allumettes := Nombre_Allumettes - Choix_Allumette;
        	Erreur := False;
    	else
    	
        	--Afficher le message de l'arbitre
        	if Choix_Allumette <= 0 then
            	Put("Arbitre : Il faut prendre au moins une allumette.");
            	Erreur := True;
            else 
        	           	
            	-- Gérer un choix d'allumettes trop grand
            	if Choix_Allumette > Nombre_Max then
            	    Put("Arbitre : Il est interdit de prendre plus de 3 allumettes.");
                    Erreur:=True;
            	elsif Nombre_Allumettes = 1 and Choix_Allumette>Nombre_Allumettes then
            	    Put("Arbitre : Il reste une seule allumette.");
            	    Erreur:=True;
                else
                    Put("Arbitre : Il reste seulement ");
                    Put(Nombre_Allumettes,1);
                    Put(" allumettes.");
                    Erreur:=True;
                    
            	end if;
        	end if ;
    	end if;
	exit when Nombre_Allumettes = 0;
	end loop;
	
	-- Afficher le gagnant
	if Joueur then  
	    New_Line;  
    	Put_Line("J'ai gagné.");
	else
	    New_Line;
    	Put_Line("Vous avez gagné.");
	end if;
end Allumettes;



