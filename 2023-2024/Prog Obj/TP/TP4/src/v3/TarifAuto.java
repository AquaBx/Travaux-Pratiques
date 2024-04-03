package v3;

public class TarifAuto extends Tarif<Auto> {

    protected static Float tarifFixe = 0.0f;
    protected static Float tarifVar = 0.0f;
    private static TarifAuto instance;
    Boolean tt;

    TarifAuto() {
        super();
        setTarifFixe(100f);
        setTarifVar(350f);
    }

    public static void setTarifVar(Float t) {
        tarifVar = t;
    }

    public static TarifAuto getInstance() {
        return instance;
    }

    public static void createSingleton() {

        instance = new TarifAuto();
    }

    public void setTarifFixe(Float t) {
        tarifFixe = t;
    }

    public Float calculerTarif(Auto a) {

        return (a.toutTerrain ? tarifVar : tarifFixe) + tarifPassager * a.getPassagers();
    }
}
