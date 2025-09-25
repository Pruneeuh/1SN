package application;
import java.awt.*;
import java.awt.event.*;


import javax.swing.*;
import javax.swing.table.DefaultTableModel;

import bibliotheque.*;
import utilisateur.*;

public class PageAccesNonAutorise extends JFrame {
    
    public PageAccesNonAutorise() {
        setSize(600,200);
        Container containerNonAutorise = this.getContentPane();

        JLabel texte = new JLabel("             Accès non autorisé veuillez vous connecter");
        texte.setFont(new Font("Arial",Font.PLAIN, 20));
        texte.setForeground(Color.red);

        containerNonAutorise.add(texte);
        setVisible(true);
    }

}
