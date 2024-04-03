<?php 
    session_start();
    
    include("./includes/config-bdd.php");
    include("./php/functions-DB.php");
    include("./php/functions_query.php");
    include("./php/functions_structure.php");

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
    <?php include("./static/nav.php");  ?>
    <?php include("./static/modal.php");  ?>
    <main class='accueil'>
        <?php

            if (isset($_GET["page"])){
                $page = (int)$_GET["page"];
            }
            else{
                $page = 1;
            }

            if (isset($_GET["categorie"])){
                $categories = $_GET["categorie"];
            }
            else{
                $categories = "";
            }

            if (isset($_GET["name"])){
                $name = $_GET["name"];
            }
            else{
                $name = "";
            }



            $mysqli=connectionDB();

            $count = countArticles($mysqli,$categories,$name);

            $nb_articles = 6;
            $nb_page=ceil($count/$nb_articles);

            

            echo "<h2 class='page'>Page $page</h2>";

            $offset = $nb_articles*($page-1);

            $articles = MenuArticles($mysqli,$nb_articles,$offset,$categories,$name);
            display_articles($articles);
            closeDB($mysqli);

            

            echo "<div class='navpages'>";
            for ($i=1;$i<=$nb_page;$i++){
                echo "<a href='?page=$i&c=$categories&n=$name'>$i</a>";
            }
            echo "</div>";
        ?>
    </main>
</body>
</html>
