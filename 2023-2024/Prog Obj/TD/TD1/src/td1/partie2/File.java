package partie2;

public interface File<T> {
    public boolean estVide();

    public boolean estPleine();

    public int getTaille();

    public void ajouter(T x);

    public void supprimer();

    public T getTete();
}
