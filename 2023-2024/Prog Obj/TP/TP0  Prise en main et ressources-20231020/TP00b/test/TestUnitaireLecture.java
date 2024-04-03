import java.io.ByteArrayInputStream;
import java.util.Scanner;

import org.junit.Assert;
import org.junit.Test;

//------------------------------------------------------------
//		RIEN À MODIFIER
//------------------------------------------------------------

public class TestUnitaireLecture
{

  /**
     Pour tester la fonction de lecture, on va simuler l'opération de saisie : 
     => On initialise un scanner d'entrée avec une suite de nombres prédéfinie
     => voir fonction init_input_scanner
   */

  public int AppelAlgo(int [] t, Scanner s)
  {
    return TriDicho.lireTableau(t, -1, s);
  }

  @Test
  // suite saisie vide
  public void testLireTableauSuiteVide()
  {
    System.out.print("\nLecture suite vide		: ");
    // générer les données d'entrée
    int [] oracle = { };
    int [] a_tester = new int[oracle.length];

    // générer le scanner d'entrée puis effectuer la lecture
    int	nbval = AppelAlgo(a_tester, init_input_scanner(oracle, -1));

    // Vérifier le nombre d'éléments dans le tableau a_tester
    Assert.assertTrue(
		      oracle.length + " attendu mais " + nbval + " reçu",
		      oracle.length == nbval);

    // vérifier les valeurs du tableau a_tester
    arrayEquals(oracle, a_tester, oracle.length);
    System.out.println("Test réussi");
  }

  // longueur suite < capacité tableau
  @Test
  public void testLireTableauNonRempli()
  {
    System.out.print("\nLecture tableau non rempli	: ");
    // générer les données d'entrée
    int [] oracle = {
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
    };
    int [] a_tester = new int[oracle.length * 10];

    // générer le scanner d'entrée puis effectuer la lecture
    int	nbval = AppelAlgo(a_tester, init_input_scanner(oracle, -1));

    // Vérifier le nombre d'éléments dans le tableau a_tester
    Assert.assertTrue(
		      oracle.length + " attendu mais " + nbval + " reçu",
		      oracle.length == nbval);

    // vérifier les valeurs du tableau a_tester
    arrayEquals(oracle, a_tester, oracle.length);
    System.out.println("Test réussi");
  }

  // longueur suite >= capacité tableau
  @Test
  public void testLireTableauTableauRempli()
  {
    System.out.print("\nLecture tableau rempli		: ");
    // générer les données d'entrée
    int [] oracle = {
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
    };
    int [] a_tester = new int[oracle.length / 2];

    // générer le scanner d'entrée puis effectuer la lecture
    int	nbval = AppelAlgo(a_tester, init_input_scanner(oracle, -1));

    // Vérifier le nombre d'éléments dans le tableau a_tester
    Assert.assertTrue(
		      a_tester.length + " attendu mais " + nbval + " reçu",
		      a_tester.length == nbval);

    // vérifier les valeurs du tableau a_tester
    arrayEquals(oracle, a_tester, a_tester.length);
    System.out.println("Test réussi");
  }

  // initialiser un scanner d'entrée dans lequel lire les données
  // du tableau numbers suivies de end_value
  static Scanner
    init_input_scanner(int [] numbers, int end_value)
  {
    // fabriquer une chaîne de caractères avec les nombres du tableau numbers
    StringBuilder formattedData = new StringBuilder();
    for (int v : numbers) { formattedData.append("" + v + " "); }
    formattedData.append("" + end_value);

    // en faire un tableau d'octets
    byte [] dataBytes = formattedData.toString().getBytes();

    // initialiser un scanner d'entrée avec le tableau d'octets
    return new Scanner(new ByteArrayInputStream(dataBytes));
  }

  // vérifier les valeurs des num premiers éléments du tableau a_tester
  // le tableau oracle contient les valeurs attendues
  static void
    arrayEquals(int [] oracle, int [] a_tester, int num)
  {
    for (int i = 0; i < num; ++i) {
      Assert.assertTrue(
			oracle[i] + " attendu mais " + a_tester[i] + " reçu",
			oracle[i] == a_tester[i]);
    }
  }
}
