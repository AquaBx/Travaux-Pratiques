import java.util.Arrays;
import java.util.Comparator;

public class Catalogue {
    private SpecifArticle [] listeArticles;
    private int nbArticles;

    public Catalogue(Article[] articles) {
        this.listeArticles = articles;
        nbArticles = articles.length;
    }

    public void afficher(){
        for (SpecifArticle article : listeArticles){
            System.out.println(article.toString());
        }
    };



    public void trier(){
        Arrays.sort( this.listeArticles,0,this.nbArticles );
    };

    public void trier(Comparator<SpecifArticle> comparator){
        Arrays.sort( this.listeArticles,0,this.nbArticles,comparator );
    };

}
