package allumettes;
import java.util.Random;

public class StrategieNaif implements Strategie {

    /*Retourne le nombre d'allumettes à prendre en fonction de la strétagie
     * @param jeu la partie actuelle
     * @return la prise du joueur actuel
     */
    public int choixNbAllumette(Jeu jeu) {
        Random r = new Random();
        int nbActuel = jeu.getNombreAllumettes();
        int nbAllumette;
        if (nbActuel >= jeu.PRISE_MAX) {
            nbAllumette = r.nextInt(jeu.PRISE_MAX) + 1;
        } else {
            nbAllumette = r.nextInt(nbActuel) + 1; //pour avoir un nb entre 1 et nbActuel
        }
        return nbAllumette;
    }

    /*Le nom de la stratégie */
    public String toString() {
        return "naif";
    }
}
