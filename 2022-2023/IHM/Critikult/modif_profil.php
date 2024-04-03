<?php 
    session_start();

    include("./includes/config-bdd.php");
    include("./php/functions-DB.php");
    include("./php/functions_query.php");
    include("./php/functions_structure.php");
    
    if(! isset($_SESSION["id"])){
        header("Location: index.php");
        exit();
    }

    $mysqli = connectionDB();

    $id = $_SESSION["id"];
    $user = getUserById($mysqli,$id)[0];
    $login = $user["login"];
    $pdp = $user["pdp"];
    $nom = $user["nom"];
    $prenom = $user["prenom"];
    $email = $user["email"];
    
    if ($pdp){
        $img = 'data:image;base64,' . base64_encode( $pdp ) ;
    }
    else{
        $img = './images/blank_pdp.webp';
    }

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

        <?php include("./static/nav.php");?>
        <?php include("./static/modal.php");  ?>
        
        <main>
            
            <h2>Modification du profil</h2>

            <form enctype="multipart/form-data" method="POST" action="./php/modif_profil.php">
            


                <?php

                


                echo "<input name='id' value='$id' type='hidden' required>";

                echo "<label for='nom'>Nom</label>";
                echo "<input id='nom' name='nom' value=\"$nom\" required>";

                echo "<label for='prenom'>Prénom</label>";
                echo "<input id='prenom' name='prenom' value=\"$prenom\" required>";

                echo "<label for='Login'>Login</label>";
                echo "<input id='login' name='login' value=\"$login\" required>";

                echo "<label for='email'>Email</label>";
                echo "<input id='email' type='email' name='email' value=\"$email\" required>";

                echo "<label for='pdp'>Photo de profil</label>";
                echo "<div>";
                echo "<img width='100%' src='$img' alt='photo de profil'>";
                echo "<input id='pdp' accept='image/*' name='pdp' type='file' accept='image/*'>";
                echo "</div>";
                ?>

                <input name='user' type="submit">    
            </form>
        </main>
    </body>
</html>