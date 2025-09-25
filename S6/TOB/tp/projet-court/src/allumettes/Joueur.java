package allumettes;

public class Joueur {

    /*le nom du joueur */
    private String nom;
    /*la stratégie du joueur */
    private Strategie strategie;

    /*Construire un joueur à partir de son nom et sa stratégie
     * @param nom le nom du joueur
     * @param strategie la stratégie du joueur
     */
    public Joueur(String nom, Strategie strategie) {
        this.nom = nom;
        this.strategie = strategie;
    }

    /*Récupérer le nom du joueur
     * @return le nom du joueur
     */
    public String getNom() {
        return nom;
    }

    /*Renvoyer la prise du joueur en fonction du jeu
     * @param jeu la partie actuelle
     * @return la prise du joueur
     * @throws CoupInvalideException le coup n'est pas valide
     */
    public int getPrise(Jeu jeu) throws CoupInvalideException {
        return strategie.choixNbAllumette(jeu);
    }

    /*Récupérer la stratégie du joueur sous forme de String
     * @return la stratégie du joueur en chaîne de caractères
     */
    public String getStrategieString() {
        return strategie.toString();
    }

    /*Changer la stratégie d'un joueur
     * @param nouvelle stratégie
     */
    public void changerStrategie(Strategie nouvellestrategie)   {
        this.strategie = nouvellestrategie;
    }
}
