package v3;

public class Auto extends IVehicule {
    protected Boolean toutTerrain;

    public Auto(Integer p, Boolean tt, String i) {
        super(i, p, 2);
        this.toutTerrain = tt;
    }

    public IVehicule clone() {
        return new Auto(this.getPassagers(), this.toutTerrain, this.getImmatriculation());
    }

    @Override
    public String toString() {
        return "----------- Voiture -------------\n" + super.toString() + String.format("Tout-Terrain        : %b \n", this.toutTerrain);
    }
}
