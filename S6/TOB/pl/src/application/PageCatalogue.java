package application;
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

import javax.swing.table.DefaultTableModel;

import bibliotheque.Catalogue;
import bibliotheque.Livre;
import utilisateur.*;

public class PageCatalogue extends JFrame{
    public PageCatalogue(Catalogue catalogue, Utilisateurs utilisateurs) {
        super();
       
        
        //setTitle("Biblio7");
        setSize(BibliothequeAppSwing.dimmension[0],BibliothequeAppSwing.dimmension[1]);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new java.awt.BorderLayout()); //les positionner à la suite
        setBackground(new Color(246,230,233));
        
        Container contenuCatalogue = this.getContentPane(); //récupérer tout les composants
        contenuCatalogue.setLayout(new java.awt.BorderLayout()); 
        contenuCatalogue.setBackground(new Color(246,230,233));

        JPanel panelHaut = new JPanel(new FlowLayout());

        

        JButton accueil = new JButton("Biblio7");

        accueil.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                dispose();
                new BibliothequeAppSwing(catalogue,utilisateurs);
            }
        });
        accueil.setBackground(new Color(210,222,222));

        panelHaut.add(accueil);



        JLabel texte = new JLabel("Voici notre catalogue actuel : ");
        panelHaut.add(texte);

        contenuCatalogue.add(panelHaut,BorderLayout.NORTH);

        
        String[][] catalogueStr = catalogue.recupCatalogue();
        String[] nomColonnes = {"titre","auteur","genre","quantité","disponibilité"};

        /*Rendre le tableau non modifiable */
        DefaultTableModel model = new DefaultTableModel(catalogueStr, nomColonnes){
           @Override
            public boolean isCellEditable(int row, int colum){
                return false;
            } 
        };

        JTable table = new JTable(model);
        table.setBackground(new Color (210,222,222));
        //pour le défilement : 
        JScrollPane scrollTable = new JScrollPane(table);
        
        contenuCatalogue.add(scrollTable,BorderLayout.CENTER);

        setVisible(true);

    }
}

