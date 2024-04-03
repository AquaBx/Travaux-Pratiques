package v1;

public class Bus extends IVehicule {
    private Integer passagers;
    private String immatriculation;
    private Integer longueur;


    @Override
    public int getLongueur() {
        return this.longueur;
    }

    @Override
    public int getPassagers() {
        return this.passagers;
    }

    @Override
    public String getImmatriculation() {
        return this.immatriculation;
    }

    @Override
    public float calculerTarif() {
        return 200 + 50 * this.getLongueur() + 15 * this.getPassagers();
    }

    @Override
    public String toString(){
        StringBuilder s = new StringBuilder();

        s.append( "------------- Bus ---------------\n" );

        s.append( String.format("Passagers           : %d \n",this.getPassagers()) );
        s.append( String.format("Immatriculation     : %s \n",this.getImmatriculation()) );
        s.append( String.format("Tarif               : %.3f € \n",this.calculerTarif()) );
        s.append( String.format("Longueur            : %d \n",this.getLongueur()) );

        return s.toString() ;
    }


    public IVehicule clone() {
        return new Bus(this.passagers,this.longueur,this.immatriculation);
    }
    public Bus(Integer p, Integer l, String i){
        this.passagers = p;
        this.immatriculation = i;
        this.longueur = l;
    }

}
