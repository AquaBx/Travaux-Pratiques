package v3;

import v3.IVehicule;

public abstract class Tarif<T> {
    protected static Float tarifPassager = 15.0f;

    public static void setTarifPassager(Float t) {
        tarifPassager = t;
    }

    public abstract Float calculerTarif(T a);
}
