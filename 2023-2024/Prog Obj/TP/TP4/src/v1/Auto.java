package v1;

public class Auto extends IVehicule {
    private Integer passagers;
    protected Boolean toutTerrain;
    private String immatriculation;
    private final Integer longueur = 2;

    public IVehicule clone() {
        return new Auto(this.passagers,this.toutTerrain,this.immatriculation);
    }

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
        return (this.toutTerrain ? 350 : 100) + 15 * this.getPassagers();
    }

    @Override
    public String toString(){
        StringBuilder s = new StringBuilder();

        s.append( "----------- Voiture -------------\n" );

        s.append( String.format("Passagers           : %d \n",this.getPassagers()) );
        s.append( String.format("Immatriculation     : %s \n",this.getImmatriculation()) );
        s.append( String.format("Tarif               : %.3f € \n",this.calculerTarif()) );
        s.append( String.format("Longueur            : %d \n",this.getLongueur()) );
        s.append( String.format("Tout-Terrain        : %b \n",this.toutTerrain) );

        return s.toString() ;
    }

    public Auto(Integer p, Boolean tt, String i){
        this.passagers = p;
        this.immatriculation = i;
        this.toutTerrain = tt;
    }
}
