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

            <h2>Ajout d'un jeu</h2>
            <form enctype="multipart/form-data" method="POST" action="./php/post_game.php">
            
                <label for="nom">Nom du jeu</label>
                <input id="nom" name="nom" required>

                <label for="synopsis">Synopsis</label>
                <textarea style="resize:vertical;" id="synopsis" name="synopsis" required></textarea>

                <label for="date">Date de sortie</label>
                <input id="date" name="date" type='date' required>

                <label for="couverture">Couverture</label>
                <input id="couverture" accept="image/*" name="couverture" type='file' accept='image/*' required>

                

                <label for="prix">Prix du jeu</label>
                <input type="number" step=".01" name="prix" id="prix" min=0 max=999.99 required/>
                 	 	 	 	 	
                <input name='game' type="submit">    
            </form>
        </main>
    </body>
</html>
