package allumettes;
import java.util.Scanner;

public class StrategieHumain implements Strategie {

    /*Le scanner de la partie associée */
    private Scanner scannerHumain;

    /*Créer une stratégie humaine à partir d'un scanner
     * @param scanner le scanner de la partie associée
     */
    public StrategieHumain(Scanner scanner) {
        this.scannerHumain = scanner;
    }

    /*Retourne le nombre d'allumettes à prendre en fonction de la strétagie
     * @param jeu la partie actuelle
     * @return la prise du joueur actuel
     */
    public int choixNbAllumette(Jeu jeu) throws CoupInvalideException {
        String saisie = scannerHumain.nextLine();
        Integer prise;
        try {
            prise = Integer.valueOf(saisie);
        } catch (NumberFormatException e) {
            if (saisie.equals("triche")) {
                throw new TricheHumaineException();
            } else {
                throw new CoupInvalideException(0, "pasEntier");
            }
        }
        return prise;
    }

    /*Le nom de la stratégie */
    public String toString() {
        return "humain";
    }
}
