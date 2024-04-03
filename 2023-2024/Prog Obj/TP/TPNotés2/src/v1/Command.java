package v1;

import java.util.ArrayList;
import java.util.List;

public class Command {

    private long time = 0;
    private List<Orderable> listeOrd = new ArrayList<>();

    public void add(Orderable el){
        listeOrd.add(el);
    }

    public List<Orderable> getListeOrd(){
        // pour vérifier dans le main que tout marche bien, pas nécessaire
        return this.listeOrd;
    }

    public long getTime(){
        return this.time;
    }

    public double total(){
        double s = 0;
        for (Orderable el : listeOrd){
            s += el.getCost();
        }
        return s;
    }

    public Command() {
        this.time = System.currentTimeMillis();
    }
}
