package v2;

import java.util.Comparator;

public class ComparatorCommand implements Comparator<Command> {
    public int compare(Command c1, Command c2){
        return (int) (c1.getTime() - c2.getTime());
    }
}
