package utilisateur;
import bibliotheque.*;
import org.junit.*;
import static org.junit.Assert.*;
import java.util.ArrayList;
import java.util.List;

import java.beans.Transient;

public class TestUtilisateur{
    Livre livre1 = new Livre("Au Revoir La Haut", "Pierre Lemaitre", "roman","978-0-306-40615-7");
    Livre livre2 = new Livre("Les Couleurs de l'Incendie", "Pierre Lemaitre", "roman","980-0-308-40617-9");
    Utilisateur utilisateur1 = new Utilisateur("Mamalet", "Prune", 8121069,"mpd");
    Utilisateur utilisateur2 = new Utilisateur("Chaquir", "Sami", 8456789,"mpd2");
    

    @Test
   public void testEmprunter (){
        utilisateur1.pret(livre1);
        assertTrue(utilisateur1.aEmprunte(livre1));
        utilisateur1.retour(livre1);
        assertFalse(utilisateur1.aEmprunte(livre1));
   }  
        

   @Test
   public void testGetNomComplet(){
        System.out.println(utilisateur2.getNomComplet());  
        assertEquals("Sami Chaquir", utilisateur2.getNomComplet());
        assertEquals("Prune Mamalet", utilisateur1.getNomComplet());
   } 

} 
