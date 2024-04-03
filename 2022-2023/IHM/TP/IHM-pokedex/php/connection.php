<?php

if (isset($_POST["submit"])){

    $bdd = connectionDB();

    $dresseurs = dresseur_exists($bdd,$_POST["login"],$_POST["password"]);

    if (count($dresseurs) === 0 || $dresseurs === FALSE){
        infobox("Identifiants incorrects !");
    }
    else{
        $dresseur = $dresseurs[0];

        session_start();

        $_SESSION["login"] = $dresseur["nom_dresseur"];
        $_SESSION["id"] = $dresseur["id_dresseur"];
        $_SESSION["connected"] = TRUE;

        header("Location: ./index.php");
    }
    closeDB($bdd);
}