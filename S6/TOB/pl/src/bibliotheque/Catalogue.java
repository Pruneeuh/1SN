package bibliotheque;

import java.util.*;

public class Catalogue {
    private Map<String, Livre> livres;

    public Catalogue() {
        this.livres = new HashMap<>();
    }

    public void ajouterLivre(Livre livre) {
        String isbn = livre.getIsbn();
        if (livres.containsKey(isbn)) {
            livres.get(isbn).ajouterExemplaire();
        } else { 
            livres.put(isbn, livre);
        }
    }
    public Livre getLivre(String ISBN){
        return this.livres.get(ISBN);
    }
    
    public void supprimerLivre(Livre livre) {
        livres.remove(livre.getIsbn());
    }

    public void supprimerExemplaire(Livre livre) {
        Livre l = livres.get(livre.getIsbn());
        if (l != null) {
            l.supprimerExemplaire();
            if (l.getQuantite() == 0) {
                livres.remove(livre.getIsbn());
            }
        }
    }

    public List<Livre> getLivres() {
        return new ArrayList<>(livres.values());
    }

    public int disponibilite(Livre livre) {
        Livre l = livres.get(livre.getIsbn());
        return (l != null) ? l.getDisponiblilite() : 0;
    }

    public int quantite(Livre livre) {
        Livre l = livres.get(livre.getIsbn());
        return (l != null) ? l.getQuantite() : 0;
    }

    public boolean dejaPresent(Livre livre) {
        return livres.containsKey(livre.getIsbn());
    }

    public void pret(Livre livre) {
        Livre l = livres.get(livre.getIsbn());
        if (l != null) {
            l.emprunter();
        }
    }

    public void retour(Livre livre) {
        Livre l = livres.get(livre.getIsbn());
        if (l != null) {
            l.retourner();
        }
    }

    public int longueur() {
        return livres.size();
    }

    public String[][] recupCatalogue(){
        String[][] catalogue = new String[livres.size()][5];
        int i = 0;
        for (var e : livres.entrySet()){
            catalogue[i][0] = e.getValue().getTitre();
            catalogue[i][1] = e.getValue().getAuteur();
            catalogue[i][2] = e.getValue().getGenre();
            catalogue[i][3]= Integer.toString(e.getValue().getQuantite());
            catalogue[i][4]=Integer.toString(e.getValue().getDisponiblilite());
            i++;
        }
        return catalogue;
    }
}
