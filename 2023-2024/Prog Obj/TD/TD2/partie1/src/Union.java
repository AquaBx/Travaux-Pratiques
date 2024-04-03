public class Union extends Combinaison{

    public Union(Figure nf1, Figure nf2) {
        super(nf1, nf2);
    }

    @Override
    public String genre() {
        return "Union";
    }

    @Override
    protected boolean operationInside(boolean ResultOperator1, boolean ResultOperator2){
        return ResultOperator1 || ResultOperator2;
    }

}
