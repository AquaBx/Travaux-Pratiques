package v2;

public class Bus extends IVehicule {

    @Override
    public float calculerTarif() {
        return 200 + 50 * this.getLongueur() + 15 * this.getPassagers();
    }

    @Override
    public String toString(){
        return "------------- Bus ---------------\n" + super.toString() ;
    }

    public IVehicule clone() {
        return new Bus(this.getPassagers(),this.getLongueur(),this.getImmatriculation());
    }

    public Bus(Integer p, Integer l, String i){
        super(i,p,l);
    }

}
