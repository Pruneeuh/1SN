package application;
import bibliotheque.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import utilisateur.*;

public class BibliothequeAppSwing extends JFrame {

    public static int[] dimmension = {1000,600};

    public BibliothequeAppSwing(Catalogue catalogue, Utilisateurs utilisateurs){
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setTitle("Biblio7");

        /*Container de tout les éléments de la page */
        Container contenu = this.getContentPane(); //récupérer tout les composants
        contenu.setLayout(new java.awt.BorderLayout()); //les positionner à la suite
        contenu.setBackground(new Color(246,230,233));
        
        /*Pannel pour le bandeau haut */
        JPanel baniere = new JPanel(new FlowLayout());

        /*Nouveauté :  */
        ImageIcon imagNouveaute = new ImageIcon("application/images/nouveaute.png");
        Image imagNouveauteRedim = imagNouveaute.getImage().getScaledInstance(50, 50,Image.SCALE_SMOOTH );
        imagNouveaute = new ImageIcon(imagNouveauteRedim);
        JLabel labelNouveaute = new JLabel(imagNouveaute);
        baniere.add(labelNouveaute);
        JButton Bnouveaute = new JButton("Nouveautés");
        Bnouveaute.setBackground(new Color(210,222,222)); 
        Bnouveaute.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                dispose();
              new PageNouveautes(catalogue,utilisateurs);
            }
        });
        baniere.add(Bnouveaute);

        /*Catalogue : */
        ImageIcon imagCatalogue = new ImageIcon("application/images/catalogue.png");
        Image imagCatalogueRedim = imagCatalogue.getImage().getScaledInstance(50, 50, Image.SCALE_SMOOTH);
        imagCatalogue = new ImageIcon(imagCatalogueRedim);
        JLabel labelCatalogue = new JLabel(imagCatalogue);
        baniere.add(labelCatalogue);
        JButton Bcatalogue = new JButton("Catalogue");
        Bcatalogue.setBackground(new Color(210,222,222));
        baniere.add(Bcatalogue);

        Bcatalogue.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                dispose();
                new PageCatalogue(catalogue,utilisateurs);
            }
        });

        /*Connexion + Inscription : */
        ImageIcon imagConnexion = new ImageIcon("application/images/connection.png");
        Image imagConnexionRedim = imagConnexion.getImage().getScaledInstance(50, 50, Image.SCALE_SMOOTH);
        imagConnexion = new ImageIcon(imagConnexionRedim);
        JLabel labelConnexion = new JLabel(imagConnexion);
        baniere.add(labelConnexion);
        JPanel panelConnexion = new JPanel(new GridLayout(2,1,0,2));
        panelConnexion.setBackground(new Color(246,230,233));
        
        JButton Bconnexion = new JButton("Se connecter");
        Bconnexion.addActionListener(new OuvrirPageConnexion(this,catalogue,utilisateurs));
        Bconnexion.setBackground(new Color(210,222,222));
        panelConnexion.add(Bconnexion);
        
        JButton Binscription = new JButton("S'inscrire");
        Binscription.addActionListener(new OuvrirPageInscription(this,utilisateurs,catalogue));
        Binscription.setBackground(new Color(210,222,222));
        panelConnexion.add(Binscription);

        
        baniere.add(panelConnexion);
        
        /*Présentation : */
        JPanel panelDescription = new JPanel(new GridLayout(2,1));

        ImageIcon imagLogo = new ImageIcon("application/images/biblio7.png");
       // Image imagLogoRedim = imagLogo.getImage().getScaledInstance(50, 50, Image.SCALE_SMOOTH);
        
        JLabel biblio7 = new JLabel(imagLogo);
        biblio7.setBackground(new Color(246,230,233));
        
        panelDescription.add(biblio7);
        
        JTextPane description = new JTextPane();
        description.setText("                                   LA BIBLIOTHEQUE \n                                 POUR LES ETUDIANTS,\n                                  PAR LES ETUDIANTS ");
        description.setEditable(false);
        description.setMinimumSize(new Dimension(800,70));
        
        // augmenter la taille de la police
        Font fontDesc = new Font("Arial",Font.PLAIN,30);
        description.setFont(fontDesc);
        description.setBackground(new Color(246,230,233));
        panelDescription.add(description);

        JButton bBibliothecaire = new JButton("Accès bibliothécaire");
        bBibliothecaire.setBackground(new Color(210,222,222));
        bBibliothecaire.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                dispose();
                new PageBibliothecaire(catalogue,utilisateurs);
            }
        });
        JPanel pannelBBlio = new JPanel(new BorderLayout());
        
       
        pannelBBlio.add(bBibliothecaire,BorderLayout.CENTER);
        


        contenu.add(baniere,BorderLayout.NORTH);
        contenu.add(panelDescription,BorderLayout.CENTER);
        contenu.add(pannelBBlio,BorderLayout.SOUTH);
        

        this.setSize(dimmension[0],dimmension[1]);
        this.setVisible(true);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    public static void main(String[] args){
        Utilisateurs utilisateurs = new Utilisateurs();
        Catalogue catalogue = new Catalogue();
        new BibliothequeAppSwing(catalogue,utilisateurs);
    }
}
