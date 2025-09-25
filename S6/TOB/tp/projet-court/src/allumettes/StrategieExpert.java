package allumettes;

public class StrategieExpert implements Strategie {

    /*Retourne le nombre d'allumettes à prendre en fonction de la strétagie
     * @param jeu la partie actuelle
     * @return la prise du joueur actuel
     */
    public int choixNbAllumette(Jeu jeu) {
        int nbActuel = jeu.getNombreAllumettes();
        switch (nbActuel % (jeu.PRISE_MAX + 1)) {
            case 0:
                return jeu.PRISE_MAX;
            case Jeu.PRISE_MAX :
                return 2;
            default:
                return 1;
        }
    }

    /*Le nom de la stratégie */
    public String toString() {
        return "expert";
    }
}
