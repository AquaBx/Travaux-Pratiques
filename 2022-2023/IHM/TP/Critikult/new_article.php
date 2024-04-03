<?php 
    session_start();
    
    include("./includes/config-bdd.php");
    include("./php/functions-DB.php");
    include("./php/functions_query.php");
    include("./php/functions_structure.php");

    if(! isset($_SESSION["id"]) ){
        header("Location: index.php");
        exit();
    }

    $mysqli = connectionDB();
    $jeux = jeuxSansArticle($mysqli);

    $privi = getPriviByUserId($mysqli,$_SESSION["id"]);

    closeDB($mysqli);

    if($privi === "membre" ){
        header("Location: index.php");
        exit();
    }


?>

<!DOCTYPE html>
<html lang="fr">
    <head>
        <link rel="stylesheet" href="./css/index.css">

        <link rel="stylesheet" href="./fontawesome/css/solid.min.css">
        <link rel="stylesheet" href="./fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./fontawesome/css/regular.min.css">
        <link rel="stylesheet" href="./fontawesome/css/brands.min.css">       

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Critikult</title>
        <link rel="icon" href="./images/favicon.webp">
        <meta name="author" content="Jean-Eudes BORNERT Tom CHAUVEL">
        <meta name="keywords" content="Jeux video">
    </head>

    <body>

        <?php include("./static/nav.php");?>
        <?php include("./static/modal.php");  ?>
        
        <main>
            
            <h2>Création d'un article</h2>

            <form method="POST" action="./php/post_article.php">
            

                <label for="jeu">Sur quel jeu écrivez-vous ?</label>
                <select id="jeu" name="jeu">
                    <?php 
                    displayJeuxSansArticle($jeux);
                    ?>
                </select>

                <label for="Titre">Titre de l'article</label>
                <input id="Titre" name="Titre" placeholder="Essayez de faire un titre accrocheur" required>
                
                <label for="corps">Corps de l'article</label>
                <textarea style="resize:vertical;" id="corps" name="corps" required></textarea>

                <label for="note">Note attribué au jeu</label>
                <input type="number" name="note" id="note" min=0 max=10 required/>
                
                <input type="submit">    
            </form>
        </main>
    </body>
</html>
