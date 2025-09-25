package bibliotheque;

import static org.junit.Assert.*;
import org.junit.*;

import java.beans.Transient;

public class TestCatalogue {
    Catalogue livresCatalogue;
    Livre livre1, livre2, livre3;

    @Before
    public void setUp() {
        livresCatalogue = new Catalogue();

        livre1 = new Livre("Le Mystérieux Cercle Benedict - tome 1",
            "Trenton Lee Stewart","fantastique",
            "978-2747034364");

        livre2 = new Livre("Le Mystérieux Cercle Benedict - tome 2",
        "Trenton Lee Stewart","fantastique",
        "979-1036338045");

        livre3 = new Livre("Le Mystérieux Cercle Benedict - tome 3",
        "Trenton Lee Stewart","fantastique",
        "978-2017038122");
    } 

    @Test public void TestAjouterLivres() {
        livresCatalogue.ajouterLivre(livre1);
        assertTrue("livre 1 non ajouté",livresCatalogue.dejaPresent(livre1));
        livresCatalogue.ajouterLivre(livre2);
        assertTrue("livre 2 non ajouté",livresCatalogue.dejaPresent(livre2));
        livresCatalogue.ajouterLivre(livre3);
        assertTrue("livre 3 non ajouté",livresCatalogue.dejaPresent(livre3));
    }

    @Test public void TestAjouterMemeLivre(){
        livresCatalogue.ajouterLivre(livre1);
        assertTrue("livre 1 non ajouté",livresCatalogue.dejaPresent(livre1));
        livresCatalogue.ajouterLivre(livre1);
        assertEquals("second exemplaire non ajouté",livresCatalogue.quantite(livre1),2);
        assertEquals("second exemplaire non ajouté (diponibilité)",livresCatalogue.disponibilite(livre1),2);
    }

    @Test public void TestSupprimerLivre(){
        livresCatalogue.ajouterLivre(livre1);
        livresCatalogue.ajouterLivre(livre2);
        livresCatalogue.ajouterLivre(livre3);
        livresCatalogue.supprimerLivre(livre3);
        assertFalse("livre 3 non supprimé",livresCatalogue.dejaPresent(livre3)); 
        livresCatalogue.supprimerLivre(livre2);
        assertFalse("livre 2 non supprimé",livresCatalogue.dejaPresent(livre2)); 
        livresCatalogue.supprimerLivre(livre1);
        assertFalse("livre 1 non supprimé",livresCatalogue.dejaPresent(livre1)); 
   }

   @Test public void TestSupprimerExemplaire() {
    livresCatalogue.ajouterLivre(livre1);
    livresCatalogue.ajouterLivre(livre1);
    livresCatalogue.ajouterLivre(livre1);
    assertEquals("les 3 exmpalires ne sont pas ajouté",livresCatalogue.quantite(livre1),3); 
    livresCatalogue.supprimerExemplaire(livre1); 
    assertEquals("l'exemplaire 3 n'a pas été supprimé correctement",livresCatalogue.quantite(livre1),2); 
    livresCatalogue.supprimerExemplaire(livre1); 
    assertEquals("l'exemplaire 2 n'a pas été supprimé correctement",livresCatalogue.quantite(livre1),1); 
   }

   @Test public void TestSupprimerRetirer() {
    livresCatalogue.ajouterLivre(livre1);
    livresCatalogue.ajouterLivre(livre1);
    livresCatalogue.ajouterLivre(livre1);
    assertEquals("les 3 exmpalires ne sont pas ajouté",livresCatalogue.quantite(livre1),3); 
    livresCatalogue.supprimerExemplaire(livre1); 
    assertEquals("l'exemplaire 3 n'a pas été supprimé correctement",livresCatalogue.quantite(livre1),2); 
    assertTrue("supprimer Exemplaire ne doit pas supprimé le livre",livresCatalogue.dejaPresent(livre1)); 
    livresCatalogue.supprimerLivre(livre1); 
    assertFalse("Le livre n'a pas été supprimé",livresCatalogue.dejaPresent(livre1)); 
    
    }
}
