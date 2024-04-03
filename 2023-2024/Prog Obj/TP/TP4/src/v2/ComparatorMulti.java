package v2;

import java.util.Comparator;

public class ComparatorMulti implements Comparator<IVehicule> {

    Comparator<IVehicule> cmp1;
    Comparator<IVehicule> cmp2;

    public ComparatorMulti(Comparator<IVehicule> cmp1,Comparator<IVehicule> cmp2){
        this.cmp1 = cmp1;
        this.cmp2 = cmp2;
    }

    @Override
    public int compare(IVehicule o1, IVehicule o2) {
        return Math.min( Math.max( cmp1.compare(o1, o2) * 2 + cmp2.compare(o1, o2) , -1) , 1) ;
    }
}
