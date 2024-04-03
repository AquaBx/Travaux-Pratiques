package util;

import org.junit.Assert;
import types.Rationnel;
import rationnel.RationnelSimple;
import rationnel.RationnelCouple;

import java.sql.Array;
import java.util.Scanner;

public class Client {
    public static Rationnel makeRationnel(int num, int den){
        if (num%2 == 0) {
            System.out.println("RationnelSimple");
            return new RationnelSimple(num,den);
        }
        else {
            System.out.println("RationnelCouple");
            return new RationnelCouple(num,den);
        }


    }

    static void afficher(Rationnel[] lesRationnels, int nb){
        for ( int i=0; i < nb; i++ ) {
            Rationnel item = lesRationnels[i];
            System.out.println(item.toString() + " = " + item.valeur());
        }
    }

    static Rationnel sommeRationnel(Rationnel[] lesRationnels, int nb){
        Rationnel sum = lesRationnels[0];

        for ( int i=1; i < nb; i++ ) {
            Rationnel item = lesRationnels[i];
            sum = sum.somme(item);
        }

        return sum;
    }

    static void insererRationnel( Rationnel nouveau, Rationnel[] lesRationnels, int nb){
        lesRationnels[nb] = nouveau;
    }

    static Rationnel lireRationnel(Scanner input){
        System.out.print("Numérateur : ");
        int n = input.nextInt();
        System.out.print("Dénominateur : ");
        int d = input.nextInt();

        return makeRationnel(n,d);
    }

    public static void main(String[] args) {
        Rationnel r = new RationnelCouple(0);
        Scanner sc = new Scanner(System.in);

        Rationnel[] tableau = new Rationnel[30];
        int i = 0;

        while ( true ) {
            Rationnel r30 = lireRationnel(sc);

            if (r30.valeur() == 0){
                break;
            }
            else{

                insererRationnel(r30,tableau,i); i++;

                Rationnel sum = r.somme(r30);
                insererRationnel(sum,tableau,i); i++;

                System.out.print("Somme : " + r + "+" + r30 + " = " + sum.toString() );

                Rationnel inverse = r30.inverse();
                insererRationnel(inverse,tableau,i); i++;

                System.out.print(" ; Inverse : " + inverse.toString() );

                System.out.print(" ; Valeur : " + r30.valeur());

                if ( r30.compareTo(r) > 0 ) {
                    System.out.print(" ; Compare : " + r30 + ">" + r );
                }
                else if ( r30.compareTo(r) < 0 ) {
                    System.out.print(" ; Compare : " + r30 + "<" + r );
                }
                else {
                    System.out.print(" ; Compare : " + r30 + "=" + r );
                }

                System.out.println(" ; Equals : " + r30.equals(r));

                r=r30;
            }

            System.out.println("Tableau");
            afficher(tableau,i);

            System.out.println("Somme du tableau : " + sommeRationnel(tableau,i).toString() );
        }


    }

}
