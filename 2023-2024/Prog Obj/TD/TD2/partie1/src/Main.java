import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static Map<String,Integer> toMapCount (List<Figure> figures){
        Map<String,Integer> map = new HashMap<>();

        for ( Figure item : figures) {
            if ( !map.containsKey( item.genre() ) ) { // map.get(item.genre()) == null
                map.put(item.genre(),0);
            }
            map.put(item.genre(),map.get(item.genre()) + 1);
        }

        return map;
    }


    public static void main(String[] args) {
        Cercle c = new Cercle(1.0,1.0,0.2);
        Rectangle r = new Rectangle(1.0,2.0,1.0,1.0);
        // Figure f = new Figure();
        Figure f2 = new Cercle(1.0, 2.0,2.0);
        // Rectangle r2 = new Cercle(1.0,2.0,0.2);
        // Cercle c2 = f2;

        List<Figure> list = new ArrayList<>(3);

        list.add(c);
        list.add(r);
        list.add(f2);

        Map<String,Integer> map = toMapCount(list);

        System.out.println(map.get("Cercle"));
        System.out.println(map.get("Rectangle"));

    }
}