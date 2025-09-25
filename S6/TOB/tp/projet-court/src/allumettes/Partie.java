package allumettes;
import java.util.Scanner;


public class Partie implements Jeu {

    
    /*Nombre d'allulettes dans la partie en cours */
    private int nbAllumette;
    /*Scanner utilisé pour cette partie */
    private Scanner scanner;

    
    /*Construire une partie avec un nombre d'allumettes fixée
     * @param nbInitial nombre initial d'allumettes souhaité
    */
    public Partie(int nbInitial) {
        this.nbAllumette = nbInitial;
        this.scanner = new Scanner(System.in);
    }

	/** Obtenir le nombre d'allumettes encore en jeu.
	 * @return nombre d'allumettes encore en jeu
	 */
	public int getNombreAllumettes() {
        return nbAllumette;
    }

	/** Retirer des allumettes.  Le nombre d'allumettes doit être compris
	 * entre 1 et PRISE_MAX, dans la limite du nombre d'allumettes encore
	 * en jeu.
	 * @param nbPrises nombre d'allumettes prises.
	 * @throws CoupInvalideException tentative de prendre un nombre invalide d'allumettes
	 */
	public void retirer(int nbPrises) {
            this.nbAllumette -= nbPrises;
    }

    /*Retourne l'affichage du nombre d'allumettes restantes
     * @return nombre d'allumettes restantes
    */
    public String toString() {
        return "Allumettes restantes : " + String.valueOf(nbAllumette);
    }

}
