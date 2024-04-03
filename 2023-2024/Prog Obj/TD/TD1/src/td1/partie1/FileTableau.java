package partie1;

public class FileTableau implements File {

    private final Float[] elements;
    private final Float UNDEFINED = -1F;

    public FileTableau(Integer taille) {
        this.elements = new Float[taille];
        for (int i = 0; i < taille; i++) {
            this.elements[i] = this.UNDEFINED;
        }
    }

    public boolean estVide() {
        return this.elements[0].equals(this.UNDEFINED);
    }

    public boolean estPleine() {
        return !this.elements[this.elements.length - 1].equals(this.UNDEFINED);
    }

    public int getTaille() {
        for (int i = 0; i < this.elements.length; i++) {
            if (this.elements[i].equals(this.UNDEFINED)) {
                return i;
            }
        }

        return this.elements.length;
    }

    public void ajouter(float x) {
        if (this.estPleine()) {
            System.out.println("Impossible d'ajouter l'élement, La file est pleine");
        } else {
            this.elements[this.getTaille()] = x;
        }
    }

    public void supprimer() {
        if (!this.estVide()) {
            for (int i = 0; i < this.getTaille() - 1; i++) {
                this.elements[i] = this.elements[i + 1];
            }
            this.elements[this.getTaille() - 1] = this.UNDEFINED;
        }
    }

    public float getTete() {
        if (this.estVide()) {
            System.out.println("Impossible d'ajouter l'élement, La file est pleine");
            return this.UNDEFINED;

            /*
            throw new RuntimeException("Impossible de récupérer la tête, la file est vide");
            */
        } else {
            return this.elements[0];
        }
    }

    @Override
    public String toString() {
        StringBuffer buffer = new StringBuffer();

        for (Float element : this.elements) {
            buffer.append(element).append(" ");
        }
        /* code prof
        for (int i = 0; i < this.elements.length ; i ++) {
            buffer.append(this.elements[i] + " ");
        }
        */

        return buffer.toString();
    }
}