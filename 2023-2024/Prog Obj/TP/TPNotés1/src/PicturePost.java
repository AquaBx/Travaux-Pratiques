public class PicturePost extends PostAbs{

    private String url;
    private String caption;

    @Override
    public void display() {
        System.out.println("Image Post by " + super.author.getName());
        System.out.println("Image URL : " + this.url);
        System.out.println("Caption : " + this.caption);
    }

    PicturePost(User author,String url,String caption){
        this.author = author;
        this.url = url;
        this.caption = caption;
    }
}
