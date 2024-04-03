package rationnel;

import types.Rationnel;

import util.Couple;
import static util.Outils.pgcd;

public class RationnelCouple implements Rationnel {

        protected final Couple<Integer, Integer> couple;

        @Override
        public boolean equals(Rationnel r) {
            return this.couple.equals(new Couple<>(r.getNumerateur(),r.getDenominateur()));
        }

        @Override
        public Rationnel somme(Rationnel r) {
            int d1 = r.getDenominateur();
            int d2 = this.couple.getSecond();

            int n1 = r.getNumerateur();
            int n2 = this.couple.getFirst();

            return new rationnel.RationnelSimple(n1*d2+n2*d1,d1*d2);
        }

        @Override
        public Rationnel inverse() {
            int num = this.couple.getFirst();
            int den = this.couple.getSecond();

            return new rationnel.RationnelSimple(den,num);
        }

        @Override
        public double valeur() {

            return (double) this.getNumerateur() / this.getDenominateur();
        }

        @Override
        public int getNumerateur() {
            return this.couple.getFirst();
        }

        @Override
        public int getDenominateur() {
            return this.couple.getSecond();

        }

        @Override
        public int compareTo(Rationnel r) {
            return Double.compare(this.valeur(), r.valeur());
        }

        @Override
        public String toString() {
            return this.getNumerateur() + "/" + this.getDenominateur();
        }

        public RationnelCouple(int n, int d){

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

            this.couple = new Couple<>(n/pgcd,d/pgcd);

        }

        public RationnelCouple(int n){

            this.couple = new Couple<>(n,1);
        }

        public RationnelCouple(Rationnel r){
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

            this.couple = new Couple<>(n/pgcd,d/pgcd);
        }

    }

