package v2;

public class Dessert implements Orderable {
    @Override
    public double getCost() {
        return 3.0;
    }

    @Override
    public String getName() {
        return "Dessert";
    }
}
