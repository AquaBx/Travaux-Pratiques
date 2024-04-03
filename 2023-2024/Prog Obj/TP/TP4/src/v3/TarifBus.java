package v3;

public class TarifBus extends Tarif<Bus> {
    protected static Float tarifFixe = 0.0f;
    protected static Float tarifVar = 0.0f;
    private static TarifBus instance;

    TarifBus() {
        super();
        setTarifFixe(200f);
        setTarifVar(50f);
    }

    public static void setTarifVar(Float t) {
        tarifVar = t;
    }

    public static TarifBus getInstance() {
        return instance;
    }

    public static void createSingleton() {
        instance = new TarifBus();
    }

    public void setTarifFixe(Float t) {
        tarifFixe = t;
    }

    public Float calculerTarif(Bus a) {
        return tarifPassager * a.getPassagers() + tarifFixe + a.getLongueur() * tarifVar;
    }

}
