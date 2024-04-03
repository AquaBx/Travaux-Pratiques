<?php
//affichage des erreurs côté PHP et côté MYSQLI
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL); 
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
//Import du site - A completer
require_once("./includes/constantes.php");      //constantes du site

include("./php/functions-DB.php");

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);



?>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <meta name="author" content="">
        <meta name="keywords" content="">
        <link rel="icon" href="./favicon.ico"  type="image/icon">
        <link rel="stylesheet" href="./styles/style.css">
        <title>Festival</title>

        
    </head>
    <body>
        <?php include("./static/header.php"); ?>
        <?php include("./static/nav.php"); ?>
        
        <?php
            $bdd = connectionDB();

            $table = readDB($bdd,"SELECT nomEtudiant,prenomEtudiant FROM etudiant");

            echo "<pre>";
            foreach ( $table as $row){
                echo $row["prenomEtudiant"] . " " . $row["nomEtudiant"] . "\n";
            }
            echo "</pre>";


            if (isset($_POST["ajout_note"])){
                
    
                $note = $_POST["note"];
                $mat = $_POST["mat"];
                $etu = $_POST["etu"];
                $req = "INSERT INTO etudiantmatiere (note, codeMatiere, id_etudiant) VALUES ($note,'$mat','$etu')";
                // echo $req;
                $table = writeDB($bdd,$req);
    
                print_r($table);
    

            }
            elseif ( isset($_POST["modif_note"]) ){
                $note = $_POST["note"];
                $mat = $_POST["mat"];
                $etu = $_POST["etu"];
                $req = "UPDATE etudiantmatiere SET note=$note WHERE codeMatiere='$mat' AND id_etudiant='$etu'";
                // echo $req;
                $table = writeDB($bdd,$req);
    
                print_r($table);
            }
            
            elseif ( isset($_POST["delete_note"]) ){
                $mat = $_POST["mat"];
                $etu = $_POST["etu"];
                $req = "DELETE FROM etudiantmatiere WHERE codeMatiere='$mat' AND id_etudiant='$etu'";
                // echo $req;
                $table = writeDB($bdd,$req);
    
                print_r($table);
            }
            
            closeDB($bdd);
        ?>

        

        <hr>

        <form action="#" method="post">
            <input name="ville" required type="text" placeholder="ville">
            <input name="sub_ville" type="submit">
        </form>

        <hr>

        <form action="#" method="post">
            <input name="note" required type="text" placeholder="note">
            <input name="mat" required type="text" placeholder="mat">
            <input name="etu" required type="text" placeholder="etu">
            <input name="ajout_note" type="submit" value="Ajouté">
            <input name="modif_note" type="submit" value="Modif">
        </form>

        <hr>

        <form action="#" method="post">
            <input name="mat" required type="text" placeholder="mat">
            <input name="etu" required type="text" placeholder="etu">
            <input name="delete_note" type="submit" value="Remove">
        </form>

        <?php include("./static/footer.php"); ?>
    </body>
<!-- A compléter -->
</html>