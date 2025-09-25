package bibliotheque;

public class Livre {
    private String titre;
    private String auteur;
    private String isbn;
    private String genre;
    private int quantite;
    private int disponibilite;

    public Livre(String titre, String auteur,String genre, String isbn) {
        this.titre = titre;
        this.auteur = auteur;
        this.genre = genre;
        this.isbn = isbn;
        this.quantite = 1;
        this.disponibilite = 1;
    }

    public String getTitre() {
        return titre;
    }

    public String getAuteur() {
        return auteur;
    }

    public String getGenre() {
        return genre;
    } 
    public String getIsbn() {
        return isbn;
    }

    public int getQuantite() {
        return quantite;
    }

    public int getDisponiblilite() {
        return disponibilite;
    }

    public void ajouterExemplaire() {
        quantite++;
        disponibilite++;
    }

    public void supprimerExemplaire() {
        if (quantite > 0) {
            quantite--;
            disponibilite = Math.max(disponibilite - 1, 0);
        }
    }

    public void emprunter() {
        if (disponibilite > 0) {
            disponibilite--;
        }
    }

    public void retourner() {
        if (disponibilite < quantite) {
            disponibilite++;
        }
    }
}
