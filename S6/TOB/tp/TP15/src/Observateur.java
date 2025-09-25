import java.util.Observable;
import java.util.Observer;

public class Observateur implements Observer{
    
    public Observateur(Chat chat) {
        chat.addObserver(this);
    }

    @Override
    public void update(Observable chat, Object message){
        System.out.println(message.toString());
    }
}
