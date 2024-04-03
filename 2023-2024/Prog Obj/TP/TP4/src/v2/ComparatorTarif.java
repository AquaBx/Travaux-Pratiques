package v2;

import java.util.Comparator;

public class ComparatorTarif extends ComparatorAbs {

    public ComparatorTarif(){
        super(true);
    }

    public ComparatorTarif(Boolean croissant ){
        super(croissant);
    }

    @Override
    protected Integer doCompare(IVehicule o1, IVehicule o2) {
        return Float.compare( o1.calculerTarif() , o2.calculerTarif() );
    }
}
