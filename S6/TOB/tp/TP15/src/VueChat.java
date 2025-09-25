import java.util.Observable;
import java.util.Observer;
import javax.swing.JTextArea;

public class VueChat extends JTextArea implements Observer {

    private JTextArea fenetre;

        
    public void update(Observable chat, Object message){
        this.fenetre.append(message.toString());
    }
}   
