public class Livre  extends Article implements SpecifLivre {

    Integer pages;
    String ISBN;
    public Livre(String designation, int quantite, double prixHT, Integer pages , String ISBN) {
        super(designation, quantite, prixHT);

        this.ISBN = ISBN;
        this.pages = pages;
    }

    @Override
    public String toString() {
        return String.format("%s ISBN %s (%d pages)", super.toString(), this.ISBN, this.pages);
    }

    @Override
    public int getNombrePages() {
        return this.pages;
    }

    @Override
    public String getNumeroISBN() {
        return this.ISBN;
    }
}
