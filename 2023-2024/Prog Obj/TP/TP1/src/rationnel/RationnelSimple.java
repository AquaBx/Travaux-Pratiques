package rationnel;

import types.Rationnel;

import static util.Outils.pgcd;

public class RationnelSimple implements Rationnel {
    private final int denominateur;
    private final int numerateur;

    @Override
    public boolean equals(Rationnel r) {
        return this.denominateur == r.getDenominateur() && this.numerateur == r.getNumerateur();
    }

    @Override
    public Rationnel somme(Rationnel r) {
        int d1 = r.getDenominateur();
        int d2 = this.denominateur;

        int n1 = r.getNumerateur();
        int n2 = this.numerateur;

        return new RationnelSimple(n1*d2+n2*d1,d1*d2);
    }

    @Override
    public Rationnel inverse() {

        return new RationnelSimple(this.denominateur,this.numerateur);
    }

    @Override
    public double valeur() {
        return (double) this.numerateur / this.denominateur;
    }

    @Override
    public int getNumerateur() {
        return this.numerateur;
    }

    @Override
    public int getDenominateur() {
        return this.denominateur;
    }

    @Override
    public int compareTo(Rationnel r) {
        return Double.compare(this.valeur(), r.valeur());
    }

    @Override
    public String toString() {
        return this.numerateur + "/" + this.denominateur;
    }

    public RationnelSimple(int n, int d){

        if (d < 0){
            d = -d;
            n = -n;
        }

        int pgcd;

        if (n==0){
            pgcd = d;
        }
        else {
            pgcd = pgcd(Math.abs(d),Math.abs(n));
        }

        this.denominateur = d/pgcd;
        this.numerateur = n/pgcd;
    }

    public RationnelSimple(int n){
        this.denominateur = 1;
        this.numerateur = n;
    }

    public RationnelSimple(Rationnel r){
        int d = r.getDenominateur();
        int n = r.getNumerateur();

        if (d < 0){
            d = -d;
            n = -n;
        }

        int pgcd;

        if (n==0){
            pgcd = d;
        }
        else {
            pgcd = pgcd(Math.abs(d),Math.abs(n));
        }

        this.denominateur = d/pgcd;
        this.numerateur = n/pgcd;
    }

}
