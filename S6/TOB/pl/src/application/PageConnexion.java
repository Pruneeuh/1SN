package application;
import java.awt.*;
import javax.swing.*;

import bibliotheque.Catalogue;
import bibliotheque.Livre;
import utilisateur.Utilisateur;
import utilisateur.Utilisateurs;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class PageConnexion extends JFrame {
    public PageConnexion(Catalogue catalogue,Utilisateurs utilisateurs) {
        super("Connexion");

        setSize(BibliothequeAppSwing.dimmension[0], BibliothequeAppSwing.dimmension[1]);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null); // centre la fenêtre

        Container contenu = getContentPane();
        contenu.setLayout(new BorderLayout());
        contenu.setBackground(new Color(246, 230, 233));

        // Partie gauche avec icône
        JPanel panelGauche = new JPanel();
        panelGauche.setBackground(new Color(234, 240, 240));
        ImageIcon imageIcon = new ImageIcon("application/images/connexion.png");
        Image imageRedim = imageIcon.getImage().getScaledInstance(200, 200, Image.SCALE_SMOOTH);
        JLabel icone = new JLabel(new ImageIcon(imageRedim));
        panelGauche.add(icone);

        // Partie droite avec formulaire
        JPanel panelDroite = new JPanel(new GridBagLayout());
        panelDroite.setBackground(new Color(250, 235, 240));
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(10, 10, 10, 10);
        gbc.fill = GridBagConstraints.HORIZONTAL;

        JLabel titre = new JLabel("Connexion");
        titre.setFont(new Font("SansSerif", Font.BOLD, 24));
        gbc.gridx = 0;
        gbc.gridy = 0;
        gbc.gridwidth = 2;
        panelDroite.add(titre, gbc);

        gbc.gridwidth = 1;

        JLabel labelNum = new JLabel("Numéro étudiant");
        gbc.gridy = 1;
        panelDroite.add(labelNum, gbc);

        JTextField champNum = new JTextField(20);
        champNum.setToolTipText("Entrez votre numéro étudiant");
        gbc.gridy = 2;
        panelDroite.add(champNum, gbc);

        JLabel labelMdp = new JLabel("Mot de passe");
        gbc.gridy = 3;
        panelDroite.add(labelMdp, gbc);

        JPasswordField champMdp = new JPasswordField(20);
        champMdp.setToolTipText("Entrez votre mot de passe");
        gbc.gridy = 4;
        panelDroite.add(champMdp, gbc);

        JButton boutonConnexion = new JButton("Connexion");
        boutonConnexion.setBackground(new Color(210, 222, 222));
        gbc.gridy = 5;
        panelDroite.add(boutonConnexion, gbc);

        JLabel pasDeCompte = new JLabel("Pas de compte ?");
        gbc.gridy = 6;
        panelDroite.add(pasDeCompte, gbc);

        JButton lienInscription = new JButton("S’inscrire");
        lienInscription.setBorderPainted(false);
        lienInscription.setForeground(Color.BLUE);
        lienInscription.setContentAreaFilled(false);
        lienInscription.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        gbc.gridy = 7;
        panelDroite.add(lienInscription, gbc);

        contenu.add(panelGauche, BorderLayout.WEST);
        contenu.add(panelDroite, BorderLayout.CENTER);

        // Action de connexion
        boutonConnexion.addActionListener(e -> {
            String num = champNum.getText();
            String mdp = new String(champMdp.getPassword());
            try {
                int numero = Integer.parseInt(num);
            Utilisateur u = utilisateurs.chercher(numero, mdp);
            if (u != null) {
                JOptionPane.showMessageDialog(this, "Connexion réussie !");
                dispose();
                new PageNouveautes(catalogue,utilisateurs);
            } else {
                JOptionPane.showMessageDialog(this, "Identifiants incorrects.", "Erreur", JOptionPane.ERROR_MESSAGE);
            }
        } catch (NumberFormatException ex) {
            JOptionPane.showMessageDialog(this, "Numéro invalide.", "Erreur", JOptionPane.ERROR_MESSAGE);
        }
        });

        // Action vers page d’inscription
        lienInscription.addActionListener(e -> {
            dispose();
            new PageInscription(catalogue,utilisateurs); 
        });

        setVisible(true);
    }
}
