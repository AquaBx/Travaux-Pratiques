<?php
    session_start();

    if ( ! str_starts_with( $_SERVER["HTTP_REFERER"], $_SERVER["HTTP_ORIGIN"] )){
        header("Location: ../index.php");
    }
    elseif ( ! str_contains( $_SERVER["HTTP_REFERER"], "new_article.php" )){
        header("Location: ../index.php");
    }

    include("../includes/config-bdd.php");
    include("../php/functions-DB.php");
    include("../php/functions_query.php");

    $mysqli = connectionDB();

    try{        
        $titre  = $_POST["Titre"];
        $corps  = $_POST["corps"];
        $note   = $_POST["note"];
        $jeu    = $_POST["jeu"];
        $id     = $_SESSION["id"];
        
        $createArticle = create_article($mysqli,$titre,$corps,$note,$id,$jeu);
    }
    catch(Exception $e){
        $createArticle = 0;
    }

    if ($createArticle == 1) {
        $_SESSION["form_msg"] = "Votre article a bien été publié";
        $_SESSION["form_result"] = "success";
    }
    else{
        $_SESSION["form_msg"] = "Une erreur s'est produite";
        $_SESSION["form_result"] = "error";
    }

    closeDB($mysqli);

    header("Location: " . $_SERVER["HTTP_REFERER"]);

?>