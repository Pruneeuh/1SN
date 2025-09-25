package editeur.commande;
import editeur.Ligne;

public class CommandeEffacerSousCurseur extends CommandeLigne{
    public CommandeEffacerSousCurseur(Ligne var1) {
        super(var1);
    }

    public void executer(){
        this.ligne.supprimer();
    }

    public boolean estExecutable(){
        return this.ligne.getCurseur() <= this.ligne.getLongueur();
    }

}
