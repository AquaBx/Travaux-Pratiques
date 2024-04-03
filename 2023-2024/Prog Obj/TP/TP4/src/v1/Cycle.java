package v1;

public class Cycle extends IVehicule {

    String immatriculation;
    @Override
    public int getLongueur() {
        return 1;
    }

    @Override
    public int getPassagers() {
        return 1;
    }

    @Override
    public String getImmatriculation() {
        return this.immatriculation;
    }

    @Override
    public float calculerTarif() {
        return 20 + 15;
    }

    @Override
    public String toString(){
        StringBuilder s = new StringBuilder();

        s.append( "------------ Cycle --------------\n" );

        s.append( String.format("Passagers           : %d \n",this.getPassagers()) );
        s.append( String.format("Immatriculation     : %s \n",this.getImmatriculation()) );
        s.append( String.format("Tarif               : %.3f € \n",this.calculerTarif()) );
        s.append( String.format("Longueur            : %d \n",this.getLongueur()) );

        return s.toString() ;
    }


    public IVehicule clone() {
        return new Cycle(this.immatriculation);
    }
    public Cycle(String i){
        this.immatriculation = i;
    }
}
