package application;

import utilisateur.Utilisateur;
import utilisateur.Utilisateurs;
import bibliotheque.Catalogue;
import javax.swing.*;
import java.awt.*;

/**
 * Fenêtre d’inscription – version mise à jour
 * Demande désormais : nom, prénom, numéro de carte étudiant, mot de passe (+ confirmation).
 * Ajoute le nouvel utilisateur dans la collection reçue en paramètre.
 */
public class PageInscription extends JFrame {

    private final Utilisateurs utilisateurs; // Référence conservée pour l’ajout
    private final Catalogue catalogue;

    public PageInscription(Catalogue catalogue, Utilisateurs utilisateurs) {
        super("Inscription");
        this.utilisateurs = utilisateurs;
        this.catalogue = catalogue;

        /* ---------- Paramètres généraux ---------- */
        setSize(BibliothequeAppSwing.dimmension[0], BibliothequeAppSwing.dimmension[1]);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        Container contenu = getContentPane();
        contenu.setLayout(new BorderLayout());
        contenu.setBackground(new Color(246, 230, 233));

        /* ---------- Panneau gauche : illustration ---------- */
        JPanel panelGauche = new JPanel();
        panelGauche.setBackground(new Color(234, 240, 240));
        ImageIcon imageIcon = new ImageIcon("application/images/inscription.png");
        Image imageRedim = imageIcon.getImage().getScaledInstance(200, 200, Image.SCALE_SMOOTH);
        panelGauche.add(new JLabel(new ImageIcon(imageRedim)));

        /* ---------- Panneau droit : formulaire ---------- */
        JPanel panelDroite = new JPanel(new GridBagLayout());
        panelDroite.setBackground(new Color(250, 235, 240));
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(10, 10, 10, 10);
        gbc.fill = GridBagConstraints.HORIZONTAL;
        gbc.gridx = 0;

        int ligne = 0;

        JLabel titre = new JLabel("Inscription");
        titre.setFont(new Font("SansSerif", Font.BOLD, 24));
        gbc.gridy = ligne++; gbc.gridwidth = 2;
        panelDroite.add(titre, gbc);
        gbc.gridwidth = 1;

        /* Nom */
        JLabel labelNom = new JLabel("Nom");
        gbc.gridy = ligne++; panelDroite.add(labelNom, gbc);
        JTextField champNom = new JTextField(20);
        champNom.setToolTipText("Votre nom");
        gbc.gridy = ligne++; panelDroite.add(champNom, gbc);

        /* Prénom */
        JLabel labelPrenom = new JLabel("Prénom");
        gbc.gridy = ligne++; panelDroite.add(labelPrenom, gbc);
        JTextField champPrenom = new JTextField(20);
        champPrenom.setToolTipText("Votre prénom");
        gbc.gridy = ligne++; panelDroite.add(champPrenom, gbc);

        /* Numéro étudiant */
        JLabel labelNum = new JLabel("Numéro étudiant");
        gbc.gridy = ligne++; panelDroite.add(labelNum, gbc);
        JTextField champNum = new JTextField(20);
        champNum.setToolTipText("Votre numéro de carte étudiant");
        gbc.gridy = ligne++; panelDroite.add(champNum, gbc);

        /* Mot de passe */
        JLabel labelMdp = new JLabel("Mot de passe");
        gbc.gridy = ligne++; panelDroite.add(labelMdp, gbc);
        JPasswordField champMdp = new JPasswordField(20);
        champMdp.setToolTipText("Choisissez un mot de passe");
        gbc.gridy = ligne++; panelDroite.add(champMdp, gbc);

        /* Confirmation */
        JLabel labelConf = new JLabel("Confirmer le mot de passe");
        gbc.gridy = ligne++; panelDroite.add(labelConf, gbc);
        JPasswordField champConf = new JPasswordField(20);
        champConf.setToolTipText("Répétez le mot de passe");
        gbc.gridy = ligne++; panelDroite.add(champConf, gbc);

        /* Bouton inscription */
        JButton boutonInscription = new JButton("S’inscrire");
        boutonInscription.setBackground(new Color(210, 222, 222));
        gbc.gridy = ligne++; panelDroite.add(boutonInscription, gbc);

        /* Lien retour connexion */
        JLabel dejaCompte = new JLabel("Déjà un compte ?");
        gbc.gridy = ligne++; panelDroite.add(dejaCompte, gbc);

        JButton lienConnexion = new JButton("Se connecter");
        lienConnexion.setBorderPainted(false);
        lienConnexion.setForeground(Color.BLUE);
        lienConnexion.setContentAreaFilled(false);
        lienConnexion.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        gbc.gridy = ligne++; panelDroite.add(lienConnexion, gbc);

        /* Assemblage des panneaux */
        contenu.add(panelGauche, BorderLayout.WEST);
        contenu.add(panelDroite, BorderLayout.CENTER);

        /* ---------- Logique d’inscription ---------- */
        boutonInscription.addActionListener(e -> {
            String nom      = champNom.getText().trim();
            String prenom   = champPrenom.getText().trim();
            String numStr   = champNum.getText().trim();
            String mdp      = new String(champMdp.getPassword());
            String conf     = new String(champConf.getPassword());

            // Vérifications de base
            if (nom.isEmpty() || prenom.isEmpty() || numStr.isEmpty() || mdp.isEmpty() || conf.isEmpty()) {
                JOptionPane.showMessageDialog(this, "Tous les champs sont obligatoires.", "Erreur", JOptionPane.ERROR_MESSAGE);
                return;
            }
            if (!mdp.equals(conf)) {
                JOptionPane.showMessageDialog(this, "Les mots de passe ne correspondent pas.", "Erreur", JOptionPane.ERROR_MESSAGE);
                return;
            }
            int numeroCarte;
            try {
                numeroCarte = Integer.parseInt(numStr);
            } catch (NumberFormatException ex) {
                JOptionPane.showMessageDialog(this, "Le numéro de carte doit être un entier.", "Erreur", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // Création et enregistrement
            Utilisateur nouvelUtilisateur = new Utilisateur(nom, prenom, numeroCarte, mdp);
            utilisateurs.ajouterUtilisateur(nouvelUtilisateur);

            JOptionPane.showMessageDialog(this, "Inscription réussie ! Vous pouvez maintenant vous connecter.");
            dispose();
            new PageConnexion(catalogue,utilisateurs);
        });

        lienConnexion.addActionListener(e -> {
            dispose();
            new PageConnexion(catalogue,utilisateurs);
        });

        setVisible(true);
    }
}
