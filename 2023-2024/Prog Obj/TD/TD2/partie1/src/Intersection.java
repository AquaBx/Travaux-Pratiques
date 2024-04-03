public class Intersection extends Combinaison{

    public Intersection(Figure nf1, Figure nf2) {
        super(nf1, nf2);
    }

    @Override
    public String genre() {
        return "Intersection";
    }

    @Override
    protected boolean operationInside(boolean ResultOperator1, boolean ResultOperator2){
        return ResultOperator1 && ResultOperator2;
    }

}
