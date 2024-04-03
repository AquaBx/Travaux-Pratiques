package v1;

import java.util.Comparator;

public class ComparatorTarif implements Comparator<IVehicule> {

    Boolean croissant;
    public ComparatorTarif(){
        this.croissant = true;
    }

    public ComparatorTarif(boolean croissant){
        this.croissant = croissant;
    }

    @Override
    public int compare(IVehicule o1, IVehicule o2) {
        return (croissant ? 1 : -1) * Float.compare( o1.calculerTarif() , o2.calculerTarif() ) ;
    }
}
