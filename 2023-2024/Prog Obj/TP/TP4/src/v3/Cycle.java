package v3;

public class Cycle extends IVehicule {

    public Cycle(String i) {
        super(i, 1, 1);
    }

    public IVehicule clone() {
        return new Cycle(this.getImmatriculation());
    }

    @Override
    public String toString() {
        return "------------ Cycle --------------\n" + super.toString();
    }
}
