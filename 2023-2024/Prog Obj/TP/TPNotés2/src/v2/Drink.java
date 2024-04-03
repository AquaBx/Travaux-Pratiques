package v2;

public class Drink implements Orderable {
    double cost;
    String name;

    public double getCost() {
        return this.cost;
    }

    public String getName() {
        return this.name;
    }

    public Drink(String name, double cost){
        this.name = name;
        this.cost = cost;
    }
}
