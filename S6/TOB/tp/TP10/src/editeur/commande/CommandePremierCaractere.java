package editeur.commande;
import editeur.Ligne;

public class CommandePremierCaractere extends CommandeLigne {
    public CommandePremierCaractere(Ligne var1){
        super(var1);
    }

    public void executer(){
        this.ligne.raz();
    }

    public boolean estExecutable(){
        return true;
    }
}
