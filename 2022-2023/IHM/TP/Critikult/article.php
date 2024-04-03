<?php 
    session_start();
    
    include("./includes/config-bdd.php");
    include("./php/functions-DB.php");
    include("./php/functions_query.php");
    include("./php/functions_structure.php");

    if ( ! isset($_GET["id"])){
        header("Location: index.php");
        exit();
    }

    $mysqli=connectionDB();

    $id_art = $_GET["id"];

    $article = InfosArticle($mysqli,$id_art );

    if ( ! isset($article[0])){
        header("Location: index.php");
        exit();
    }

    $article=$article[0];

    $id_jeu = $article["id_jeu"];



    if (isset($_SESSION["id"])){
        $avis_user = getAvisByUser($mysqli,$_SESSION["id"],$id_jeu);
        $privi = getPriviByUserId($mysqli,$_SESSION["id"]);
    }


    $redac = getUserByID( $mysqli, $article["id_redacteur"] )[0];
    $avis = InfosAvis($mysqli,$id_jeu );
    $illus = getIllustrationByJeu($mysqli,$id_jeu);
    $categorie = CategorieJeu($mysqli,$id_jeu);
    $support = SupportJeu($mysqli,$id_jeu);
    $avg = avg_avis($mysqli,$id_jeu);

    closeDB($mysqli);
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

        
    <main>
        <article>
            <?php 
            display_article($article,$categorie,$support);
            liste_illus($illus);
            redac_opinion($article,$redac);
            

            echo "<hr>";

            echo "<h1>Vos avis</h1>";

            if (isset($_SESSION["id"])){
                if (isset($avis_user[0])){
                    $contenu = $avis_user[0]["contenu"];
                    $note = $avis_user[0]["note"];
                    $send = "modif_avis";
                }
                else{
                    $contenu = NULL;
                    $note = NULL;
                    $send = "new_avis";
                }

                echo "<form action='./php/post_avis.php' method='post'>";

                echo "<input type='hidden' name='id_jeu' value='$id_jeu'>";

                echo "<label for='corps'>Corps de l'avis</label>";
                echo "<textarea style='resize:vertical;' id='corps' name='commentaire' required>$contenu</textarea>";

                echo "<label for='note'>Note attribué au jeu</label>";
                echo "<input type='number' value='$note' name='note' id='note' min=0 max=10 required/>";
                
                echo "<input type='submit' name='$send'/>";

                echo "</form>";
            }

            echo "<br>";

            echo "<div class='moyenne_avis'>";
            echo "<span>Note moyenne</span>";
            star_note($avg[0]["avg_avis"]);
            echo "</div>";

            if (isset($_SESSION["id"])){
                display_avis($avis,$privi,$_SESSION["id"]);
            }
            else{
                display_avis($avis,'','');
            }

            ?>
        </article>
        
    </main>
</body>
</html>
