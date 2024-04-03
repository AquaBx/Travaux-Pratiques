package v2;

public class Ambulance extends Auto {
    public Ambulance(Integer p, Boolean tt, String i) {
        super(p, tt, i);
    }

    @Override
    public float calculerTarif() {
        Float _re = super.calculerTarif();

        return 0f;
    }

    @Override
    public IVehicule clone() {
        return new Ambulance(super.getPassagers(), super.toutTerrain, super.getImmatriculation());
    }

    @Override
    public String toString(){
        String[] t = super.toString().split("\n");
        t[0] = "---------- Ambulance ------------";
        return String.join("\n", t) + "\n";
    }


}
