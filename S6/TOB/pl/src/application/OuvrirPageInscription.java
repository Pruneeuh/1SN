package application;
import utilisateur.*;
import bibliotheque.*;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JFrame;

public class OuvrirPageInscription implements ActionListener {
   private JFrame fenetrePrecedente;
   private Utilisateurs utilisateurs;
   private Catalogue catalogue;

   public OuvrirPageInscription(JFrame var1,Utilisateurs lesUtilisateurs,Catalogue catalogue) {
      this.fenetrePrecedente = var1;
      this.utilisateurs = lesUtilisateurs;
      this.catalogue = catalogue;
   }

   public void actionPerformed(ActionEvent var1) {
      this.fenetrePrecedente.dispose();
      new PageInscription(catalogue, utilisateurs);
   }
}