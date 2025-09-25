import java.awt.Color;
/** Cercle modélise un cercle dans un plan équipé d'un repère cartésien.
 * Il peut être affiché, translater.
 * On peut déterminer si  un point est à l'intérieur du cercle ou non.
 */
public class Cercle implements Mesurable2D {
    /**Constante pi. */
    public static final double PI = Math.PI;
    /** Centre du cercle. */
    private Point centre;
    /** Rayon du cercle. */
    private double rayon;
    /** Couleur du cercle. */
    private Color couleur;

    /**Construire un cercle à partir de son centre et son rayon.
     * @param centre    //point correspondant au centre
     * @param rayon     //rayon du cercle
     */
    public Cercle(Point centre, double rayon) {
        assert centre != null : "le centre est null";
        assert rayon > 0 : "le rayon est négatif";
        double x = centre.getX();
        double y = centre.getY();
        this.centre = new Point(x, y);
        this.rayon = rayon;
        this.couleur = Color.blue;
    }

    /**Construire un cercle à partir de deux points diamètralement opposés.
     * @param point1 // le premier point
     * @param point2 // le second point
     */

    public Cercle(Point point1, Point point2) {
        assert point1 != null : "le point1 est null";
        assert point2 != null : "le point2 est null";
        assert point1.distance(point2) > 0 : "la distance entre les points est nulle";
        double x = (point1.getX() + point2.getX()) / 2;
        double y = (point1.getY() + point2.getY()) / 2;
        this.centre = new Point(x, y);
        this.rayon = (point1.distance(point2)) / 2;
        this.couleur = Color.blue;
    }

    /**Construire un cercle à partir de deux points diamètralement opposés et sa couleur.
     * @param point1 // le premier point
     * @param point2 // le second point
     * @param vcolor // la couleur du contour
      */

    public Cercle(Point point1, Point point2, Color vcolor) {
        this(point1, point2);
        assert vcolor != null : "la couleur est nulle";
        this.couleur = vcolor;
    }

    /** Construire un cercle à partir de son centre et d'un point de sa circonférence.
     * @param ptCentre //son centre
     * @param ptCercle // point de sa circonférence
     * @return nouveau cercle créé
     */
    public static Cercle creerCercle(Point ptCentre, Point ptCercle) {
        assert ptCentre != null :  "le centre est null";
        assert ptCercle != null : "le point du cercle est null";
        assert ptCercle.distance(ptCentre) > 0 : "la distance entre les points est nulle";
        Cercle nvCercle = new Cercle(ptCentre, ptCercle.distance(ptCentre));
        return nvCercle;
    }

    /**Translater le cercle.
     * @param dx //dépalcement selon les abscisses
     * @param dy //déplacemenet selon les ordonées
     */
    public void translater(double dx, double dy) {
        this.centre.translater(dx, dy);
    }

    /**Obtenir le centre d'un cercle.
     * @return centre du cercle
     */
    public Point getCentre() {
        double x = this.centre.getX();
        double y = this.centre.getY();
        return new Point(x, y);
    }

    /** Obtenir le rayon du cercle.
     * @return rayon du cercle
     */
    public double getRayon() {
        return this.rayon;
    }
    /** Obtenir le diamètre du cercle.
     * @return diamètre du cercle
     */
    public double getDiametre() {
        return 2 * this.rayon;
    }

    /**Obtenir le perimètre du cercle.
     * @return permiètre du cercle
    */
    public double perimetre() {
        return 2 * PI * this.rayon;
    }

    /**Obtenir l'aire du cercle.
     * @return aire du cercle
     */
    public double aire() {
        return PI * this.rayon * this.rayon;
    }

    /** Obtenir la couleur du cercle.
     * @return couleur du cercle
     */
    public Color getCouleur() {
        return this.couleur;
    }

    /**Modifier la couleur du cercle.
     * @param couleur // nouvelle couleur du cercle
     */
    public void setCouleur(Color couleur) {
        assert couleur != null : "la couleur est nulle";
        this.couleur = couleur;
    }

    /**Afficher le cercle.
     * @return affichage du cercle
     */
    public String toString() {
        return "C" + this.rayon + "@" + this.centre;
    }

    /** Modifier le rayon du cercle.
     * @param rayon // nouveau rayon
     */
    public void setRayon(double rayon) {
        assert rayon > 0 : "le rayon est négatif";
        this.rayon = rayon;
    }

    /** Modifier le diamètre du cercle.
     * @param diametre // nouveau diamètre
     */
    public void setDiametre(double diametre) {
        assert diametre > 0 : "le diamètre est négatif";
        this.rayon = diametre / 2;
    }

    /** Détermine si le point est à l'intérieur du cercle.
     * @param pt //point dont on cherche à derteminer sa présence dans le cercle
     * @return présence dans le cercle ou non
     */
    public boolean contient(Point pt) {
        assert pt != null : "le point est null";
        return pt.distance(this.centre) <= this.rayon;
    }

}
