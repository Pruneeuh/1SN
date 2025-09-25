package application;
import java.awt.*;
import java.awt.event.*;


import javax.swing.*;
import javax.swing.table.DefaultTableModel;

import bibliotheque.*;
import utilisateur.*;

public class PageEmpruntRetour extends JFrame {
    public PageEmpruntRetour(Catalogue catalogue, Utilisateurs utilisateurs) {
        setSize(BibliothequeAppSwing.dimmension[0],BibliothequeAppSwing.dimmension[1]);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        setSize(BibliothequeAppSwing.dimmension[0],BibliothequeAppSwing.dimmension[1]);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        Container gestionEmprunts = this.getContentPane(); 
        gestionEmprunts.setLayout(new BorderLayout());
      
        JPanel pannelTitre = new JPanel(new FlowLayout());

        ImageIcon imagLivre = new ImageIcon("application/images/catalogue.png");
        Image imagLivreRedim = imagLivre.getImage().getScaledInstance(50, 50, Image.SCALE_SMOOTH);
        imagLivre = new ImageIcon(imagLivreRedim);
        JLabel labelImage = new JLabel(imagLivre);
        pannelTitre.add(labelImage);
        
        JLabel titreAjout = new JLabel("GESTION DES EMPRUNTS"); 
        titreAjout.setFont(new Font("Arial",Font.PLAIN, 30));
        pannelTitre.add(titreAjout);

        pannelTitre.setBackground(new Color(246,230,233));
        gestionEmprunts.add(pannelTitre,BorderLayout.NORTH);

        JPanel panelInfo = new JPanel(new GridLayout(6,1));

        JLabel labelTitre = new JLabel("ISBN du livre :");
        panelInfo.add(labelTitre);

        JTextField caseRechercheISBN = new JTextField(50);
        caseRechercheISBN.setBorder(null);
        panelInfo.add(caseRechercheISBN);

        JButton bRechercher = new JButton("Rechercher");
        bRechercher.setBackground(new Color(210,222,222));
        panelInfo.add(bRechercher); 

        JTextArea resultat = new JTextArea(5, 30);
        resultat.setEditable(false);
        panelInfo.add(resultat);

        bRechercher.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String ISBN = caseRechercheISBN.getText(); 
                Livre livre = catalogue.getLivre(ISBN); 
                if (livre != null) {
                    resultat.setText(livre.getTitre());
                } else {
                    resultat.setText("Livre non trouvé");
                }
            }
        });
        

        JButton bEmprunt = new JButton("Emprunt");
        bEmprunt.setBackground(new Color(210,222,222));
        panelInfo.add(bEmprunt);
        
        bEmprunt.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                String ISBN = caseRechercheISBN.getText(); 
                Livre livre = catalogue.getLivre(ISBN); 
                new PageEmpruntLivres(catalogue, utilisateurs, livre);
            }
        });

        JButton bRetour = new JButton("Retour");
        bRetour.setBackground(new Color(255,255,255));
        panelInfo.add(bRetour);
        
        bRetour.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                String ISBN = caseRechercheISBN.getText(); 
                Livre livre = catalogue.getLivre(ISBN); 
                new PageRetourLivres(catalogue, utilisateurs, livre);
            }
        });
    

    

    panelInfo.setMaximumSize(new Dimension(BibliothequeAppSwing.dimmension[0]-200,BibliothequeAppSwing.dimmension[1]-500));
    panelInfo.setBackground(new Color(210,222,222));

    gestionEmprunts.add(panelInfo, BorderLayout.CENTER);

    setVisible(true);
    }

}