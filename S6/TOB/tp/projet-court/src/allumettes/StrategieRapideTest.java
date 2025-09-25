package allumettes;
import org.junit.*;
import static org.junit.Assert.*;

public class StrategieRapideTest {
    private Joueur jRapide;
    private Partie jeu; 

    /** Nombre maximal d'allumettes pouvant être prises. */
	private static final int NBINITIAL = 13;

    @Before public void setUp() {
        jRapide = new Joueur("Xavier", new StrategieRapide());
        jeu = new Partie(NBINITIAL);
    }

    @Test public void TesterCoupClassique() throws CoupInvalideException {
        int prise = jRapide.getPrise(jeu); 
        assertEquals("la stratgie rapide doit prendre le maximum d'allumettes possible", prise, jeu.PRISE_MAX);
    }

    @Test public void TesterCoupInferieurPriseMax() throws CoupInvalideException {
        jeu.retirer(10);
        int prise = jRapide.getPrise(jeu);
        assertEquals("la stratgie rapide doit prendre le maximum d'allumettes possible", prise, jeu.PRISE_MAX);
        jeu.retirer(1);
        prise = jRapide.getPrise(jeu);
        assertEquals("on ne doit pas prendre plus d'allumettes que possible", prise, jeu.PRISE_MAX - 1);
    }

    @Test public void TesterCoupFin() throws CoupInvalideException {
        jeu.retirer(12);
        int prise = jRapide.getPrise(jeu);
        assertEquals("on ne doit pas prendre plus d'allumettes que possible", prise, 1);
    }
}
