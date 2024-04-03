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
        
            <h2>Création d'un compte</h2>

            <form method="POST" action="./php/signup.php">
            
                    


                    <label for="login">Nom d'utilisateur</label>
                    <input id="login" name="login" required>
                    
                    <label for="password">Mot de passe</label>
                    <input id="password" name="password" type="password" required>


                    <label for="name">Nom</label>
                    <input id="name" name="name" required>

                    <label for="firstname">Prénom</label>
                    <input id="firstname" name="firstname" required>

                    <label for="email">Email</label>
                    <input type='email' id="email" name="email" required>

                    <label for="birthday">Date de naissance</label>
                    <input id="birthday" name="birthday" type="date" required>



                    <label for='age'>Je certifie avoir 15 ans ou plus</label>
                    <input type="checkbox" id='age' required>
                    

                    <label for='cgu' >Je certifie avoir lu les CGU</label>
                    <input id='cgu' type="checkbox" required>

                    
                    <input type="submit">
            </form>

        </main>
    </body>
</html>
