package application;
import utilisateur.*;
import bibliotheque.*;

public class BiblioDemo {
    
    public static void main(String[] args){

        /*Création de la liste des utilisateurs */
        Utilisateurs utilisateurs = new Utilisateurs();
        
        utilisateurs.ajouterUtilisateur(new Utilisateur("Mamalet", "Prune", 1,"mpd1"));
        utilisateurs.ajouterUtilisateur(new Utilisateur("Chaquir", "Sami", 2,"mpd2"));
        Utilisateur utilisateurTest = new Utilisateur("Werner--Guyader", "Garance", 3,"mpd3");
        utilisateurs.ajouterUtilisateur(utilisateurTest);
        utilisateurs.ajouterUtilisateur(new Utilisateur("Fadel", "Salma", 4,"mpd4"));
        utilisateurs.ajouterUtilisateur(new Utilisateur("Mamalet", "Prune", 5,"mpd5"));
        utilisateurs.ajouterUtilisateur(new Utilisateur("Chaquir", "Sami", 6,"mpd6"));


        Catalogue catalogue = new Catalogue();
        Livre livreTest = new Livre("Le Mystérieux Cercle Benedict - tome 1",
        "Trenton Lee Stewart","fantastique",
        "978-2747034364");
        catalogue.ajouterLivre(livreTest);

        catalogue.ajouterLivre(new Livre("Le Mystérieux Cercle Benedict - tome 2",
        "Trenton Lee Stewart","fantastique",
        "979-1036338045"));

        catalogue.ajouterLivre(new Livre("Le Mystérieux Cercle Benedict - tome 3",
        "Trenton Lee Stewart","fantastique",
        "978-2017038122"));

        catalogue.ajouterLivre(new Livre("Au Revoir La Haut", "Pierre Lemaitre", "roman","978-0-306-40615-7"));
        catalogue.ajouterLivre(new Livre("Les Couleurs de l'Incendie", "Pierre Lemaitre", "roman","980-0-308-40617-9"));
        catalogue.ajouterLivre(new Livre("Le Crime de l'Orient-Express", "Agatha Christie", "polar", "978-0-00-711931-8"));
        catalogue.ajouterLivre(new Livre("Le Mystérieux Cercle Benedict", "Trenton Lee Stewart", "fantastique", "978-2747034364"));
        catalogue.ajouterLivre(new Livre("Les Couleurs de l'Incendie", "Pierre Lemaitre", "roman", "980-0-308-40617-9"));
        
        catalogue.ajouterLivre(new Livre("À retardement","Franck Thilliez","policier","9782265157811"));
        catalogue.ajouterLivre(new Livre(" Le Journal de Samuel","Émilie Tronche","roman graphique","9782203296619"));

        catalogue.pret(livreTest);
        utilisateurTest.pret(livreTest);

        /*Création d'un emrpunt  */


        new BibliothequeAppSwing(catalogue, utilisateurs);
    }


}
