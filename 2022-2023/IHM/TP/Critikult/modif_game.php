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

    $jeux = getJeux($mysqli);

    if (isset($_GET["id"])){

        $id = $_GET["id"];
        $jeu = InfosJeu($mysqli,$id)[0];
        $img = 'data:image;base64,' . base64_encode( $jeu["couverture"] ) ;

        $date = $jeu["date_sortie"];
        $nom = $jeu["nom"];
        $synopsis = $jeu["synopsis"];
        $prix = $jeu["prix"];
        $illus = getIllustrationByJeu($mysqli,$id);
    
        $catsjeu = CategorieJeu($mysqli,$id);
        $catsall = getCategories($mysqli);
        $supsjeu = SupportJeu($mysqli,$id);
        $supsall = getSupports($mysqli);
        


    }    

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
            <h2>Choix du jeu </h2>

            <form enctype="multipart/form-data" method="get" action="">
                <label for='id'>Id du jeu</label>

                <select id='id' name='id' required>

                <?php OptionsJeux($jeux); ?>

                </select>

                <input name='' type="submit">  
            </form>

            <?php  if (isset($_GET["id"])){ ?>

            <h2>Modification d'un jeu</h2>
            <form enctype="multipart/form-data" method="POST" action="./php/modif_game.php">
            


                <?php



                echo "<input name='id' value='$id' type='hidden' required>";

                echo "<label for='nom'>Nom du jeu</label>";
                echo "<input id='nom' name='nom' value=\"$nom\" required>";

                echo "<label for='synopsis'>Synopsis</label>";
                echo "<textarea style='resize:vertical;' id='synopsis' name='synopsis' required>$synopsis</textarea>";

                echo "<label for='date'>Date de sortie</label>";
                echo "<input id='date' name='date' type='date' value='$date' required>";

                echo "<label for='couverture'>Couverture</label>";
                echo "<div>";
                echo "<img width='100%' src='$img' alt='Jaquette du jeu'>";
                echo "<input id='couverture' accept='image/*' name='couverture' type='file' accept='image/*'>";
                echo "</div>";
                echo "<label for='prix'>Prix du jeu</label>";
                echo "<input type='number' step='.01' name='prix' id='prix' value='$prix' min=0 max=999.99 required/>";
                 	 	 	 	 	
                ?>

                <input name='game' type="submit">    
            </form>

            <h2>Ajout d'une illustration</h2>

            <form enctype="multipart/form-data" method="POST" action="./php/modif_game.php">
                
                <?php                 
                    echo "<input name='id' value='$id' type='hidden' required>";
                ?>

                <label for="illustration">Illustrations</label>
                <input id="illustration" accept="image/*" name="illustration" type='file' accept='image/*' required>

                <input name='newillus' type="submit">    
            </form>

            <?php liste_illus( $illus );?>


            <h2>Modifier les Plateformes</h2>

            <form enctype="multipart/form-data" method="POST" action="./php/modif_game.php">
                
                <?php                 
                    echo "<input name='id' value='$id' type='hidden' required>";
                ?>

                <?php checkboxs_supports($supsjeu,$supsall); ?>

                <input name='supports' type="submit">    
            </form>

            <h2>Modifier les Catégories</h2>

            <form enctype="multipart/form-data" method="POST" action="./php/modif_game.php">
                
                <?php                 
                    echo "<input name='id' value='$id' type='hidden' required>";
                ?>

                <?php checkboxs_categories($catsjeu,$catsall); ?>
                
                <input name='categories' type="submit">    
            </form>


            <?php  } ?>
        </main>
    </body>
</html>
