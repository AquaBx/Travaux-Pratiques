package main;

import tableau.Block;
import types.Tableau;

import java.util.Objects;
import java.util.Random;
import java.util.Scanner;

public class Client {

    public static boolean dichotomie(int a,int b,Integer value,Tableau<Integer> tableau){

        if (b-a == 0){
            return tableau.get(a).equals(value);
        }
        else if (b-a == 1){
            return tableau.get(a).equals(value) || tableau.get(b).equals(value);
        }

        int m = (b+a)/2;

        if ( tableau.get(m) < value ){
            return dichotomie(m,b,value,tableau);
        }
        else {
            return dichotomie(a,m,value,tableau);
        }

    }

    public static boolean estPresent(Integer value,Tableau<Integer> tableau,Integer length){
        return dichotomie(0,length-1,value,tableau);
    }
    public static Integer eliminerPresents(Tableau<Integer> t1,Tableau<Integer> t2 ){
        int count = 0;
        int y = 0;
        for (int j = 0; j < t1.size() ; j++) {
            Integer t1Item = t1.get(j);
            if (estPresent(t1Item,t2,t2.size())) {
                count++;
                System.out.println("Eliminé " + t1Item);
            }
            else{
                t1.set(y, t1Item);
                System.out.println("Gardé " + t1Item);
                y++;
            }
        }

        for (int i = t1.size(); i>y;i--){
            t1.pop_back();
        }

        return count;
    }
    public static Tableau<Integer> remplirHasard(Integer nb){
        Tableau<Integer> tab = new Block<>(nb);
        Random random = new Random();

        for (int i=0; i < nb; i++){
            int value = random.nextInt(nb);
            tab.push_back(value);
        }
        return tab;
    }
    public static boolean estPremier(Integer num, Tableau<Integer> tab){
        for (int i=0;i<tab.size();i++){
            if ( num%tab.get(i) == 0 ) {
                return false;
            }
        }
        return true;
    }

    public static Integer calculerNombresPremiers(Integer n, Tableau<Integer> tab){

        tab.push_back(2);

        int last = 2;

        while ( last < n && !tab.full() ){
            last++;

            if (estPremier(last,tab)){
                tab.push_back( last );
            }

        }


        return last;
    }


    public static void main(String[] args) {

        Tableau<Integer> tab = new Block<>(100);

        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();

        System.out.println("Dernier nombre testé :");
        Integer lastnb = calculerNombresPremiers(n,tab);
        System.out.println(lastnb);

        System.out.println("Nombres premiers trouvés :");
        for (int i=0;i<tab.size();i++){
            System.out.println(tab.get(i));
        }

        System.out.println("Nombres aléatoires :");
        Tableau<Integer> tabrand = remplirHasard(lastnb);
        for (int i=0;i<tabrand.size();i++){
            System.out.println(tabrand.get(i));
        }

        System.out.println("Nombres aléatoires filtrés :");
        eliminerPresents(tabrand,tab);
        for (int i=0;i<tabrand.size();i++){
            System.out.println(tabrand.get(i));
        }

    }


}
