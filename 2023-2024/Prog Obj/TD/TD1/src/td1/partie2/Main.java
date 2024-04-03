package partie2;

import partie2.FileTableauSansDec;

import java.io.IOException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws IOException {

        Scanner sc = new Scanner(System.in);
        File<Float> file = new FileTableauSansDec<>(4);

        file.ajouter(1F);
        file.ajouter(2F);
        file.ajouter(3F);
        file.supprimer();
        System.out.println(file.toString());

        file.supprimer();
        System.out.println(file.toString());

        file.ajouter(4F);
        System.out.println(file.toString());

        file.ajouter(5F);
        System.out.println(file.toString());
    }
}