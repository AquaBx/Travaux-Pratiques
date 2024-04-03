package v3;

import java.util.Comparator;

public abstract class ComparatorAbs<T> implements Comparator<T> {

    Boolean croissant;

    public ComparatorAbs(boolean croissant) {

        this.croissant = croissant;
    }

    abstract protected Integer doCompare(T o1, T o2);

    public int compare(T o1, T o2) {
        return (croissant ? 1 : -1) * this.doCompare(o1, o2);
    }
}
