package v3;

/**
 * Modèle de véhicule
 */
public abstract class IVehicule implements Cloneable, Comparable<IVehicule> {

    private String immatriculation;
    private Integer passagers;

    private Integer longueur;


    IVehicule(String immatriculation, Integer passagers, Integer longueur) {
        this.immatriculation = immatriculation;
        this.passagers = passagers;
        this.longueur = longueur;
    }

    // déterminer la longueur d'un véhicule
    public int getLongueur() {
        return this.longueur;
    }

    // déterminer le nombre de passagers
    public int getPassagers() {
        return this.passagers;
    }

    // connaître l'immatriculation
    public String getImmatriculation() {
        return this.immatriculation;
    }

    // représentation affichable
    public String toString() {
        StringBuilder s = new StringBuilder();

        s.append(String.format("Passagers           : %d \n", this.getPassagers()));
        s.append(String.format("Immatriculation     : %s \n", this.getImmatriculation()));
        s.append(String.format("Longueur            : %d \n", this.getLongueur()));

        return s.toString();
    }

    public int compareTo(IVehicule o) {
        return Integer.compare(this.getLongueur(), o.getLongueur());
    }

    public abstract IVehicule clone();
}
