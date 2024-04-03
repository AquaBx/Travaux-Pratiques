package tableau;

import types.Tableau;

public class TableauBlock<T> implements Tableau<T> {
    Tableau<Tableau<T>> arrays;
    Integer tableSize;
    Integer tableNumber;

    Integer globalSize;

    private void arraysInit(Tableau<Tableau<T>> tab){
        for (int i = 0; i < this.tableNumber; i++){
            tab.push_back(new Block<>(this.tableSize));
        }
    }

    public TableauBlock(int tabN,int n){
        this.arrays = new Block<>(tabN);
        this.tableSize = n;
        this.tableNumber = tabN;
        this.globalSize = 0;
        this.arraysInit(this.arrays);
    }

    public TableauBlock(int tabN){
        this.arrays = new Block<>(tabN);
        this.tableNumber = tabN;
        this.tableSize = 128;
        this.globalSize = 0;
        this.arraysInit(this.arrays);

    }

    @Override
    public int size() {

        return this.globalSize;
    }

        @Override
        public boolean empty() {
            return this.globalSize == 0;
        }

        @Override
        public boolean full() {
            return this.globalSize == this.tableSize*this.tableNumber;
        }

        @Override
        public T get(int i) {
            int x = i/this.tableSize;
            int y = i%this.tableSize;

            return this.arrays.get(x).get(y);
        }

        @Override
        public void set(int i, T v) {
            int x = i/this.tableSize;
            int y = i%this.tableSize;

            this.arrays.get(x).set(y,v);
        }

        public void agrandir(){

            Tableau<Tableau<T>> newArray = new Block<>(this.tableNumber + 1);
            for (int i = 0; i < this.tableNumber; i++){
                newArray.push_back(this.arrays.get(i));
            }
            newArray.push_back(new Block<>(this.tableSize));
            this.arrays = newArray;
            this.tableNumber++;
        }

        @Override
        public void push_back(T x) {
            if( this.full() ){
                this.agrandir();
            }

            int i = this.size()/this.tableSize;
            this.arrays.get(i).push_back(x);
            this.globalSize ++;

            if( this.full() ){
                this.agrandir();
            }

        }

        @Override
        public void pop_back() {
            int x = (this.size()-1)/this.tableSize;

            this.arrays.get(x).pop_back();

            this.globalSize--;

        }
    }

