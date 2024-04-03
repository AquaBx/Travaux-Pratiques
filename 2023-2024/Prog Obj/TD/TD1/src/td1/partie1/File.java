package partie1;

public interface File {
    public boolean estVide();

    public boolean estPleine();

    public int getTaille();

    public void ajouter(float x);

    public void supprimer();

    public float getTete();
}
