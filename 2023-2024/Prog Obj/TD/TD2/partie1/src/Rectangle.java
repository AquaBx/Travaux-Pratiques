public class Rectangle implements Figure {

    private final double x;
    private final double y;
    private final double longueur;

    private final double largeur;


    @Override
        public String genre() {
            return "Rectangle";
        }

        @Override
        public boolean inside(double x, double y) {
            var checkX = this.x-this.longueur/2 <= x && x <= this.x+this.longueur/2;
            var checkY = this.y-this.largeur/2  <= y && y <= this.y+this.largeur/2;

            return checkX && checkY;
        }

        public Rectangle(double x,double y,double longueur, double largeur) {
            this.x = x;
            this.y = y;
            this.longueur = longueur;
            this.largeur = largeur;

        }

    }
