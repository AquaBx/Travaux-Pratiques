<?php    
    session_start();
    
    if ( ! str_starts_with( $_SERVER["HTTP_REFERER"], $_SERVER["HTTP_ORIGIN"] )){
        header("Location: ../index.php");
    }
    elseif ( ! str_contains( $_SERVER["HTTP_REFERER"], "new_game.php" )){
        header("Location: ../index.php");
    }

    include("../includes/config-bdd.php");
    include("../php/functions-DB.php");
    include("../php/functions_query.php");

    $mysqli = connectionDB();

    try{
        $nom = $_POST["nom"];
        $synopsis = $_POST["synopsis"];
        $date_sortie = $_POST["date"];
        $couverture = $_FILES["couverture"];
        $prix = $_POST["prix"];

        if ($couverture["size"] >= 1048576){
            $creategame = 2;
        }
        else {
            $couverture_content = file_get_contents($couverture['tmp_name']);
            $creategame = create_game($mysqli,$nom,$prix,$date_sortie,$synopsis,$couverture_content);
        }
    }
    catch(Exception $e){
        $creategame = 0;
    }

    if ($creategame == 1) {
        $_SESSION["form_msg"] = "Votre jeu a bien été ajouté";
        $_SESSION["form_result"] = "success";
    }
    elseif ($creategame == 2) {
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