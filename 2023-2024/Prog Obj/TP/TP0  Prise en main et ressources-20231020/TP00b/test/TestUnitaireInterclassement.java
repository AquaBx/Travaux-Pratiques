import java.util.Arrays;

import org.junit.Assert;
import org.junit.Test;

// test interclassement
public class TestUnitaireInterclassement
{

  public int [] AppelAlgo(int [] t1, int [] t2)
  {
    // À MODIFIER SELON NOM DE LA CLASSE À TESTER
    return TriDicho.interclasser(t1, t1.length, t2, t2.length);
  }

  //------------------------------------------------------------
  // RIEN À MODIFIER PLUS BAS
  //------------------------------------------------------------

  @Test(timeout=10)
  public void testInterclassement_t1t2_vides()
  {
    System.out.print("\nInterclassement deux tableaux vides	: ");
    int [] t1 = { };
    int [] t2 = { };
    int [] oracle = {  };
    int [] a_tester = AppelAlgo(t2, t1);
    Assert.assertArrayEquals(oracle, a_tester);
    System.out.println("Test réussi");
  }

  @Test(timeout=10)
  public void testInterclassement_t1_vide()
  {
    System.out.print("\nInterclassement premier tableau vide	: ");
    int [] t1 = { };
    int [] t2 = {
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 11, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 18, 19, 20, 21, 21, 22, 22, 23, 24, 25, 27, 28, 29, 29, 30, 31, 35, 43, 45, 48, 51, 55, 77, 88, 88, 88, 482, 579, 609, 617, 650, 650, 669, 702, 725, 738, 778, 797, 802, 802, 802, 805, 813, 823, 830, 848, 871, 896, 921, 933, 946
    };
    int [] oracle = Arrays.copyOf(t2, t2.length);
    int [] a_tester   = AppelAlgo(t1, t2);
    Assert.assertArrayEquals(oracle, a_tester);
    System.out.println("Test réussi");
  }

  @Test(timeout=10)
  public void testInterclassement_t2_vide()
  {
    System.out.print("\nInterclassement deuxième tableau vide	: ");
    int [] t1 = {
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 11, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 18, 19, 20, 21, 21, 22, 22, 23, 24, 25, 27, 28, 29, 29, 30, 31, 35, 43, 45, 48, 51, 55, 77, 88, 88, 88, 482, 579, 609, 617, 650, 650, 669, 702, 725, 738, 778, 797, 802, 802, 802, 805, 813, 823, 830, 848, 871, 896, 921, 933, 946
    };
    int [] t2 = { };
    int [] oracle = Arrays.copyOf(t1, t1.length);
    int [] a_tester = AppelAlgo(t1, t2);
    Assert.assertArrayEquals(oracle, a_tester);
    System.out.println("Test réussi");
  }

  @Test(timeout=20)
  public void testInterclassement_bizarre()
  {
    System.out.print("\nInterclassement bizarre			: ");
    int [] t1 = {
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 11, 12
    };
    int [] t2 = { 
      12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 18, 19, 20, 21, 21, 22, 22, 23, 24, 25, 27, 28, 29, 29, 30, 31, 35, 43, 45, 48, 51, 55, 77, 88, 88, 88, 482, 579, 609, 617, 650, 650, 669, 702, 725, 738, 778, 797, 802, 802, 802, 805, 813, 823, 830, 848, 871, 896, 921, 933, 946
    };
    int [] oracle = {
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 11, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 18, 19, 20, 21, 21, 22, 22, 23, 24, 25, 27, 28, 29, 29, 30, 31, 35, 43, 45, 48, 51, 55, 77, 88, 88, 88, 482, 579, 609, 617, 650, 650, 669, 702, 725, 738, 778, 797, 802, 802, 802, 805, 813, 823, 830, 848, 871, 896, 921, 933, 946
    };
    int [] a_tester = AppelAlgo(t1, t2);
    Assert.assertArrayEquals(oracle, a_tester);
    System.out.println("Test réussi");
  }

  @Test(timeout=10)
  public void testInterclassement_normal()
  {
    System.out.print("\nInterclassement cas normal		: ");
    int [] t1 = {
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 11, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 18, 19, 20, 21, 21, 22, 22, 23, 24, 25, 27, 28, 29, 29, 30, 31, 35, 43, 45, 48, 51, 55, 77, 88, 88, 88, 482, 579, 609, 617, 650, 650, 669, 702, 725, 738, 778, 797, 802, 802, 802, 805, 813, 823, 830, 848, 871, 896, 921, 933, 946
    };
    int [] t2 = {
      -5, 6, 15, 15, 15, 15, 15, 15, 19, 22, 22, 26, 29, 31, 35, 802, 802, 802, 823, 830, 999, 1500
    };
    int [] oracle = {
      -5, 0, 1, 2, 3, 4, 5, 6, 6, 7, 8, 9, 10, 10, 10, 11, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 18, 19, 19, 20, 21, 21, 22, 22, 22, 22, 23, 24, 25, 26, 27, 28, 29, 29, 29, 30, 31, 31, 35, 35, 43, 45, 48, 51, 55, 77, 88, 88, 88, 482, 579, 609, 617, 650, 650, 669, 702, 725, 738, 778, 797, 802, 802, 802, 802, 802, 802, 805, 813, 823, 823, 830, 830, 848, 871, 896, 921, 933, 946, 999, 1500
    };
    int [] a_tester = AppelAlgo(t1, t2);
    Assert.assertArrayEquals(oracle, a_tester);
    System.out.println("Test réussi");
  }

  @Test(timeout=400)
  public void deux_tableaux_hasard()
  {
    System.out.print("\nInterclassement deux tableaux au hasard	: ");
    int [] t1 = TestUnitaireTriInsertion.initialiserTableau(100000);
    Arrays.sort(t1);
    int [] t2 = TestUnitaireTriInsertion.initialiserTableau(100000);
    Arrays.sort(t2);

    // interclasser les deux tableaux
    int [] a_tester = AppelAlgo(t1, t2);

    // fabriquer le résultat attendu
    int [] oracle = new int[t1.length + t2.length];
    // copier le contenu de t1 et de t2 dans oracle
    for (int i = 0 ; i < t1.length; ++i) { oracle[i] = t1[i]; }
    for (int i = 0 ; i < t2.length; ++i) { oracle[i + t1.length] = t2[i]; }
    Arrays.sort(oracle);

    // comparer le résultat attendu avec le résultat obtenu
    Assert.assertArrayEquals(oracle, a_tester);
    System.out.println("Test réussi");
  }
}
