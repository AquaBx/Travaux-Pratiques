import types.ABinHuffman;
import types.Couple;
import types.ListeABH;
import outilsHuffman.OutilsHuffman;

import java.util.*;

/**
 * Réalisation du codage d'un texte par la méthode de Huffman
 */

public class CodageHuffman
{
  public static void main (String[] args)
  {
    //------------------------------------------------------------------------
    // 0. Saisir le nom du fichier à coder (À FAIRE)
    //------------------------------------------------------------------------
    String nomFichier = "./assets/exemple.txt";

    //------------------------------------------------------------------------
    // 1. Lire le texte (DONNÉ)
    //------------------------------------------------------------------------
    char [] texte = OutilsHuffman.lireFichier(nomFichier);

    //------------------------------------------------------------------------
    // 2. Calculer la table des fréquences des caractères (À FAIRE)
    //------------------------------------------------------------------------
    int [] tableFrequences = calculerFrequences(texte);
    //------------------------------------------------------------------------
    // 3. Enregistrer la table de fréquences dans le fichier de sortie (DONNÉ)
    //------------------------------------------------------------------------
    OutilsHuffman.enregistrerTableFrequences(tableFrequences, nomFichier + ".code");

    //------------------------------------------------------------------------
    // 4. Construire l'arbre de codage de Huffman (DONNÉ - À FAIRE)
    //------------------------------------------------------------------------
    ABinHuffman arbreCodageHuffman = construireArbreHuffman(tableFrequences);

    //------------------------------------------------------------------------
    // Afficher l'arbre de codage de Huffman (DÉJÀ FAIT)
    //------------------------------------------------------------------------
    System.out.println("Arbre de Huffman associé au texte " + nomFichier);
    DecodageHuffman.afficherHuffman(arbreCodageHuffman);

    //------------------------------------------------------------------------
    // 5. Construire la table de codage associée (À FAIRE)
    //------------------------------------------------------------------------
    String [] tablecodage = construireTableCodage(arbreCodageHuffman);

    //------------------------------------------------------------------------
    // 5.1. afficher la table de codage (À FAIRE)
    //------------------------------------------------------------------------
    System.out.println("Table de codage associée au texte " + nomFichier);
    afficherTableCodage(tablecodage);

    //------------------------------------------------------------------------
    // 6. coder le texte avec l'arbre de Huffman (À FAIRE)
    //------------------------------------------------------------------------
    StringBuilder texteCode = coderTexte(texte, tablecodage);

    //------------------------------------------------------------------------
    // 7. enregistrer le texte codé (DONNÉ)
    //------------------------------------------------------------------------
    OutilsHuffman.enregistrerTexteCode(texteCode, nomFichier + ".code");

    //------------------------------------------------------------------------
    // xx. calculer et afficher les stats (À FAIRE)
    //------------------------------------------------------------------------
    // calculer la taille du fichier non codé
    // calculer la taille du fichier codé

  }

  /**
   * 2. calculer la fréquence d'apparition de chaque caractère
   * @param  tcar tableau des caractères du texte
   * @return tableau de fréquence des caractères, indicé par les caractères
   */
  public static int [] calculerFrequences(char [] tcar)
  {
    int[] occurence = new int[256];

    for (char c: tcar){
        occurence[( int ) c] ++;
    }

    return occurence;
  }

  /**
   * 4. construire un arbre de codage de Huffman par sélection et combinaison
   * des éléments minimaux
   * @param tableFrequences table des fréquences des caractères
   * @return arbre de codage de Huffman
   */
  public static ABinHuffman construireArbreHuffman(int [] tableFrequences)
  {
    ListeABH liste = faireListeAbinHuffman(tableFrequences);

    while (liste.size() > 1){
      liste.sort( Comparator.comparingInt(obj -> obj.getValeur().deuxieme() ) );


      ABinHuffman fg = liste.pollFirst();
      ABinHuffman fd = liste.pollFirst();


      ABinHuffman branche = new ABinHuffman();

      Couple<Character,Integer> couple = new Couple<>('.',fd.getValeur().deuxieme() + fg.getValeur().deuxieme());

      branche.setValeur(couple);

      branche.setGauche(fg);
      branche.setDroit(fd);

      liste.add(branche);


    }

    return liste.getFirst();
  }

  /**
   * 4.1 Faire une liste triée dont chaque élément est un arbreBinaire<br>
   * comprenant un unique sommet dont l'étiquette est un couple
   * <caractère, fréquence>, trié par fréquence croissante
   * @param tableFrequences : table des fréquences des caractères
   * @return		      la liste triée
   */
  private static ListeABH faireListeAbinHuffman(int [] tableFrequences)
  {

    ListeABH listeHuffman = new ListeABH();

    for (int i = 0; i < tableFrequences.length ; i++ ) {
      if (tableFrequences[i] != 0){
        ABinHuffman abr = new ABinHuffman();
        char car = (char) i;

        Couple<Character,Integer> couple = new Couple<>(car,tableFrequences[i]);
        abr.setValeur(couple);
        listeHuffman.add(abr);
      }
    }

    listeHuffman.sort( Comparator.comparingInt(obj -> obj.getValeur().deuxieme() ) );

    return listeHuffman;
  }

  /**
   * 5. construire la table de codage correspondant à l'arbre de Huffman
   * @param abinHuff : arbre de Huffman
   * @return table de (dé)codage indicé par lex caractères
   */

  public static String [] construireTableCodage(ABinHuffman abinHuff)  {
    Stack<ABinHuffman> parcours = new Stack<>();
    Stack<String> chemin = new Stack<>();

    String[] table = new String[256];

    parcours.push(abinHuff);
    chemin.push("");
    while (!parcours.isEmpty()) {
        ABinHuffman a = parcours.pop();
        String c = chemin.pop();

        if ( a.estFeuille() ) {
          char car = a.getValeur().premier();
          int val = a.getValeur().deuxieme();
          table[(int)car] = c;
        }
        if (a.existeGauche()) {
          parcours.push(a.filsGauche());
          chemin.push(c+"0");
        }
        if (a.existeDroit()) {
          parcours.push(a.filsDroit());
          chemin.push(c+"1");
        }
    }

    return table;
  }

  /**
   * 5.1. Afficher la table de codage associée au texte
   * @param tablecodage : table de codage associée au texte
   */
  public static void afficherTableCodage(String [] tablecodage)
  {
    for (int i=0; i < tablecodage.length ; i++) {
      String code = tablecodage[i];
      if (code!=null){
        System.out.printf("%c | %s%n",i,code);
      }
    }
  }

  /**
   * 6. Coder un texte à l'aide de la table de codage
   * @param texte à coder
   * @param tablecodage : table de codage associée au texte
   * @return texte codé
   */
  public static StringBuilder coderTexte(char [] texte, String [] tablecodage)
  {
    StringBuilder newString = new StringBuilder();

    for (char c : texte){
      newString.append(tablecodage[(int)c]);
    }
    return newString;
  }
}// CodageHuffman
