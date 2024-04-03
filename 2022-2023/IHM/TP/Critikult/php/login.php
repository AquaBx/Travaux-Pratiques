<?php
    session_start();

    if ( ! str_starts_with( $_SERVER["HTTP_REFERER"], $_SERVER["HTTP_ORIGIN"] )){
        header("Location: ../index.php");
    }
    elseif ( ! str_contains( $_SERVER["HTTP_REFERER"], "login.php" )){
        header("Location: ../index.php");
    }

    include("../includes/config-bdd.php");
    include("../php/functions-DB.php");
    include("../php/functions_query.php");

    $mysqli = connectionDB();

    $login     = $_POST["login"];
    $password  = hash("sha512",$_POST["password"]);
    $getuser = getUser($mysqli,$login);

    if (!isset($getuser[0])) {
        $_SESSION["form_msg"] = "Utilisateur inconnu";
        $_SESSION["form_result"] = "error";

        header("Location: " . $_SERVER["HTTP_REFERER"]);
    }
    elseif ($getuser[0]["password"] === $password) {

        $_SESSION["id"] = $getuser[0]["id"];
        $_SESSION["privilege"] = $getuser[0]["privilege"];

        $_SESSION["form_msg"] = "Bienvenue";
        $_SESSION["form_result"] = "success";

        connect($mysqli,$getuser[0]["id"]);

        header("Location: ../index.php");
    }
    else{
        $_SESSION["form_msg"] = "Mot de passe incorect";
        $_SESSION["form_result"] = "error";
        header("Location: " . $_SERVER["HTTP_REFERER"]);
    }

    closeDB($mysqli);

?>
