package allumettes;


public class Arbitre {

    /*Le premier joueur */
    private Joueur j1;
    /*Le deuxième joeur */
    private Joueur j2;
    /*Le joueur actuel */
    private Joueur joueurActuel;

    /*Constuire un arbitre à partir des deux joueurs
     * @param j1 le premier joueur
     * @param j2 le second joueur
     */
    public Arbitre(Joueur j1, Joueur j2) {
        this.j1 = j1;
        this.j2 = j2;
        this.joueurActuel = j1;
    }

    /*Arbitrer une partie
     * @param jeu la partie à arbitrer
     */
    public void arbitrer(Jeu jeu) {
        try {
            while (!estFinie(jeu)) {
                this.untour(jeu);
            }
            indiquerFinPartie();

        } catch (OperationInterditeException | TricheHumaineException e) {
            System.out.println("Abandon de la partie car "
            + joueurActuel.getNom() + " triche !");
        }
    }

    /*Arbitrer un tour du jeu
     * @param jeu la partie en cours
     */
    protected void untour(Jeu jeu) {
        int prise = 0;
        // recuperer variable du tour ->> en faire une fonction
        int nbAllumette = recupererNbAllumettes(jeu);
        Proxy proxy = new Proxy(jeu);
        Boolean coupOk = false;

        while (!coupOk) {
            try {
                prise = joueurActuel.getPrise(proxy);
                coupOk = true;
            } catch (CoupInvalideException e) {
                pasEntier();
            }
        }
        gererPrise(nbAllumette, prise, jeu);

    }

    /*Afficher le joueur gagnant et le joueur perdant */
    protected void indiquerFinPartie() {
        this.changerJoueur();
        System.out.println(joueurActuel.getNom() + " perd !");
        this.changerJoueur();
        System.out.println(joueurActuel.getNom() + " gagne !");
    }

    /*Récupérer le nombre d'allumettes du jeu et l'afficher
     * @param jeu la partie actuelle
    */
    protected int recupererNbAllumettes(Jeu jeu) {
        int nbAllumette = jeu.getNombreAllumettes();
        //affiche le nb allumettes restantes
        System.out.println(jeu);
        //demander le nombre d'allumettes au joueur humain
        if (this.getJoueurActuel().getStrategieString().equals("humain")) {
            System.out.print(getJoueurActuel().getNom() + ", combien d'allumettes ? ");
        }
        return nbAllumette;
    }

    /*Vérifier la prise d'un joueur
     * @param prise nombre d'allumettes que le joueur veut prendre.
     * @param jeu la partie actuelle
     */
    protected void gererPrise(int nbAllumette, int prise, Jeu jeu) {
        try {
            afficherPriseClassique(nbAllumette, prise);
            retirerPrise(nbAllumette, prise, jeu);

        } catch (CoupInvalideException e) {
            afficherNbInvalide(e);
        }

        this.changerJoueur();
        System.out.println("");
    }

    /*Afficher le message d'erreur si un entier n'est pas donné */
    protected void pasEntier() {
        System.out.println("Vous devez donner un entier.");
        System.out.print(getJoueurActuel().getNom() + ", combien"
                + "d'allumettes ? ");
    }

    /* Change le joueur actuel pour pouvoir passer au tour suivant */
    protected void changerJoueur() {
        if (joueurActuel.equals(j1)) {
            this.joueurActuel = j2;
        } else {
            this.joueurActuel = j1;
        }
    }

    /* Détermine si la partie est finie
     * @param jeu la partie actuelle
     */
    public boolean estFinie(Jeu jeu) {
        return jeu.getNombreAllumettes() == 0;
    }

    /*Affiche le nombre d'allumettes que le joueur souhaite prendre
     * @param prise la prise du joueur
    */
    public void afficherPriseClassique(Integer nbAllumettes, Integer prise) {
        System.out.print(joueurActuel.getNom() + " prend " + prise + " allumette");
            if (prise > 1) {
                System.out.print("s");
            }
            System.out.print(".\n");
    }

    /*Retire la prise du joueur dans le jeu
     * @param prise la prise du joueur
     * @param jeu la partie actuelle
     */
    protected void retirerPrise(Integer nbAllumette, Integer prise, Jeu jeu)
         throws CoupInvalideException {
        if (prise > nbAllumette) {
            throw new CoupInvalideException(prise, " (> " + nbAllumette + ")");
        } else if (prise > jeu.PRISE_MAX) {
            throw new CoupInvalideException(prise, " (> " + jeu.PRISE_MAX + ")");
        } else if (prise < 1) {
            throw new CoupInvalideException(prise, " (< 1)");
        } else {
            jeu.retirer(prise);
        }
    }

    /*Afficher le problème si le coup n'est pas valide
     * @param e exception levée par le coup invalide
     */
    public void afficherNbInvalide(CoupInvalideException e) {
        System.out.println("Impossible ! Nombre invalide : "
        + e.getCoup() + e.getProbleme());
        this.changerJoueur();
    }

    /*Récupérer le joueur actuel
     * @return le joueur actuel
     */
    public Joueur getJoueurActuel() {
        return this.joueurActuel;
    }

}
