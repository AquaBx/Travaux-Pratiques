<?php
    session_start();

    if ( ! str_starts_with( $_SERVER["HTTP_REFERER"], $_SERVER["HTTP_ORIGIN"] )){
        header("Location: ../index.php");
    }
    elseif ( ! str_contains( $_SERVER["HTTP_REFERER"], "modif_profil.php" )){
        header("Location: ../index.php");
    }  
    elseif ( $_POST["id"] != $_SESSION["id"] ){
        header("Location: ../index.php");
        exit();
    }

    include("../includes/config-bdd.php");
    include("../php/functions-DB.php");
    include("../php/functions_query.php");

    $mysqli = connectionDB();        

    try{

        $id = $_POST["id"];
        $nom = $_POST["nom"];
        $prenom = $_POST["prenom"];
        $login = $_POST["login"];
        $email = $_POST["email"];

        if ($_FILES["pdp"]["size"] >= 1048576){
            $updateuser = 2;
        }
        elseif ($_FILES["pdp"]["size"] !== 0){
            $pdp = $_FILES["pdp"];
            $pdp = file_get_contents($pdp['tmp_name']);
            $updateuser = update_user_pdp($mysqli,$id,$login,$nom,$prenom,$email,$pdp);
        }
        else{
            $updateuser = update_user($mysqli,$id,$login,$nom,$prenom,$email);
        }
        
    }
    catch(Exception $e){
        $updateuser = 0;
    }

    if ($updateuser == 1) {
        $_SESSION["form_msg"] = "Votre profil a bien été modifié";
        $_SESSION["form_result"] = "success";
    }
    elseif ($updateuser == 2) {
        $_SESSION["form_msg"] = "L'image est supérieur à 1Mo !";
        $_SESSION["form_result"] = "error";
    }
    else{
        $_SESSION["form_msg"] = "Une erreur s'est produite";
        $_SESSION["form_result"] = "error";
    }

    closeDB($mysqli);
    header("Location: " . $_SERVER["HTTP_REFERER"]);

?>