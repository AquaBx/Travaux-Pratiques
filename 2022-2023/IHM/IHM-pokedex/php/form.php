<?php

if (isset($_POST["submit"])){

    $bdd = connectionDB();

    $id = $_SESSION["id"];
    $poke = $_POST["poke"];
    $vue = $_POST["vues"];
    $attrap = $_POST["attrap"];
    $exist = $_POST["exist"];


    try {
        if ($exist === "INSERT"){
            $resp = writeDB($bdd,"INSERT INTO pokedex VALUES ('$id','$poke','$vue','$attrap') ");
        }
        else{
            $resp = writeDB($bdd,"UPDATE pokedex SET nbVue=$vue,nbAttrape=$attrap WHERE id_dresseur=$id AND id_pokemon=$poke");
        }
    }
    catch (Exception $e){
        $resp = 0;
    }
    
    if ($resp == 1){
        infobox("Le Pokémon numéro $poke a été modifié");
    } 
    else{
        infobox("Une erreur est survenue");
    }

    closeDB($bdd);
    
}
