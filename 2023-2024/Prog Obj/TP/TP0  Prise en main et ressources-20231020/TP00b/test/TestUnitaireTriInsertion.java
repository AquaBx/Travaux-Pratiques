import java.util.Arrays;
import java.util.Random;

import org.junit.Assert;
import org.junit.Test;

// test tri insertion

//------------------------------------------------------------
//		RIEN À MODIFIER
// ------------------------------------------------------------

public class TestUnitaireTriInsertion
{

  public void AppelAlgoTri(int [] t)
  {
    TriDicho.trierInsertion(t, t.length);
  }

  @Test(timeout=10)
  public void tableau_vide()
  {
    System.out.print("\nTri tableau vide			 : ");
    int [] aTester = {  };
    int [] oracle  = {  };

    // trier le tableau aTester
    AppelAlgoTri(aTester);
    // vérifier les résultats
    Assert.assertArrayEquals(oracle, aTester);
    System.out.println("Test réussi");
  }

  @Test(timeout=10)
  public void tableau_un_element()
  {
    System.out.print("\nTri tableau d'un élément		 : ");
    int [] aTester = { 999 };
    int [] oracle  = { 999 };

    // trier le tableau aTester
    AppelAlgoTri(aTester);
    // vérifier les résultats
    Assert.assertArrayEquals(oracle, aTester);
    System.out.println("Test réussi");
  }

  @Test(timeout=10)
  public void tableau_deux_elements()
  {
    System.out.print("\nTri tableau de 2 éléments		 : ");
    int [] aTester = { 999, 111 };
    int [] oracle  = { 111, 999 };

    // trier le tableau aTester
    AppelAlgoTri(aTester);
    // vérifier les résultats
    Assert.assertArrayEquals(oracle, aTester);
    System.out.println("Test réussi");
  }

  @Test(timeout=10)
  public void tableau_quelconque()
  {
    System.out.print("\nTri tableau quelconque			 : ");
    int [] aTester = {
      25, 15, 482, 10, 15, 778, 43, 77, 88, 29, 15, 725, 4, 15, 738, 13, 15, 823, 15, 15, 802, 19, 15, 830, 31, 15, 802, 35, 22, 22, 6, 15, 802, 29, 12, 12, 9, 21, 48, 27, 13, 579, 5, 13, 609, 8, 13, 617, 12, 13, 650, 2, 13, 669, 14, 13, 650, 11, 13, 702, 51, 88, 88, 20, 13, 797, 10, 10, 55, 23, 13, 805, 24, 13, 813, 28, 13, 848, 18, 13, 871, 21, 13, 896, 30, 13, 921, 3, 13, 933, 1, 13, 946, 7, 14, 45, 0
    };
    // faire une copie du tableau de nombres avant tri
    int [] oracle = Arrays.copyOf(aTester, aTester.length); 

    // trier le tableau aTester
    AppelAlgoTri(aTester);
    // trier la copie avec un algorithme de la bibliothèque java
    Arrays.sort(oracle);
    // vérifier les résultats
    Assert.assertArrayEquals(oracle, aTester);
    System.out.println("Test réussi");
  }

  @Test(timeout=10)
  public void tableau_deja_trie()
  {
    System.out.print("\nTri tableau déjà trié			 : ");
    int [] aTester = {
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 11, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 18, 19, 20, 21, 21, 22, 22, 23, 24, 25, 27, 28, 29, 29, 30, 31, 35, 43, 45, 48, 51, 55, 77, 88, 88, 88, 482, 579, 609, 617, 650, 650, 669, 702, 725, 738, 778, 797, 802, 802, 802, 805, 813, 823, 830, 848, 871, 896, 921, 933, 946
    };
    int [] oracle = Arrays.copyOf(aTester, aTester.length); 

    // trier le tableau aTester
    AppelAlgoTri(aTester);
    // trier la copie
    Arrays.sort(oracle);
    // vérifier les résultats
    Assert.assertArrayEquals(oracle, aTester);
    System.out.println("Test réussi");
  }

  @Test(timeout=10)
  public void tableau_trie_ordre_inverse()
  {
    System.out.print("\nTri tableau trié en ordre inverse	 : ");
    int [] aTester = {
      946, 933, 921, 896, 871, 848, 830, 823, 813, 805, 802, 802, 802, 797, 778, 738, 725, 702, 669, 650, 650, 617, 609, 579, 482, 88, 88, 88, 77, 55, 51, 48, 45, 43, 35, 31, 30, 29, 29, 28, 27, 25, 24, 23, 22, 22, 21, 21, 20, 19, 18, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 14, 14, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 12, 12, 12, 11, 10, 10, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
    };
    int [] oracle = Arrays.copyOf(aTester, aTester.length); 

    AppelAlgoTri(aTester);
    Arrays.sort(oracle);
    Assert.assertArrayEquals(oracle, aTester);
    System.out.println("Test réussi");
  }

  @Test(timeout=2000)
  public void tableau_hasard()
  {
    int nbElements = 100000;
    System.out.print("\nTri " + nbElements + " nombres tirés au hasard	 : ");
    int [] aTester = initialiserTableau(nbElements);
    int [] oracle = Arrays.copyOf(aTester, aTester.length);
    AppelAlgoTri(aTester);
    Arrays.sort(oracle);
    Assert.assertArrayEquals(oracle, aTester);
    System.out.println("Test réussi");
  }

  /**
   * initialiser un tableau avec des nombres tirés au hasard
   * @param nb  : nombre d'éléments du tableau (0 < nb)
   * @return      tableau de nb éléments tirés au hasard
   */
  public static int [] initialiserTableau(int nb)
  {
    int [] thasard = new int[nb];
    Random generateur = new Random();
    for (int i = 0; i < nb; ++i) {
      int h = generateur.nextInt(nb*100);
      thasard[i] = h;
    }
    return thasard;
  }
} // TestTri
