package utilisateur;
import bibliotheque.*;

import java.util.ArrayList;
import java.util.List;

public class Utilisateur {
    private String nom;
    private String prenom;
    private int numeroCarte;
    private String mdp; // Mot de passe
    private List<Livre> Emprunts;

    public Utilisateur(String nom, String prenom, int numeroCarte, String mdp) {
        this.nom = nom;
        this.prenom = prenom;
        this.numeroCarte = numeroCarte;
        this.Emprunts = new ArrayList<>();
        this.mdp = mdp;
    }

    public boolean aEmprunte(Livre livre) {
        return Emprunts.contains(livre);
    }

    public void pret(Livre livre) {
        Emprunts.add(livre);
    }

    public void retour(Livre livre) {
        Emprunts.remove(livre);
    }

    public String getNomComplet() {
        return prenom + " " + nom;
    }

    public int getNumCarte() {
        return this.numeroCarte;
    }

    public boolean connexionValide(int numeroCarte, String mdp) {
        return ((numeroCarte == this.numeroCarte) && (mdp.equals(this.mdp)));
    }
}

