import v3.*;

import java.util.Comparator;
import java.util.HashMap;
import java.util.Random;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main3 {


    public static void main(String[] args) {
        // Press Alt+Entrée with your caret at the highlighted text to see how
        // IntelliJ IDEA suggests fixing it.

        Ferry fer = new Ferry(20, 700);

        TarifCycle.createSingleton();
        TarifAmbulance.createSingleton();
        TarifAuto.createSingleton();
        TarifCycle.createSingleton();
        TarifBus.createSingleton();

        boolean last = true;

        while (last) {
            IVehicule vehicule;
            Tarif tarif;
            Random r = new Random();
            float rFloat = r.nextFloat();

            if (rFloat < 0.125) {
                vehicule = new Auto(3, false, "AAA-192-CCC");
                fer.mapPut("AAA-192-CCC", TarifAuto.getInstance());
            } else if (rFloat < 0.25) {
                vehicule = new Auto(3, true, "AAA-192-TTT");
                fer.mapPut("AAA-192-TTT", TarifAuto.getInstance());
            } else if (rFloat < 0.375) {
                vehicule = new Ambulance(6, false, "AMB-192-CCC");
                fer.mapPut("AMB-192-CCC", TarifAmbulance.getInstance());
            } else if (rFloat < 0.5) {
                vehicule = new Ambulance(4, true, "AMB-192-TTT");
                fer.mapPut("AMB-192-TTT", TarifAmbulance.getInstance());

            } else if (rFloat < 0.625) {
                vehicule = new Cycle("CCC-192-AAA");
                fer.mapPut("CCC-192-AAA", TarifCycle.getInstance());
            } else if (rFloat < 0.75) {
                vehicule = new Cycle("CCC-192-BBB");
                fer.mapPut("CCC-192-BBB", TarifCycle.getInstance());
            } else if (rFloat < 0.875) {
                vehicule = new Bus(40, 2, "BBB-192-AAA");
                fer.mapPut("BBB-192-AAA", TarifBus.getInstance());
            } else {
                vehicule = new Bus(67, 4, "BBB-192-BBB");
                fer.mapPut("BBB-192-BBB", TarifBus.getInstance());
            }

            last = fer.ajouter(vehicule);

        }

        fer.trier();

        System.out.println(fer);

        System.out.println("\n \n Modif \n \n");


        Tarif.setTarifPassager(15f * 1.1f);

        System.out.println(fer);


        System.out.println("\n \n Modif \n \n");

        TarifAuto.setTarifVar(350f * 2);

        System.out.println(fer);


    }
}