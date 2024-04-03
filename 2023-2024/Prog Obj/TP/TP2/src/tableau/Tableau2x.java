package tableau;

import types.Tableau;
import types.Array;


public class Tableau2x<T> implements Tableau<T> {
    Tableau<T> array;

    public Tableau2x(int n){
        this.array = new Block<>(n);
    }

    @Override
    public int size() {
        return this.array.size();
    }

    @Override
    public boolean empty() {
        return this.array.empty();
    }

    @Override
    public boolean full() {
        return this.array.full();
    }

    @Override
    public T get(int i) {
        return this.array.get(i);
    }

    @Override
    public void set(int i, T v) {
        this.array.set(i,v);
    }

    public void agrandir(){
        int size = this.size();

        Block<T> newArray = new Block<>(size*2);
        for (int i = 0; i < size; i++){
            newArray.push_back(this.array.get(i));
        }

        this.array = newArray;

    }

    @Override
    public void push_back(T x) {

        if (this.full()){
            this.agrandir();
        }

        this.array.push_back(x);

        if (this.full()){
            this.agrandir();
        }
    }

    @Override
    public void pop_back() {
        this.array.pop_back();
    }
}
