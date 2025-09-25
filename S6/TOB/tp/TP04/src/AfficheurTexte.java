import java.awt.Color;

public interface AfficheurTexte {
    
    public void afficherPoint(double x, double y,Color couleur){
        System.out.println("Point {"); 
        System.out.println("    x = " + x); 
        System.out.println("    y = " +y); 
        Color couleur = pt.getCouleur();
        System.out.println("    couleur= " + couleur); 
        System.out.println("}"); 
    }

    public void afficherLigne(double x1, double y1, double x2, double y2, Color couleur){
        System.out.println("Ligne {"); 
        System.out.println("    x1 = " + x1); 
        System.out.println("    y1 = " + y1); 
        System.out.println("    x2 = " + x2); 
        System.out.println("    y2 = " + y2); 
        System.out.println("    couleur= " + couleur); 
        System.out.println("}"); 
    }

    public void afficherCercle(double centre_x, double centre_y, Color couleur){
        System.out.println("Cercle {"); 
        System.out.println("    centre_x = " + centre_x); 
        System.out.println("    centre_y = " + centre_y); 
        System.out.println("    couleur= " + couleur); 

    }

    public void afficherTexte(double x ,double y,java.lang.String texte,Color couleur  ){
        System.out.println("Texte {"); 
        System.out.println("    x = " + centre_x); 
        System.out.println("    y = " + centre_y); 
        System.out.println("    valeur =" + texte );
        System.out.println("    couleur= " + couleur); 
    }

}
