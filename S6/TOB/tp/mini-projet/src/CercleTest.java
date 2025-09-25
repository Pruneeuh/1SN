import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/** 
 * Suite de la classe de test de la classe Cercle
 */

public class CercleTest {
    // definir les objets nécessaires
    public final static double EPSILON = 0.001;

    // Les points 
    private Point B,C,D,E;

    // Les cercles 
    private Cercle C2; 
    private Cercle C3; 
    private Cercle C4; 
    private Cercle C1; 

    @Before public void setUp() {
        // construction des points
        B = new Point(2,1); 
        C = new Point(4, 1);
        D = new Point(8, 1);
        E = new Point(8,4); 
        //construction des cercles
        C2 = new Cercle(C,D); 
        C3 = Cercle.creerCercle(D,E); 
        C4 = new Cercle(B,C,Color.red); 
        C1 = new Cercle (B,E,Color.blue); 
    }

    /**Vérifier si deux points ont les mêmes coordonées.
     * @param p1 le premier point
     * @param p2 le deuxième point
     */
    static void memesCoordonnees(String message, Point p1, Point p2){
        assertEquals(message + " (x)", p1.getX(), p2.getX(), EPSILON);
		assertEquals(message + " (y)", p1.getY(), p2.getY(), EPSILON);
    }

    @Test public void testerE12(){
        memesCoordonnees("E12 : Centre de C2 incorrect", new Point(6,1), C2.getCentre()); 
        assertEquals("E12 : Rayon de C2 incorrect", 2, C2.getRayon(), EPSILON); 
        assertEquals("La couleur de C2 est incorrect", Color.blue, C2.getCouleur()); 
    }

    @Test public void testerE13(){
        memesCoordonnees("E13 : Centre de C4 incorrect", new Point(3,1), C4.getCentre()); 
        assertEquals("E12 : Rayon de C4 incorrect", 1, C4.getRayon(), EPSILON); 
        assertEquals("La couleur de C4 est incorrect", Color.red, C4.getCouleur()); 

        memesCoordonnees("E13 : Centre de C1 incorrect", new Point(5,2.5), C1.getCentre()); 
        assertEquals("E13 : Rayon de C1 incorrect", B.distance(E)/2, C1.getRayon(), EPSILON); 
        assertEquals("La couleur de C1 est incorrect", Color.blue, C1.getCouleur()); 
    }

    @Test public void testerE14(){
        memesCoordonnees("E14 : Centre de C3 incorrect", D, C3.getCentre()); 
        assertEquals("E12 : Rayon de C3 incorrect", 3, C3.getRayon(), EPSILON); 
        assertEquals("La couleur de C3 est incorrect", Color.blue, C3.getCouleur());     
    }

}