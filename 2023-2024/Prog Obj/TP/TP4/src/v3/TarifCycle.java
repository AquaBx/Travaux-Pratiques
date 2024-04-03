package v3;

public class TarifCycle extends Tarif<Cycle> {
    protected static Float tarifFixe = 0.0f;
    private static TarifCycle instance;

    TarifCycle() {
        super();
        setTarifFixe(20f);
    }

    public static TarifCycle getInstance() {
        return instance;
    }

    public static void createSingleton() {
        instance = new TarifCycle();
    }

    public void setTarifFixe(Float t) {
        tarifFixe = t;
    }

    public Float calculerTarif(Cycle c) {
        return tarifPassager + tarifFixe;
    }
}
