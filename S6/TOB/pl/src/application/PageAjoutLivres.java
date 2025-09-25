package application;
import java.awt.*;
import java.awt.event.*;


import javax.swing.*;
import javax.swing.table.DefaultTableModel;

import bibliotheque.Catalogue;
import bibliotheque.Livre;
import utilisateur.Utilisateurs;

public class PageAjoutLivres extends JFrame {
    public PageAjoutLivres(Catalogue catalogue,Utilisateurs utilisateurs) {
        setSize(BibliothequeAppSwing.dimmension[0],BibliothequeAppSwing.dimmension[1]);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        Container contenuAjout = this.getContentPane(); 
        contenuAjout.setLayout(new BorderLayout());
      

        JPanel pannelTitre = new JPanel(new FlowLayout());

        ImageIcon imagLivre = new ImageIcon("application/images/catalogue.png");
        Image imagLivreRedim = imagLivre.getImage().getScaledInstance(50, 50, Image.SCALE_SMOOTH);
        imagLivre = new ImageIcon(imagLivreRedim);
        JLabel labelImage = new JLabel(imagLivre);
        pannelTitre.add(labelImage);
        
        JLabel titreAjout = new JLabel("    AJOUT D'UN NOUVEAU LIVRE AU CATALOGUE"); 
        titreAjout.setFont(new Font("Arial",Font.PLAIN, 30));
        pannelTitre.add(titreAjout);
        
        pannelTitre.setBackground(new Color(210,222,222));
        contenuAjout.add(pannelTitre,BorderLayout.NORTH);

        JPanel panelInfo = new JPanel(new GridLayout(8,1));
        

        JLabel labelTitre = new JLabel("Titre du livre :");
        panelInfo.add(labelTitre);

        JTextField caseTitre = new JTextField(50);
        caseTitre.setBorder(null);
        panelInfo.add(caseTitre);

        JLabel labelAuteur = new JLabel("Auteur : ");
        panelInfo.add(labelAuteur);

        JTextField caseAuteur = new JTextField(50);
        caseAuteur.setBorder(null);
        panelInfo.add(caseAuteur);
    

        JLabel labelGenre = new JLabel("Genre : ");
        panelInfo.add(labelGenre);

        JTextField caseGenre = new JTextField(50);
        caseGenre.setBorder(null);
        panelInfo.add(caseGenre);

        JLabel labelIsbn = new JLabel("ISBN : ");
        panelInfo.add(labelIsbn);
        
        JTextField caseIsbn = new JTextField(50);
        caseIsbn.setBorder(null);
        panelInfo.add(caseIsbn);

        panelInfo.setMaximumSize(new Dimension(BibliothequeAppSwing.dimmension[0]-200,BibliothequeAppSwing.dimmension[1]-500));
        panelInfo.setBackground(new Color(210,222,222));

        contenuAjout.add(panelInfo, BorderLayout.CENTER);

    

        JButton bAjouter = new JButton("Ajouter");
        bAjouter.setBackground(new Color(255,255,255));
        contenuAjout.add(bAjouter, BorderLayout.SOUTH);

        bAjouter.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
            // une fois qu'on a cliquer sur valider (on récup toutes infos)
            String titre = caseTitre.getText(); 
            String auteur = caseAuteur.getText();
            String genre = caseGenre.getText(); 
            String isbn = caseIsbn.getText(); 
            
            Livre nouveaLivre = new Livre(titre, auteur, genre, isbn);
            catalogue.ajouterLivre(nouveaLivre);
            dispose();
            new PageCatalogue(catalogue, utilisateurs);

            }
        });

        

        setVisible(true);
    }

   
}
