package util;

public class Couple<T1,T2> {
    private T1 valeur1;
    private T2 valeur2;

    public Couple(T1 v1, T2 v2){
        this.valeur1 = v1;
        this.valeur2 = v2;
    }

    public T1 getFirst(){
        return valeur1;
    }

    public T2 getSecond(){
        return valeur2;
    }

    public void setFirst(T1 v1){
        this.valeur1 = v1;
    }

    public void setSecond(T2 v2){
        this.valeur2 = v2;
    }

    public boolean equals(Couple<T1,T2> C){
        return (this.getFirst().equals(C.getFirst())  && this.getSecond().equals(C.getSecond() ));
    }
}
