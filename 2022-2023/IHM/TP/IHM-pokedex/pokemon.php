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

// redirection
session_start();
if (! isset($_GET["pokemon"])) {
    header("Location: index.php");
    exit();
}

?>

<html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <meta name="author" content="">
        <meta name="keywords" content="">
        <link rel="icon" href="./images/logo.svg"  type="image/icon">
        <link rel="stylesheet" href="./styles/style.css">
        <title><?php echo $titreSite; ?></title>

    </head>

    <body>
        <?php include("./static/header.php"); ?>
        <?php include("./static/nav.php"); ?>

        <main>
            <section>
                
                <?php

                $bdd = connectionDB();

                $poke = $_GET["pokemon"];

                $info_poke = get_info_poke($bdd,$poke)[0];
                $types = get_types_poke($bdd,$poke);
                display_infos($info_poke,$types);
    

                $imgs = get_imgs_poke($bdd,$poke);
                display_imgs($imgs);                   

                $capas = get_capacities_poke($bdd,$info_poke["id_pokemon"]) ;
                display_capacities($capas);

                $evolutions = get_evos_poke($bdd,$poke);
                display_evos($evolutions);

                if (isset($_SESSION["connected"])){
                    $infos_dresseur = info_poke_dresseur($bdd,$_SESSION["id"],$info_poke["id_pokemon"]);
                    display_poke_dresseur($infos_dresseur);
                }

                closeDB($bdd);

                ?>
        
            </section>
        </main>

        <?php include("./static/footer.php"); ?>
    </body>
</html>