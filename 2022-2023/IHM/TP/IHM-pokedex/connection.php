<!DOCTYPE html>

<?php
//affichage des erreurs côté PHP et côté MYSQLI

include("./php/log_error.php");

//Import du site - A completer

require_once("./includes/constantes.php");
require_once("./includes/config-bdd.php");
include("./php/functions-DB.php");
include("./php/functions_query.php");
include("./php/functions_structure.php");

session_start();

?>

<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <meta name="author" content="">
        <meta name="keywords" content="">
        <link rel="icon" href="./images/logo.svg"  type="image/icon">
        <link rel="stylesheet" href="./styles/style.css">
        <link rel="stylesheet" href="./styles/form.css">
        <title><?php echo $titreSite; ?></title>

    </head>
    <body>
        <?php include("./static/header.php"); ?>
        <?php include("./static/nav.php"); ?>

        <!-- script pour le formulaire -->
        <?php include("./php/connection.php"); ?> 

        <main>
            <section>
                
                <form action="." method="POST">
                    <fieldset>
                        <legend>Connection</legend>
                        <div>
                            
                            <label for="login">Login</label>
                            <input required id="login" name="login" type="text">
                        </div>
                        <div>
                            <label for="password">Password</label>
                            <input required id="password" name="password" type="password">
                        </div>
                        
                        </fieldset>
                    <input name="submit" type="submit">

                </form>

            </section>
        </main>


        <?php include("./static/footer.php"); ?>
    </body>
<!-- A compléter -->
</html>