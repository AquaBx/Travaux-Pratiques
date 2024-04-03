package partie2;

import java.util.ArrayList;

public class FileTableauSansDec<T> implements File<T> {

    private final ArrayList<T> elements;
    private int index = 0;
    private int taille = 0;

    public FileTableauSansDec(Integer taille) {
        this.elements = new ArrayList<>(taille);
    }

    public boolean estVide() {
        return this.taille == 0;
    }

    public boolean estPleine() {
        return this.elements.length() == this.taille;
    }

    public int getTaille() {
        return this.taille;
    }

    public void ajouter(T x) {
        if (this.estPleine()) {
            System.out.println("Impossible d'ajouter l'élement, La file est pleine");
        } else {
            int next = (this.index + this.getTaille()) % this.elements.length();
            this.elements.set(next, x);
            this.taille += 1;
        }
    }

    public void supprimer() {
        if (!this.estVide()) {
            this.elements.set(this.index, null);

            this.index = (this.index + 1) % this.elements.length();
            this.taille -= 1;

        }
    }

    public T getTete() {
        if (this.estVide()) {
            System.out.println("Impossible d'ajouter l'élement, La file est pleine");
            return null;

            /*
            throw new RuntimeException("Impossible de récupérer la tête, la file est vide");
            */
        } else {
            return this.elements.get(this.index);
        }
    }

    @Override
    public String toString() {
        StringBuffer buffer = new StringBuffer();

        for (Object element : elements) {

            if (element != null) {
                buffer.append(element).append(" ");
            } else {
                buffer.append("null").append(" ");

            }

        }
        /* code prof
        for (int i = 0; i < this.elements.length ; i ++) {
            buffer.append(this.elements[i] + " ");
        }
        */

        return buffer.toString();
    }

    public String toString2() {
        StringBuffer buffer = new StringBuffer();

        for (int i = 0; i < this.getTaille(); i++) {
            int y = (i + this.index) % this.elements.length();
            buffer.append(this.elements.get(y)).append(" ");
        }
        /* code prof
        for (int i = 0; i < this.elements.length ; i ++) {
            buffer.append(this.elements[i] + " ");
        }
        */

        return buffer.toString();
    }
}