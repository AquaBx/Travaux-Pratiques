package v1;
import java.util.concurrent.TimeUnit;
// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) throws InterruptedException {

        Service ser = new Service();

        Command com2 = new Command();
        TimeUnit.SECONDS.sleep(1);

        Command com1 = new Command();

        Orderable menu1 = new Menu();
        Orderable menu2 = new Menu();
        Orderable menu3 = new Menu();


        com1.add(menu1);
        com1.add(menu2);

        com2.add(menu3);

        ser.add(com1);
        ser.add(com2);

        for (Command it: ser.getCommandsByTime()){
            System.out.println("Commande --------------");

            for (Orderable it2: it.getListeOrd()){
                System.out.println(it2.getName());
                System.out.println(it2.getCost());

            }
            System.out.println("--------------");


            System.out.println(it.getTime());
            System.out.println(it.total());
            System.out.println("--------------");

        }

        System.out.println(ser.getRevenues());


    }
}