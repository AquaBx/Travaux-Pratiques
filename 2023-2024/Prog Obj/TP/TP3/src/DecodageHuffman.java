import types.ABinHuffman;
import outilsHuffman.OutilsHuffman;

/**
 * Réalisation du décodage d'un texte par la méthode de Huffman
 */

public class DecodageHuffman
{
  public static void main (String[] args)
  {
    //------------------------------------------------------------------------
    // 0. Saisir le nom du fichier à décoder (À FAIRE)
    //------------------------------------------------------------------------
    String nomFichier = "./assets/exemple.txt.code";

    //------------------------------------------------------------------------
    // 1. Lire et construire la table de fréquences (DONNÉ)
    //------------------------------------------------------------------------
    int [] tableFrequences = OutilsHuffman.lireTableFrequences(nomFichier);

    //------------------------------------------------------------------------
    // 2. Construire l'arbre de Huffman (DONNÉ)
    //------------------------------------------------------------------------
    ABinHuffman arbreHuffman =
      OutilsHuffman.construireArbreHuffman(tableFrequences);

    //------------------------------------------------------------------------
    // 2.1 afficher l'arbre de Huffman (À FAIRE)
    //------------------------------------------------------------------------
    System.out.println("Arbre de Huffman associé au texte " + nomFichier);
    afficherHuffman(arbreHuffman);

    //------------------------------------------------------------------------
    // 3. Lire le texte codé (DONNÉ)
    //------------------------------------------------------------------------
    String texteCode = OutilsHuffman.lireTexteCode(nomFichier);

    //------------------------------------------------------------------------
    // 4. Décoder le texte (À FAIRE)
    //------------------------------------------------------------------------
    StringBuilder texteDecode = decoderTexte(texteCode, arbreHuffman);

    //------------------------------------------------------------------------
    // 5. Enregistrer le texte décode (DONNÉ)
    //------------------------------------------------------------------------
    System.out.println("texte décodé:\n\n" + texteDecode);
    OutilsHuffman.enregistrerTexte(texteDecode, nomFichier + ".decode");
  }

  /**
   * 4. décoder une chaîne (non vide) encodée par le codage de Huffman
   * @param texteCode    : chaîne de "0/1" à décoder
   * @param arbreHuffman : arbre de (dé)codage des caractères
   */
  public static StringBuilder decoderTexte(String texteCode, ABinHuffman arbreHuffman) {
    StringBuilder decodedTexte = new StringBuilder();
    ABinHuffman arbreInt = arbreHuffman;

    for ( int car : texteCode.toCharArray() ) {

      arbreInt = (car == '0' ? arbreInt.filsGauche() : arbreInt.filsDroit() );

      if (arbreInt.estFeuille()) {
        decodedTexte.append(arbreInt.getValeur().premier());
        arbreInt = arbreHuffman;
      }

    }
    return decodedTexte;
  }

  /**
   * 2.1 afficher un arbre de Huffman
   * @param a : arbre binaire de Huffman
   */

  public static void afficherHuffmanRec(ABinHuffman a,String b) {
    if (a.estFeuille()){
      System.out.println( String.format("%s : %s",a, b));
    }
    else {
      afficherHuffmanRec(a.filsGauche(),b+"0");
      afficherHuffmanRec(a.filsDroit(),b+"1");
    }
  }

  public static void afficherHuffman(ABinHuffman a) {
    afficherHuffmanRec(a,"");
  }
} // DecodageHuffman
