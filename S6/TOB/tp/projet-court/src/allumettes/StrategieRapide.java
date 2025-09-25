package allumettes;

public class StrategieRapide implements Strategie {

    /*Retourne le nombre d'allumettes à prendre en fonction de la strétagie
     * @param jeu la partie actuelle
     * @return la prise du joueur actuel
     */
    public int choixNbAllumette(Jeu jeu) {
        if (jeu.getNombreAllumettes() >= jeu.PRISE_MAX) {
            return jeu.PRISE_MAX;
        } else {
            return jeu.getNombreAllumettes();
        }
    }

    /*Le nom de la stratégie */
    public String toString() {
        return "rapide";
    }
}
