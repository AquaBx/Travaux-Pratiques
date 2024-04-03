package tableau;

import types.Array;
import types.Tableau;

public class Block<T> implements Tableau<T> {

    private int size;
    private int maxSize;
    private Array<T> array;
    public int size(){
        return this.size;
    }

    public boolean empty(){
        return this.size() == 0;
    }

    public boolean full(){
        return this.size()==this.maxSize;
    }

    public T get(int i){
        if (i < 0) {
            throw new AssertionError("i doit être positif");
        }
        else if (i > this.size()){
            throw new AssertionError("i doit inférieur à la taille");
        }

        return this.array.get(i);
    }

    public void set(int i,T x) {
        if (i < 0) {
            throw new AssertionError("i doit être positif");
        }
        else if (i > this.size()){
            throw new AssertionError("i doit inférieur à la taille");
        }

        this.array.set(i,x);
    }

    public void push_back(T x) {
        if ( this.full() ){
            throw new AssertionError("Le tableau est plein");
        }

        this.array.set(this.size(),x);
        this.size ++;
    }

    public void pop_back() {
        if ( this.empty() ){
            throw new AssertionError("Le tableau est vide");
        }

        this.array.set(this.size()-1,null);
        this.size --;
    }

    public Block(int n){

        if (n <= 0) {
            throw new AssertionError("n doit être strictement positif");
        }

        this.array = new Array<>(n);
        this.size = 0;
        this.maxSize=n;
    }
}
