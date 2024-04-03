package v3;

public class TarifAmbulance extends Tarif<Ambulance> {

    private static TarifAmbulance instance;

    TarifAmbulance() {
        super();
    }

    public static TarifAmbulance getInstance() {
        return instance;
    }

    public static void createSingleton() {
        instance = new TarifAmbulance();
    }

    public Float calculerTarif(Ambulance a) {
        return 0f;
    }
}