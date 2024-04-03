package v2;

public class Menu implements Orderable {
    private Orderable des = new Dessert();
    private Orderable mai = new MainCourse();
    private Orderable dri;

    public String getName() {
        return "Menu" + "(" + mai.getName() + "," + des.getName() + "," + dri.getName() + ")";
    }

    public double getCost() {
        return des.getCost() + mai.getCost() + dri.getCost();
    }

    public Menu(Drink dri){
        this.dri = dri;
    }
}
