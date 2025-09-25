package allumettes;

public class ArbitreConfiant extends Arbitre {

    public ArbitreConfiant(Joueur j1, Joueur j2) {
        super(j1, j2);
    }

    @Override
    /*Arbitrer un tour du jeu
     * @param jeu la partie en cours
     */
    protected void untour(Jeu jeu) {
        int prise = 0;
        int nbAllumette = recupererNbAllumettes(jeu);

        Boolean coupOk = false;
        while (!coupOk) {
            try {
                prise = getJoueurActuel().getPrise(jeu);
                coupOk = true;

            } catch (CoupInvalideException e) {
                pasEntier();

            } catch (TricheHumaineException e) {

                try {
                    jeu.retirer(1);
                } catch (CoupInvalideException f) {
                    System.out.println("on passe pas par ici");
                }

                System.out.println("[Une allumette en moins, plus que "
                        + String.valueOf(jeu.getNombreAllumettes()) + ". Chut !]");
                System.out.print(getJoueurActuel().getNom()
                    + ", combien d'allumettes ? ");
            }
        }
        gererPrise(nbAllumette, prise, jeu);
    }
}
