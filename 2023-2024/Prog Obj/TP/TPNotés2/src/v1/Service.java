package v1;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.ArrayList;

public class Service {
    private List<Command> listeCom = new ArrayList<>();

    public void add(Command el){
        listeCom.add(el);
    }

    public List<Command> getCommands(){
        return listeCom;
    }

    public double getRevenues(){
        double s = 0;
        for (Command el : getCommands()){
            s += el.total();
        }
        return s;
    }

    public List<Command> getCommandsByTime() {
        Comparator<Command> cmp = new ComparatorCommand();
        Collections.sort(this.listeCom, cmp );
        return this.listeCom;
    }
}