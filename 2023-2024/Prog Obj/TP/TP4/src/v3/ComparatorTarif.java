package v3;

import java.util.Comparator;

public class ComparatorTarif extends ComparatorAbs<Float> {

    public ComparatorTarif() {
        super(true);
    }

    public ComparatorTarif(Boolean croissant) {
        super(croissant);
    }

    @Override
    protected Integer doCompare(Float o1, Float o2) {
        return Float.compare(o1, o2);
    }
}
