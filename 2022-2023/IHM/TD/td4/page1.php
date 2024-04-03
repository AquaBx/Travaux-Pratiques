<?php
//affichage des erreurs côté PHP et côté MYSQLI
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL); 
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
//Import du site - A completer
require_once("./includes/constantes.php");      //constantes du site

?>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <meta name="author" content="">
        <meta name="keywords" content="">
        <link rel="icon" href="./favicon.ico"  type="image/icon">
        <link rel="stylesheet" href="./styles/style.css">
        <title>Festival</title>

        
    </head>
    <body>
        <?php include("./static/header.php"); ?>
        <?php include("./static/nav.php"); ?>

        <main>
            <section>
                
            <?php
            


            if ( isset($_POST["login"]) AND isset($_POST["pwd"]) ){
                session_start();
                $log = $_POST["login"];

                if (isset($_SESSION["login"]))
                {
                    echo "Vous êtes déjà connecté";
                }
                else{

                    $_SESSION["login"] = $log;
                    echo "Bonjour $log";
                }

            }
            else {
                echo "Bonjour, veuillez-vous connecter";
            }
            
            ?>
        
            </section>
        </main>


        <?php include("./static/footer.php"); ?>
    </body>
<!-- A compléter -->
</html>