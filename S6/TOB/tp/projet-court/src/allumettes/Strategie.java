package allumettes;

public interface Strategie {

    /*Retourne le nombre d'allumettes à prendre en fonction de la strétagie
     * @param jeu la partie actuelle
     * @return la prise du joueur actuel
     */
    int choixNbAllumette(Jeu jeu) throws CoupInvalideException;

    /*Le nom de la stratégie */
    String toString();

}
