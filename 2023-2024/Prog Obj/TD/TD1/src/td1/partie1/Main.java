package partie1;

import partie1.FileTableau;

import java.io.IOException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws IOException {

        Scanner sc = new Scanner(System.in);
        File file = new FileTableau(5);
        float x = 0F;

        while (!(file.estPleine())) {
            x = sc.nextFloat();

            if (x < 0F) {
                break;
            }
            file.ajouter(x);
            System.out.println(file.toString());

        }

        while (!file.estVide()) {
            System.out.println(file.toString());

            file.supprimer();

        }


    }
}