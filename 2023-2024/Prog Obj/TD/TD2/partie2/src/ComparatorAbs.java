import java.util.Comparator;

public abstract class ComparatorAbs<T> implements Comparator<T> {

    private final boolean reversed;

    public ComparatorAbs(){
        this.reversed = false;
    }

    public ComparatorAbs(boolean reversed){
        this.reversed = reversed;
    }

    public abstract int compareCroissant(T o1, T o2);

    @Override
    public int compare(T o1, T o2) {
        return (reversed ? -1 : 1 ) * compareCroissant(o1, o2);
    }
}

