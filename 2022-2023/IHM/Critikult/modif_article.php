<?php 
    session_start();
    
    include("./includes/config-bdd.php");
    include("./php/functions-DB.php");
    include("./php/functions_query.php");
    include("./php/functions_structure.php");

    $mysqli = connectionDB();

    $articles = getArticlesByRedac($mysqli,$_SESSION["id"]);

    if(! isset($_SESSION["id"]) ){
        header("Location: index.php");
        exit();
    }

    if (isset($_GET["id"])){
        
        $id = $_GET["id"];

        $article = InfosArticle($mysqli,$id)[0];

        if ($article["id_redacteur"] !== $_SESSION["id"]){
            header("Location: ./index.php");
            exit();
        }

        $titre = $article["titre"];
        $contenu = $article["contenu"];
        $note = $article["note"];

    }

    $privi = getPriviByUserId($mysqli,$_SESSION["id"]);

    closeDB($mysqli);

    if( $privi === "membre" ){
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
            <h2>Choix de l'article </h2>

            <form enctype="multipart/form-data" method="get" action="">
                <label for='id'>Id de l'article</label>
                <select id='id' name='id' required>

                <?php OptionsArticles($articles); ?>

                </select>

                <input name='' type="submit">  
            </form>

            <?php  if (isset($_GET["id"])){ ?>

            <h2>Modification d'un article</h2>

            <form enctype="multipart/form-data" method="POST" action="./php/modif_article.php">
            
                <?php

                echo "<input name='id' value='$id' type='hidden' required>";


                echo "<label for='titre'>Titre</label>";
                echo "<input id='titre' name='titre' value=\"$titre\" required>";

                echo "<label for='contenu'>Synopsis</label>";
                echo "<textarea style='resize:vertical;' id='contenu' name='contenu' required>$contenu</textarea>";

                echo "<label for='note'>Note</label>";
                echo "<input type='number' name='note' id='note' value='$note' min=0 max=10 required/>";
                 	 	 	 	 	
                ?>

                <input name='modif_article' type="submit">    
            </form>
            <?php  } ?>
        </main>
    </body>
</html>
