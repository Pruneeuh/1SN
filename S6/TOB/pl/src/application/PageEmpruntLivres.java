package application;
import java.awt.*;
import java.awt.event.*;


import javax.swing.*;
import javax.swing.table.DefaultTableModel;

import bibliotheque.*;
import utilisateur.*; 

public class PageEmpruntLivres extends JFrame {
    public PageEmpruntLivres(Catalogue catalogue, Utilisateurs utilisateurs, Livre livre) {
        setSize(BibliothequeAppSwing.dimmension[0]/2,BibliothequeAppSwing.dimmension[1]/2);

        Container emprunts = this.getContentPane(); 
        emprunts.setLayout(new BorderLayout());
      
        JPanel pannelTitre = new JPanel(new FlowLayout());

        ImageIcon imagLivre = new ImageIcon("application/images/catalogue.png");
        Image imagLivreRedim = imagLivre.getImage().getScaledInstance(50, 50, Image.SCALE_SMOOTH);
        imagLivre = new ImageIcon(imagLivreRedim);
        JLabel labelImage = new JLabel(imagLivre);
        pannelTitre.add(labelImage);
        
        JLabel titreAjout = new JLabel("EMPRUNTS"); 
        titreAjout.setFont(new Font("Arial",Font.PLAIN, 30));
        pannelTitre.add(titreAjout);

        pannelTitre.setBackground(new Color(246,230,233));
        emprunts.add(pannelTitre,BorderLayout.NORTH);

        JPanel panelInfo = new JPanel(new GridLayout(3,1));

        JLabel labelTitre = new JLabel("Numero de Carte");
        panelInfo.add(labelTitre);

        JTextField caseRechercheCarte = new JTextField(50);
        caseRechercheCarte.setBorder(null);
        panelInfo.add(caseRechercheCarte);

        JButton bValider = new JButton("Valider");
        bValider.setBackground(new Color(210,222,222));
        panelInfo.add(bValider); 

        bValider.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String text = caseRechercheCarte.getText();
                int nCarte = Integer.parseInt(text);
                Utilisateur utilisateur = utilisateurs.getUtilisateurDansListe(nCarte);
                utilisateur.pret(livre);
                catalogue.pret(livre);
                dispose();
                new PageCatalogue(catalogue, utilisateurs);
            }
        });
    
    panelInfo.setMaximumSize(new Dimension(BibliothequeAppSwing.dimmension[0]-200,BibliothequeAppSwing.dimmension[1]-500));
    panelInfo.setBackground(new Color(210,222,222));

    emprunts.add(panelInfo, BorderLayout.CENTER);

    setVisible(true);
    }

   
}