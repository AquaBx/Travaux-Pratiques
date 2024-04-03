package v2;

import java.util.Comparator;

public abstract class ComparatorAbs implements Comparator<IVehicule> {

    Boolean croissant;
    public ComparatorAbs(boolean croissant){

        this.croissant = croissant;
    }

    abstract protected Integer doCompare(IVehicule o1, IVehicule o2);

    @Override
    public int compare(IVehicule o1, IVehicule o2) {
        return (croissant ? 1 : -1) * this.doCompare(o1, o2) ;
    }
}
