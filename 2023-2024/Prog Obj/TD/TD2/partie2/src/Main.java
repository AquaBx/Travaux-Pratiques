import java.util.Comparator;

public class Main {

    public static Comparator<SpecifArticle> DesignationComparator(){
        return Comparator.comparing(SpecifArticle::getDesignation);
    }

    public static Comparator<SpecifArticle> DesignationComparator(boolean reversed){
        if (reversed){
            return DesignationComparator().reversed();
        }
        return DesignationComparator();
    }
    public static Comparator<SpecifArticle> PrixHTComparator(){
        return Comparator.comparing(SpecifArticle::getPrixHT);
    }

    public static Comparator<SpecifArticle> PrixHTComparator(boolean reversed){
        if (reversed){
            return PrixHTComparator().reversed();
        }
        return PrixHTComparator();
    }

    public static Comparator<SpecifArticle> PrixTTCComparator(){
        return Comparator.comparing(SpecifArticle::getPrixTTC);
    }

    public static Comparator<SpecifArticle> PrixTTCComparator(boolean reversed){
        if (reversed){
            return PrixTTCComparator().reversed();
        }
        return PrixTTCComparator();
    }

    public static Comparator<SpecifArticle> QuantiteComparator(){
        return Comparator.comparing(SpecifArticle::getQuantite);
    }

    public static Comparator<SpecifArticle> QuantiteComparator(boolean reversed){
        if (reversed){
            return QuantiteComparator().reversed();
        }
        return QuantiteComparator();
    }

    public static void main(String[] args) {
        Article art = new Article (" Lampe ", 10 , 58.50) ;
        Article livre = new Livre ("Le seigneur des anneaux", 200 , 24.30, 654, "2 7457 1234 7") ;

        Catalogue cat = new Catalogue(new Article[]{art, livre});

        cat.afficher();

        cat.trier(PrixHTComparator());

        cat.afficher();


    }
}