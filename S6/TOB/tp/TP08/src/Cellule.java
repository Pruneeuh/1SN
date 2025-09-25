public class Cellule {
    private int element; 
    private Cellule suivant; 

    public Cellule(int element, Cellule suivant){
        this.element = element; 
        this.suivant = suivant; 
    }

    public int getElement(){
        return this.element;
    }

    public Cellule getSuivant(){
        return this.suivant; 
    }
    
}
