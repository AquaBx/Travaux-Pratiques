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
if (! isset($_SESSION["connected"])){
    header("Location: ./index.php");
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
        <link rel="stylesheet" href="./styles/form2.css">
        <title><?php echo $titreSite; ?></title>

    </head>
    <body>
        <?php include("./static/header.php"); ?>
        <?php include("./static/nav.php"); ?>

        <!-- script pour le formulaire -->
        <?php include("./php/form.php"); ?>

        <main>
            <section>

            <form action="./form.php" method="get">
                    <?php
                    
                    $bdd = connectionDB();

                    echo "<label>Sélectionner votre pokémon : </label><br>";
                    echo "<select name='poke'>";
                    $table = getPokedexDresseur($bdd,$_SESSION["id"]);
                    
                    structure_option($table);
                    echo "</select>";
                    echo "<input type=submit value='Séléctionner'>";

                    ?>
                </form>

                <form action="." method="POST">
                    <?php
                    
                    if (isset($_GET["poke"])){
                        $infos = info_poke_dresseur($bdd,$_SESSION["id"],$_GET["poke"]);
                        if (isset( $infos[0])){
                            $attrap = $infos[0]["nbAttrape"];
                            $exist = "UPDATE";
                            $vues = $infos[0]["nbVue"];
                        }
                        else{
                            $attrap = 0;
                            $exist = "INSERT";
                            $vues = 0;
                        }
                        $poke = $_GET["poke"];
                        echo "<input type='hidden' name='exist' value='$exist'>";
                        echo "<input type='hidden' type='poke' name='poke' value='$poke'>";
                        echo "<label for='att'>Attrapés : </label><input min=0 id='att' name='attrap' type='number' value='$attrap'><br><br>";
                        echo "<label for='vue'>Vues : </label><input min=0 id='vue' name='vues' type='number' value='$vues'><br><br>";
                        echo "<input type=submit name='submit' value='Ajouter/Modifier'>";
                        
                    }
                    else{
                        echo "Veuillez sélectionner un pokémon puis cliquer sur le bouton .";
                    }
                    
                    closeDB($bdd);

                    ?>
                <form>

            </section>
        </main>


        <?php include("./static/footer.php"); ?>
    </body>
<!-- A compléter -->
</html>
