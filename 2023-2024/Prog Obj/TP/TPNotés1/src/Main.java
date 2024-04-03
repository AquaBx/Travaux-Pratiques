import java.util.Random;

public class Main {

    static void makeRandomPost(User user,String content,String optionalCaption){
        Random r = new Random();

        if (r.nextBoolean()){
            Post newPost = new TextPost(user,content);
            user.addPost(newPost);
        }
        else{
            Post newPost = new PicturePost(user,content,optionalCaption);
            user.addPost(newPost);
        }
    }

    public static void main(String[] args) {

        User utilisateur = new User("Tom Chauvel");

        makeRandomPost(utilisateur,"Content 1","Caption 1");
        makeRandomPost(utilisateur,"Content 2","Caption 2");
        makeRandomPost(utilisateur,"Content 3","Caption 3");

        for ( Post post : utilisateur.getPosts() ) {
            post.display();
        }
    }
}