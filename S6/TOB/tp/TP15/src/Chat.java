import java.util.List;
import java.util.Observer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.Observable;

public class Chat extends Observable implements Iterable<Message> {

	private List<Message> messages;

	public Chat() {
		this.messages = new ArrayList<Message>();
	}

	public void ajouter(Message m) {
		this.messages.add(m);
		this.setChanged();
		this.notifyObservers(m);
	}

	@Override
	public Iterator<Message> iterator() {
		return this.messages.iterator();
	}

}
