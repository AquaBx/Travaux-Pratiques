<?php
    session_start();

    include("../includes/config-bdd.php");
    include("../php/functions-DB.php");
    include("../php/functions_query.php");

    $mysqli = connectionDB();

    try{
        $id_jeu = $_GET["id_jeu"];
        $id = $_GET["id"];

        if ( $_GET["id"] != $_SESSION["id"] && getPriviByUserId($mysqli,$_SESSION["id"]) !== 'administrateur' ){
            header("Location: ../index.php");
            exit();
        }

        $delete = delete_avis($mysqli,$id_jeu,$id);
    }
    catch(Exception $e){
        $delete = 0;
    }

    if ($delete == 1) {
        $_SESSION["form_msg"] = "Votre avis a bien été supprimé";
        $_SESSION["form_result"] = "success";
    }
    else{
        $_SESSION["form_msg"] = "Une erreur s'est produite";
        $_SESSION["form_result"] = "error";
    }

    closeDB($mysqli);
    header("Location: " . $_SERVER["HTTP_REFERER"]);

?>
