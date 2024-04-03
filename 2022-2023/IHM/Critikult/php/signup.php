<?php
    session_start();
    
    if ( ! str_starts_with( $_SERVER["HTTP_REFERER"], $_SERVER["HTTP_ORIGIN"] )){
        header("Location: ../index.php");
    }
    elseif ( ! str_contains( $_SERVER["HTTP_REFERER"], "signup.php" )){
        header("Location: ../index.php");
    }

    include("../includes/config-bdd.php");
    include("../php/functions-DB.php");
    include("../php/functions_query.php");

    $mysqli = connectionDB();

    try{    
        $login     = $_POST["login"];
        $password  = hash("sha512",$_POST["password"]);
        $name      = $_POST["name"];
        $firstname = $_POST["firstname"];
        $email     = $_POST["email"];
        $birthday  = $_POST["birthday"];

        $age = ( time() - strtotime($birthday) )/60/60/24/365.25 ;



        if ($age<15){
            $_SESSION["form_msg"] = "Tu dois avoir 15 ans !";
            $_SESSION["form_result"] = "error";
            header("Location: " . $_SERVER["HTTP_REFERER"]);
        }
        
        $createUser = create_account($mysqli,$login,$password,$name,$firstname,$email,$birthday);
    }
    catch(Exception $e){
        $createUser = 0;
    }

    if ($createUser == 1) {
        $_SESSION["form_msg"] = "Votre compte a bien été créé";
        $_SESSION["form_result"] = "success";
        header("Location: ../login.php");
    }
    else{
        $_SESSION["form_msg"] = "Une erreur s'est produite";
        $_SESSION["form_result"] = "error";
        header("Location: " . $_SERVER["HTTP_REFERER"]);
    }

    closeDB($mysqli);
    
?>