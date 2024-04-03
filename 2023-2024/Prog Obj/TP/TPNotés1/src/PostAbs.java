public abstract class PostAbs implements Post {
    protected User author;

    @Override
    public User getAuthor() {
        return this.author;
    }

    @Override
    public abstract void display();
}
