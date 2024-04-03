package v1;

public class Drink implements Orderable {
    @Override
    public double getCost() {
        return 2.0;
    }

    @Override
    public String getName() {
        return "Drink";
    }
}
