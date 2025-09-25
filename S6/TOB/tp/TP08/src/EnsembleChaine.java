public class EnsembleChaine implements Ensemble {
    private int cardinal;  
    private Cellule celluleDepart;

    public EnsembleChaine(){
        this.celluleDepart = null;
        this.cardinal = 0;
    }

    public EnsembleChaine(int premierElement){
        Cellule premiereCellule = new Cellule(premierElement, null);
        this.celluleDepart = premiereCellule;
        this.cardinal = 1; 
    }

    public int cardinal() {
        return this.cardinal;
    }

    public boolean estVide(){
        return this.cardinal == 0;
    }

    public boolean contient(int x){
        Cellule curseur = celluleDepart; 
        while (curseur != null) {
            if (curseur.getElement()==x) {
                return true;
            }
            else { 
                curseur = curseur.getSuivant();
            }
        return false;
        }
    }

    public void ajouter(int x){
        if (!this.contient(x)){
            Cellule nouvelleCellule = new Cellule(x, this.celluleDepart);
            this.celluleDepart = nouvelleCellule; 
            this.cardinal ++; 
        }
    }

    public void supprimer(int x){
        
    }

}