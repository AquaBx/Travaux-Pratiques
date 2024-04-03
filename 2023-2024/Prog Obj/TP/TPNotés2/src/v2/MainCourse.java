package v2;

public class MainCourse implements Orderable {
    @Override
    public double getCost() {
        return 5.0;
    }

    @Override
    public String getName() {
        return "MainCourse";
    }
}
