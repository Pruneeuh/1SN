package bibliotheque;
import utilisateur.*;
import org.junit.*;
import static org.junit.Assert.*;
import java.util.ArrayList;
import java.util.List;

import java.beans.Transient;

public class TestEmprunt{

    Catalogue catalogue = new Catalogue();
    Livre livre1 = new Livre("Au Revoir La Haut", "Pierre Lemaitre", "roman","978-0-306-40615-7");
    Livre livre2 = new Livre("Les Couleurs de l'Incendie", "Pierre Lemaitre", "roman","980-0-308-40617-9");
   
    //List<Livre> Emprunts = new ArrayList<>();
    
    Utilisateur utilisateur1 = new Utilisateur("Prune", "Mamalet", 8121069,"mpd");
    Emprunt emprunt = new Emprunt(catalogue);

   @Test
   public void  pretTest(){
      catalogue.ajouterLivre(livre1);
      catalogue.ajouterLivre(livre2);
      utilisateur1.pret(livre1);
      assertTrue(utilisateur1.aEmprunte(livre1));
      assertFalse(utilisateur1.aEmprunte(livre2));
   } 

  @Test
  public void pretRetour(){
      catalogue.ajouterLivre(livre1);
      this.emprunt.pret(livre1,utilisateur1);  
      assertTrue(utilisateur1.aEmprunte(livre1));
      assertEquals(0,catalogue.disponibilite(livre1));

      emprunt.retour(livre1,utilisateur1);
      assertFalse(utilisateur1.aEmprunte(livre1));
      assertEquals(1,catalogue.disponibilite(livre1));
  }  
}
