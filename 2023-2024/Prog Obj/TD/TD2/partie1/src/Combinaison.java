public abstract class Combinaison implements Figure {

    protected final Figure f1;
    protected final Figure f2;

    public abstract String genre();

    protected abstract boolean operationInside(boolean ResultOperator1, boolean ResultOperator2);
    @Override
    public boolean inside(double x, double y){
        return this.operationInside( this.inside(x,y) , this.inside(x,y) );
    };

    public Combinaison(Figure nf1, Figure nf2) {
        this.f1 = nf1;
        this.f2 = nf2;
    }

}
