package v2;

public class Auto extends IVehicule {
    protected Boolean toutTerrain;

    public IVehicule clone() {
        return new Auto(this.getPassagers(),this.toutTerrain,this.getImmatriculation());
    }

    @Override
    public float calculerTarif() {
        return (this.toutTerrain ? 350 : 100) + 15 * this.getPassagers();
    }

    @Override
    public String toString(){
        return "----------- Voiture -------------\n" + super.toString() + String.format("Tout-Terrain        : %b \n",this.toutTerrain) ;
    }

    public Auto(Integer p, Boolean tt, String i){
        super(i,p,2);
        this.toutTerrain = tt;
    }
}
