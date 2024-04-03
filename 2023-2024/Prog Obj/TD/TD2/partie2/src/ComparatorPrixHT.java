public class ComparatorPrixHT extends ComparatorAbs<SpecifArticle> {
    @Override
    public int compareCroissant(SpecifArticle o1, SpecifArticle o2) {
        return Double.compare(o1.getPrixHT(),o2.getPrixHT());
    }
}