package v3;

public class Bus extends IVehicule {

    public Bus(Integer p, Integer l, String i) {
        super(i, p, l);
    }

    @Override
    public String toString() {
        return "------------- Bus ---------------\n" + super.toString();
    }

    public IVehicule clone() {
        return new Bus(this.getPassagers(), this.getLongueur(), this.getImmatriculation());
    }

}
