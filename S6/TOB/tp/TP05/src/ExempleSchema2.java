import afficheur.Ecran;

public class ExempleSchema2 {
    
    public static void main(String[] args){ 
        // Créer les points 
        Point p1 = new Point(11,4); 
        PointNomme pn2 = new PointNomme (3,2,"A");
        PointNomme pn3 = new PointNomme (6,9,"S"); 

        // Créer les segments 
        Segment s12 = new Segment(p1, pn2);
		Segment s23 = new Segment(pn2, pn3);
		Segment s31 = new Segment(pn3, p1);

        double sx = p1.getX() + pn2.getX() + pn3.getX();
		double sy = p1.getY() + pn2.getY() + pn3.getY();
		Point barycentre = new PointNomme(sx / 3, sy / 3,"C");

        // Afficher le schéma
		System.out.println("Le schéma est composé de : ");
		s12.afficher();		System.out.println();
		s23.afficher();		System.out.println();
		s31.afficher();		System.out.println();
		barycentre.afficher();	System.out.println();
		// Créer l'écran d'affichage
		Ecran ecran = new Ecran("ExempleSchema1", 600, 400, 20);
		ecran.dessinerAxes();

		// Dessiner le schéma sur l'écran graphique
		s12.dessiner(ecran);
		s23.dessiner(ecran);
		s31.dessiner(ecran);
		barycentre.dessiner(ecran);
    }

}
