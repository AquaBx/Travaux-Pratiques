public class Racine {
    /**
     2 * Calculer une valeur approchee de la racine carree d’un nombre
     3 * @param r : reel dont on veut calculer la carree r >= 0
     4 * @param epsilon : precision du calcul epsilon > 0
     5 * @return un real a, valeur approchee a epsilon pres de racine_carre de r
     6 */
    public static double racineCarree ( double r , double epsilon ) {

        if (r < 0 || epsilon <= 0) {
            throw new AssertionError();
        }

        double xn = 1;

        while (xn*xn-r >= epsilon || r-xn*xn >= epsilon ) {
            xn = (xn + r/xn)/2;
        }

// vous devez implementer cette fonction
// Implementer des conditions sur la validite des parametres : r >= 0 et epsilon > 0
// si les conditions initiales ne sont pas respectees , votre programme devra retourner une erreur


        return xn;
    }

    public static void main(String [] args)
    {
        System.out.println( racineCarree(0,1e-12));
    }
}



