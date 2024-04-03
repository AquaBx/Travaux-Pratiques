<?php
    session_start();

    if ( ! str_starts_with( $_SERVER["HTTP_REFERER"], $_SERVER["HTTP_ORIGIN"] )){
        header("Location: ../index.php");
    }
    elseif ( ! str_contains( $_SERVER["HTTP_REFERER"], "article.php" )){
        header("Location: ../index.php");
    }

    include("../includes/config-bdd.php");
    include("../php/functions-DB.php");
    include("../php/functions_query.php");

    $mysqli = connectionDB();

    try{
        $commentaire = $_POST["commentaire"];
        $note = $_POST["note"];
        $id_jeu = $_POST["id_jeu"];
        $id = $_SESSION["id"];

        if (isset($_POST["new_avis"])){
            $createAvis = create_avis($mysqli,$commentaire,$note,$id,$id_jeu);
        }
        elseif (isset($_POST["modif_avis"])){
            $createAvis = modif_avis($mysqli,$commentaire,$note,$id,$id_jeu);
        }
    }
    catch(Exception $e){
        $createAvis = 0;
    }

    if ($createAvis == 1) {
        $_SESSION["form_msg"] = "Votre avis a bien été créé";
        $_SESSION["form_result"] = "success";
    }
    else{
        $_SESSION["form_msg"] = "Une erreur s'est produite";
        $_SESSION["form_result"] = "error";
    }

    closeDB($mysqli);
    header("Location: " . $_SERVER["HTTP_REFERER"]);

?>
