package application;
import java.awt.*;
import java.awt.event.*;


import javax.swing.*;
import javax.swing.border.Border;
import javax.swing.table.DefaultTableModel;

import bibliotheque.*;
import utilisateur.*;

public class PageBibliothecaire extends JFrame {
    private Boolean accesAutorise;
    public PageBibliothecaire(Catalogue catalogue, Utilisateurs utilisateurs) { /*ajouter la liste des utilisateurs comme constructeur quand elle sera implantée */

        this.accesAutorise = false; 

        setSize(BibliothequeAppSwing.dimmension[0],BibliothequeAppSwing.dimmension[1]);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        

        Container contenuBibliothecaire = this.getContentPane(); 
        contenuBibliothecaire.setLayout(new BorderLayout());
        contenuBibliothecaire.setBackground(new Color(246,230,233));

        JLabel titreBibliothecaire = new JLabel("                        INTERFACE BIBLIOTHECAIRE"); 
        titreBibliothecaire.setFont(new Font("Arial",Font.PLAIN, 30));
        contenuBibliothecaire.add(titreBibliothecaire, BorderLayout.NORTH);

        

        /*ajouter demande MDP */
        JPanel pannelMdp = new JPanel(new FlowLayout());

        JLabel labelMdp = new JLabel("Mot De Passe : ");
        pannelMdp.add(labelMdp);

        JPasswordField caseMdp = new JPasswordField(50);
        pannelMdp.add(caseMdp);

        JButton bValiderMdp = new JButton("Valider");
        bValiderMdp.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                if ((caseMdp.getText()).equals("mdpBiblio")) {
                    accesAutorise = true;
                }
            }
        });
        pannelMdp.add(bValiderMdp);
        JPanel centrage = new JPanel(new BorderLayout());
        centrage.add(pannelMdp,BorderLayout.CENTER);

        JPanel boutons = new JPanel();
        boutons.setLayout(new GridLayout(3,1));

        //boutons.add(centrage);

        JButton bAjout = new JButton("Mise à jour du catalogue");
        bAjout.setPreferredSize(new Dimension(200,200));
        bAjout.setBackground(new Color(210,222,222));
        
        boutons.add(bAjout);

        bAjout.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                if (accesAutorise) {
                    dispose();
                    new PageAjoutLivres(catalogue,utilisateurs);
                } else {
                    /*accès non autorisé */
                    new PageAccesNonAutorise();
                }
            }
        });
        
        JButton nouveautesBtn = new JButton("Nouveautés");
        nouveautesBtn.setPreferredSize(new Dimension(200, 200));
        nouveautesBtn.setBackground(new Color(210, 222, 222));
        nouveautesBtn.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                dispose();
                new PageNouveautes(catalogue,utilisateurs);
            
            }
        });
        boutons.add(nouveautesBtn);


        JButton bEmprunts = new JButton("Gestion des emprunts et retour");
        bEmprunts.setPreferredSize(new Dimension(200,200));
        bEmprunts.setBackground(new Color(210,222,222));

        bEmprunts.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                if (accesAutorise) {
                    dispose();
                    new PageEmpruntRetour(catalogue, utilisateurs);
                } else {
                    /*accès non autorisé */
                    new PageAccesNonAutorise();
                }
                
            }
        }); 

        boutons.add(bEmprunts); 
        contenuBibliothecaire.add(centrage,BorderLayout.NORTH);
        contenuBibliothecaire.add(boutons, BorderLayout.CENTER); 

        // Bouton retour à l'accueil
        JButton retourBtn = new JButton("Retour à l'accueil");
        retourBtn.addActionListener(e -> {
            // juste pour que ça compile 
            new BibliothequeAppSwing(catalogue,utilisateurs);  // ou PageCatalogue, selon la page d'accueil
            dispose();
        });
        contenuBibliothecaire.add(retourBtn, BorderLayout.SOUTH);


        setVisible(true); 
     
    }

    public static void main(String[] args){
        Catalogue catalogue = new Catalogue();
        Utilisateurs utilisateurs = new Utilisateurs(); 
        new PageBibliothecaire(catalogue, utilisateurs);

    }

}