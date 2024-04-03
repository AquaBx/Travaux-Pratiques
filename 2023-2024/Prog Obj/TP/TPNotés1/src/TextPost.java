public class TextPost extends PostAbs{

    private String content;

    @Override
    public void display() {
        System.out.println("Text Post by " + super.author.getName());
        System.out.println(content);
    }

    TextPost(User author,String content){
        this.author = author;
        this.content = content;
    }
}
