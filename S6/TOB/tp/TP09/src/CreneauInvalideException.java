/**
 * CreneauInvalideException indique qu'une date n'est pas valide.
 */
public class CreneauInvalideException extends RuntimeException {
    public CreneauInvalideException(){
        super("creneau non valide (doit être compirs entre 1 et 366)");
    }
}
