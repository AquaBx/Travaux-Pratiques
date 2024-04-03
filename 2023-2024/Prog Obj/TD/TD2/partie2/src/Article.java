import java.util.Comparator;

public class Article implements SpecifArticle,Comparable<Article> {
    private String designation ;
    private int quantite ;
    private double prixHT ;
    private static final double tauxTVA = 1.196;
        // constructeur
        public Article ( String designation , int quantite , double prixHT ) {
        this.designation = designation ;
        this.quantite = quantite ;
        this.prixHT = prixHT ;
    }
    // accesseurs
    public String getDesignation() { return this.designation ; }
    public int getQuantite() { return this.quantite ; }
    public double getPrixHT () { return this.prixHT ; }
    public double getPrixTTC () { return this.prixHT * tauxTVA ; }
    // ajout / retrait
    public void ajouter (int q ) { this.quantite += q ; }
    public void retirer (int q ) { this.quantite -= q ; }

    @Override
    public String toString() {
        return String.format("%s, %.2f euros (%d en stock)",this.getDesignation(),this.getPrixHT(),this.getQuantite());
    }

    public int compareTo(Article a) {
        return this.getDesignation().compareTo(a.getDesignation());
    }

}
