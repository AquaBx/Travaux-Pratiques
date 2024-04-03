import java.util.ArrayList;
import java.util.List;

public class User {
    private String name;
    private List<Post> posts;

    public String getName(){
        return this.name;
    }

    public void setName(String newName){
        this.name = newName;
    }

    public void addPost(Post post){
        posts.add(post);
    }

    public List<Post> getPosts(){
        return posts;
    }

    public Post getPost(Integer i){
        return posts.get(i);
    }

    User(String name){
        this.name = name;
        this.posts = new ArrayList<>();
    }
}
