package application;

import java.awt.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

import bibliotheque.Catalogue;
import bibliotheque.Livre;
import utilisateur.Utilisateurs;

public class PageNouveautes extends JFrame {
    public PageNouveautes(Catalogue catalogue,Utilisateurs utilisateurs) {
        super();
        setTitle("Nouveautés");
        setSize(BibliothequeAppSwing.dimmension[0], BibliothequeAppSwing.dimmension[1]);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());
        setBackground(new Color(246, 230, 233));

        Container contenu = this.getContentPane();
        contenu.setLayout(new BorderLayout());
        contenu.setBackground(new Color(246, 230, 233));

        JLabel texte = new JLabel("Voici nos nouveautés :");
        texte.setFont(new Font("Arial", Font.BOLD, 16));
        contenu.add(texte, BorderLayout.NORTH);

        // Création de quelques livres récents (exemple Agatha Christie)
        Livre[] nouveautes = {
            new Livre("Le Crime de l'Orient-Express", "Agatha Christie", "polar", "978-0-00-711931-8"),
            new Livre("Le Mystérieux Cercle Benedict", "Trenton Lee Stewart", "fantastique", "978-2747034364"),
            new Livre("Les Couleurs de l'Incendie", "Pierre Lemaitre", "roman", "980-0-308-40617-9")
        };

        String[][] nouveautesStr = new String[nouveautes.length][4];
        for (int i = 0; i < nouveautes.length; i++) {
            Livre l = nouveautes[i];
            nouveautesStr[i][0] = l.getTitre();
            nouveautesStr[i][1] = l.getAuteur();
            nouveautesStr[i][2] = l.getGenre();
            nouveautesStr[i][3] = l.getIsbn();
        }

        String[] nomColonnes = {"Titre", "Auteur", "Genre", "ISBN"};
        DefaultTableModel model = new DefaultTableModel(nouveautesStr, nomColonnes) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };

        JTable table = new JTable(model);
        JScrollPane scrollPane = new JScrollPane(table);
        contenu.add(scrollPane, BorderLayout.CENTER);

        // Bouton retour à l'accueil
        JButton retourBtn = new JButton("Retour à l'accueil");
        retourBtn.addActionListener(e -> {
            // juste pour que ça compile 
            new BibliothequeAppSwing(catalogue,utilisateurs);  // ou PageCatalogue, selon la page d'accueil
            dispose();
        });
        contenu.add(retourBtn, BorderLayout.SOUTH);

        setVisible(true);
    }
}
