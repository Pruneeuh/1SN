package bibliotheque;
import utilisateur.*;

public class Emprunt {
    private Catalogue catalogue;

    public Emprunt(Catalogue catalogue) {
        this.catalogue = catalogue;
    }

    public boolean pret(Livre livre, Utilisateur utilisateur) {
        if (catalogue.dejaPresent(livre)) {
            catalogue.pret(livre);
            utilisateur.pret(livre);
            return true;
        }
        return false;
    }

    public void retour(Livre livre, Utilisateur utilisateur) {
        catalogue.retour(livre);
        utilisateur.retour(livre);
    }
}
