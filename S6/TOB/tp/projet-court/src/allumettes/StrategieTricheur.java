package allumettes;

public class StrategieTricheur implements Strategie {

    /*Le nom de la stratégie */
    public String toString() {
        return "tricheur";
    }

    /*Retourne le nombre d'allumettes à prendre en fonction de la strétagie
     * @param jeu la partie actuelle
     * @return la prise du joueur actuel
     */
    public int choixNbAllumette(Jeu jeu) throws CoupInvalideException {
        System.out.println("[Je triche...]");
        while (jeu.getNombreAllumettes() > 2) {
            jeu.retirer(1);
        }
        System.out.println("[Allumettes restantes : 2]");
        return 1;
    }
}
