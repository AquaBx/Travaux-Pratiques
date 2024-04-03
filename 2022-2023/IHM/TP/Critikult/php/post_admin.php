<?php
    session_start();

    if ( ! str_starts_with( $_SERVER["HTTP_REFERER"], $_SERVER["HTTP_ORIGIN"] )){
        header("Location: ../index.php");
    }
    elseif ( ! str_contains( $_SERVER["HTTP_REFERER"], "admin.php" )){
        header("Location: ../index.php");
    } 

    include("../includes/config-bdd.php");
    include("../php/functions-DB.php");
    include("../php/functions_query.php");

    $mysqli = connectionDB();

    try{
        $id  = $_POST["id"];
        $privilege  = $_POST["fonction"];
        $modifpriv = modifPrivi($mysqli,$id,$privilege);
    }
    catch(Exception $e){
        $modifpriv = 0;
    }

    if ($modifpriv == 1) {
        $_SESSION["form_msg"] = "Les privilèges de l'utilisateur ont été modifiés";
        $_SESSION["form_result"] = "success";
    }
    else{
        $_SESSION["form_msg"] = "Une erreur s'est produite";
        $_SESSION["form_result"] = "error";
    }

    closeDB($mysqli);
    header("Location: " . $_SERVER["HTTP_REFERER"]);

?>