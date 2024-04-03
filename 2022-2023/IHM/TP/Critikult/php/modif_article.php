<?php
    session_start();

    if ( ! str_starts_with( $_SERVER["HTTP_REFERER"], $_SERVER["HTTP_ORIGIN"] )){
        header("Location: ../index.php");
    }
    elseif ( ! str_contains( $_SERVER["HTTP_REFERER"], "modif_article.php" )){
        header("Location: ../index.php");
    }

    include("../includes/config-bdd.php");
    include("../php/functions-DB.php");
    include("../php/functions_query.php");

    $mysqli = connectionDB();

    try{
        $id = $_POST["id"];
        $titre  = $_POST["titre"];
        $contenu  = $_POST["contenu"];
        $note   = $_POST["note"];

        $update_article = update_article($mysqli,$titre,$contenu,$note,$id);
    }
    catch(Exception $e){
        $update_article = 0;
    }

    if ($update_article == 1) {
        $_SESSION["form_msg"] = "Votre article a bien été modifié";
        $_SESSION["form_result"] = "success";
    }
    else{
        $_SESSION["form_msg"] = "Une erreur s'est produite";
        $_SESSION["form_result"] = "error";
    }

    closeDB($mysqli);
    header("Location: " . $_SERVER["HTTP_REFERER"]);

?>