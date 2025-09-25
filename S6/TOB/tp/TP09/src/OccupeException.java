public class OccupeException extends Exception{
    public OccupeException(){
        super("créneau déjà occupé, il ne peut y avoir qu'un rendez-vous par créneau");
    }
}
