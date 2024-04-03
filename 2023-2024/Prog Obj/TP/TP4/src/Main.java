import v1.*;

import java.util.Comparator;
import java.util.Random;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) {
        // Press Alt+Entrée with your caret at the highlighted text to see how
        // IntelliJ IDEA suggests fixing it.

        Ferry fer = new Ferry(100, 700);

        boolean last = true;

        while (last) {
            IVehicule vehicule;
            Random r = new Random();
            float rFloat = r.nextFloat();

            if (rFloat < 0.125) {
                vehicule = new Auto(3, false, "AAA-192-CCC");
            } else if (rFloat < 0.25) {
                vehicule = new Auto(3, true, "AAA-192-TTT");
            } else if (rFloat < 0.375) {
                vehicule = new Ambulance(6, false, "AMB-192-CCC");
            } else if (rFloat < 0.5) {
                vehicule = new Ambulance(4, true, "AMB-192-TTT");
            } else if (rFloat < 0.625) {
                vehicule = new Cycle("CCC-192-AAA");
            } else if (rFloat < 0.75) {
                vehicule = new Cycle("CCC-192-BBB");
            } else if (rFloat < 0.875) {
                vehicule = new Bus(40, 2, "BBB-192-AAA");
            } else {
                vehicule = new Bus(67, 4, "BBB-192-BBB");
            }


            last = fer.ajouter(vehicule);
        }

        fer.trier();

        System.out.println(fer);

        Comparator<IVehicule> cmp1 = new ComparatorTarif(false);
        fer.trier(cmp1);

        System.out.println(fer);

        // trie par taille puis par prix décroissant

        Comparator<IVehicule> cmp2 = Comparator.comparing(IVehicule::getLongueur);
        Comparator<IVehicule> order2 = new ComparatorMulti(cmp2, cmp1);
        fer.trier(order2);

        System.out.println(fer);

        // trie par trois

        Comparator<IVehicule> cmp31 = Comparator.comparing(IVehicule::getLongueur);
        Comparator<IVehicule> cmp32 = new ComparatorTarif(false);
        Comparator<IVehicule> cmp33 = Comparator.comparing(IVehicule::getImmatriculation);

        Comparator<IVehicule> order31 = new ComparatorMulti(cmp32, cmp31);
        Comparator<IVehicule> order32 = new ComparatorMulti(cmp33, order31);

        fer.trier(order32);

        System.out.println(fer);

    }
}