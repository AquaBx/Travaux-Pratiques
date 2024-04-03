package v3;

import java.util.*;

/**
 * Un ferry transporte des véhicules
 */
public class Ferry {
    // attributs
    private Integer longueurMax;
    private Integer passagersMax;

    private HashMap<String, Tarif> map = new HashMap<>();

    private List<IVehicule> cargaison = new ArrayList<>(); // LinkedList

    public Ferry(int lMax, int pMax) {
        this.longueurMax = lMax;
        this.passagersMax = pMax;
    }

    public void mapPut(String imat, Tarif tarif) {
        map.put(imat, tarif);
    }

    // accesseurs
    public int getCapaLongueur() {
        return this.longueurMax;
    }

    public int getCapaPassagers() {
        return this.passagersMax;
    }

    public int getLongueur() {
        int sum = 0;
        for (IVehicule v : cargaison) {
            sum += v.getLongueur();
        }
        return sum;
    }

    public void trier() {
        Collections.sort(this.cargaison);
    }

    public void trier(Boolean croissant) {
        Collections.sort(this.cargaison);
        if (!croissant) {
            this.cargaison.reversed();
        }
    }

    public void trier(Comparator<IVehicule> comparator) {
        Collections.sort(this.cargaison, comparator);
    }

    public int getPassagers() {
        int sum = 0;
        for (IVehicule v : cargaison) {
            sum += v.getPassagers();
        }
        return sum;
    }


    public Integer getLongueurDispo() {
        return this.getCapaLongueur() - this.getLongueur();
    }

    public Integer getPlacesDispo() {
        return this.getCapaPassagers() - this.getPassagers();
    }

    /**
     * ajouter un véhicule dans le ferry.
     * sans effet s'il n'y a plus de place
     *
     * @param v : véhicule à ajouter
     * @return vrai si l'ajout a eu lieu, faux sinon
     */

    public boolean ajouter(IVehicule v) {
        if (v.getLongueur() <= getLongueurDispo() && v.getPassagers() <= this.getPlacesDispo()) {
            cargaison.add(v.clone());
            return true;
        }

        return false;
    }

    // calculer le tarif de l'ensemble des véhicules présents dans le ferry
    public float calculerTarif() {
        float sum = 0f;
        for (IVehicule v : cargaison) {
            sum += map.get(v.getImmatriculation()).calculerTarif(v);
        }
        return sum;
    }

    // représentation affichable du ferry
    public String toString() {
        StringBuilder s = new StringBuilder();

        s.append("---------- Cargaison ------------\n\n");

        for (IVehicule v : cargaison) {
            s.append(v.toString());
            s.append(String.format("Tarif               : %.3f\n", map.get(v.getImmatriculation()).calculerTarif(v)));
        }

        s.append("\n--------------------------------\n\n");

        s.append(String.format("Longueur disponible : %d \n", this.getLongueurDispo()));
        s.append(String.format("Places disponibles  : %d \n", this.getPlacesDispo()));
        s.append(String.format("Tarif total         : %.3f €\n", this.calculerTarif()));

        return s.toString();
    }
}
