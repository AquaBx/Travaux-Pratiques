package v1;
/**
 * Modèle de véhicule
 */
public abstract class IVehicule implements Cloneable,Comparable<IVehicule> {
  // déterminer la longueur d'un véhicule
  public abstract int getLongueur();

  // déterminer le nombre de passagers
  public abstract int getPassagers();

  // connaître l'immatriculation
  public abstract String getImmatriculation();

  // représentation affichable
  public abstract String toString();

  // calculer le tarif du véhicule
  public abstract float calculerTarif();

  @Override
  public abstract IVehicule clone();


  @Override
  public int compareTo(IVehicule o) {
    return Integer.compare(this.getLongueur(),o.getLongueur());
  }

}