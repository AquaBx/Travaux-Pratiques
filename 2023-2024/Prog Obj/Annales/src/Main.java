import java.util.ArrayList;
import java.util.List;


// Press Shift twice to open the Searcrh Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) {
       String str = "0100011111";
       char check = '0';
       List<Integer> T = new ArrayList<>();
       int y = 0;
       T.add(0);

       for (int i = 0; i < str.length(); i++){
           if(! (check == str.charAt(i)) ){
               y ++;
               check = str.charAt(i);
               T.add(1);
           }
           else{
               T.set(y,T.get(y)+1);
           }
       }

        System.out.print(T.get(0) + " " + T.get(1) + " "+ T.get(2) + " "+ T.get(3) + " ");

    }
}