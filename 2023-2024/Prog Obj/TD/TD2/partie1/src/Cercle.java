public class Cercle implements Figure{

    private final double x;
    private final double y;
    private final double r;

    @Override
    public String genre() {
        return "Cercle";
    }

    public static double distance(double x1, double y1,double x2, double y2){
        return Math.sqrt( Math.pow(x1 - x2,2) + Math.pow(y1-y2,2) );
    }
    @Override
    public boolean inside(double x, double y) {
        return distance(x,y,this.x,this.y) <= r;
    }

    public Cercle(double x,double y,double r) {
        this.x = x;
        this.y = y;
        this.r = r;
    }

}
