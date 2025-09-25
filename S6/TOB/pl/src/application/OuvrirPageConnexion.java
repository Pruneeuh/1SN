package application;
import bibliotheque.*;
import utilisateur.*;
import java.awt.event.*;
import javax.swing.*;
import javax.xml.catalog.Catalog;

import utilisateur.Utilisateur;

public class OuvrirPageConnexion implements ActionListener {
    private JFrame fenetrePrecedente;
    private Catalogue catalogue;
    private Utilisateurs utilisateurs;

    public OuvrirPageConnexion(JFrame fenetre,Catalogue catalogue, Utilisateurs utilisateurs) {
        this.fenetrePrecedente = fenetre;
        this.catalogue = catalogue;
        this.utilisateurs = utilisateurs;
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        fenetrePrecedente.dispose(); // ferme la fenêtre principale
        new PageConnexion(catalogue,utilisateurs);         // ouvre la page de connexion
    }
}
