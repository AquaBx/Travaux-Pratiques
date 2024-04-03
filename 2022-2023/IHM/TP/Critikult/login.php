<?php
    session_start();
    
    include("./includes/config-bdd.php");
    include("./php/functions-DB.php");
    include("./php/functions_query.php");
    include("./php/functions_structure.php");

    if(isset($_SESSION["id"])){
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
        <?php include("./static/nav.php"); ?>
        <?php include("./static/modal.php");  ?>
        <main>
        
            <h2>Connexion</h2>

            <form method="POST" action="./php/login.php">
            
                    

                    <label for="login">Nom d'utilisateur</label>
                    <input id="login" name="login" required>
                    
                    <label for="password">Mot de passe</label>
                    <input id="password" name="password" type="password" required>


                    <input type="submit">
                    
                    <p>Vous n'avez pas de compte, <a href="signup.php">créez en un</a> </p>

            </form>

        </main>
    </body>

</html>
