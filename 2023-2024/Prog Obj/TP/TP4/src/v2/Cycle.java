package v2;

public class Cycle extends IVehicule {

    @Override
    public float calculerTarif() {
        return 20 + 15;
    }

    public IVehicule clone() {
        return new Cycle(this.getImmatriculation());
    }

    @Override
    public String toString() {
        return "------------ Cycle --------------\n" + super.toString();
    }

    public Cycle(String i){
        super(i,1,1);
    }
}
