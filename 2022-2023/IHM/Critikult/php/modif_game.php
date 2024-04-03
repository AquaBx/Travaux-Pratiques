<?php
    session_start();

    if ( ! str_starts_with( $_SERVER["HTTP_REFERER"], $_SERVER["HTTP_ORIGIN"] )){
        header("Location: ../index.php");
    }
    elseif ( ! str_contains( $_SERVER["HTTP_REFERER"], "modif_game.php" )){
        header("Location: ../index.php");
    }

    include("../includes/config-bdd.php");
    include("../php/functions-DB.php");
    include("../php/functions_query.php");

    $mysqli = connectionDB();

    if (isset($_POST["game"])){    

        try{
            $id = $_POST["id"];
            $nom = $_POST["nom"];
            $synopsis = $_POST["synopsis"];
            $date_sortie = $_POST["date"];
            $prix = $_POST["prix"];

            if ($_FILES["couverture"]["size"]  >= 1048576){
                $updategame = 2;
            }
            elseif ($_FILES["couverture"]["size"] !== 0){
                $couverture = $_FILES["couverture"];
                $couverture_content = file_get_contents($couverture['tmp_name']);
                $updategame = update_game_couv($mysqli,$nom,$prix,$date_sortie,$synopsis,$couverture_content,$id);
            }
            else{
                $updategame = update_game($mysqli,$nom,$prix,$date_sortie,$synopsis,$id);
            }
            
        }
        catch(Exception $e){
            $updategame = 0;
        }

    }
    elseif (isset($_POST["newillus"])){    
    
        try{

            $illustration = $_FILES["illustration"];

            if ($illustration["size"]  >= 1048576){
                $updategame = 2;
            }
            else {
                $id = $_POST["id"];
                $illustration_content = file_get_contents($illustration['tmp_name']);
                $updategame = upload_illus($mysqli,$illustration_content,$id);
            }

            
        }
        catch(Exception $e){
            $updategame = 0;
        }
    
    }

    elseif (isset($_POST["categories"])){
        
        try{
            $id_jeu = $_POST["id"];
            
            if (isset($_POST["categorie"])){
                $categories = $_POST["categorie"];
                $updategame = insert_categorie($mysqli,$id_jeu,$categories);
                $updategame = delete_categorie($mysqli,$id_jeu,$categories);
            }
            else{
                $updategame = delete_categorie($mysqli,$id_jeu);
            }
        }
        catch(Exception $e){
            $updategame = 0;
        }
    }
    elseif (isset($_POST["supports"])){ 

        try{
            print_r($_POST);
            $id_jeu = $_POST["id"];

            if (isset($_POST["support"])){
                $supports = $_POST["support"];
                $updategame = insert_support($mysqli,$id_jeu,$supports);
                $updategame = delete_support($mysqli,$id_jeu,$supports);
            }
            else{
                $updategame = delete_support($mysqli,$id_jeu);
            }
            
        }
        catch(Exception $e){
            $updategame = 0;
        }

    }

    if ($updategame == 1) {
        $_SESSION["form_msg"] = "Votre jeu a bien été modifié";
        $_SESSION["form_result"] = "success";
    }
    elseif ($updategame == 2) {
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