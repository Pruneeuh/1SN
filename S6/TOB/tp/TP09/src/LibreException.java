public class LibreException extends Exception{
    public LibreException(){
        super("le créneau est libre, il n'est pas possible d'obtenir le rendez-vous associé");
    }
}
