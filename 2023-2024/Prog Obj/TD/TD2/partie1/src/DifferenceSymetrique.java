public class DifferenceSymetrique extends Combinaison{

    public DifferenceSymetrique(Figure nf1, Figure nf2) {
        super(nf1, nf2);
    }

    @Override
    public String genre() {
        return "Difference Symetrique";
    }

    @Override
    protected boolean operationInside(boolean ResultOperator1, boolean ResultOperator2){
        return (ResultOperator1 && !ResultOperator2) || (!ResultOperator1 && ResultOperator2);
    }

}
