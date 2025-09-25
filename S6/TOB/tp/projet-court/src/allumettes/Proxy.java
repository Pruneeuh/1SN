package allumettes;

public class Proxy implements Jeu {
    /*Le nombre d'allumettes actuel */
    private Jeu jeuProcuration;

    /*Constuire un proxy à partir d'un jeu
     * @param jeu le jeu dont on veut créer le proxy
     */
    public Proxy(Jeu jeu) {
        this.jeuProcuration = jeu;
    }

    /*Lever une exception si un joueur essaye de retirer une allumette via le proxy
     * @param nbPrises le nombre d'allumettes que le joueur veut retirer
     * @throws OperationInterditeException il n'a pas le droit de retirer des allumettes
    */
    @Override
    public void retirer(int nbPrises) {
        throw new OperationInterditeException();
    }

    /*Récupérer le nombre d'allumettes présente dans le proxy
     * @return le nombre actuel d'allumettes
     */
    @Override
    public int getNombreAllumettes() {
        return this.jeuProcuration.getNombreAllumettes();
    }

    /*Retourne l'affichage du nombre d'allumettes restantes
     * @return nombre d'allumettes restantes
    */
    public String toString() {
        return "Allumettes restantes : " + String.valueOf(jeuProcuration.getNombreAllumettes());
    }
}
