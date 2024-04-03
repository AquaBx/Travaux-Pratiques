public interface SpecifArticle {
 // Designation de l’article

 public String getDesignation() ;

 // Quantite en stock
public int getQuantite () ;


// Prix HT
public double getPrixHT () ;


// Prix TTC = prix HT * taux de TVA (1.196)
public double getPrixTTC () ;


// Augmenter le stock de la quantite q ; q > 0
public void ajouter (int q ) ;


// Reduire le stock de la quantite q ; 0 < q <= quantite
public void retirer (int q ) ;
}