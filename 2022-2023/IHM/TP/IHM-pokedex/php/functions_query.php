<?php

function getPokedex($mysqli){
    $sql = "SELECT pokemon.id_pokemon,pokemon.numero,pokemon.nom,image.chemin FROM pokemon JOIN image ON pokemon.id_pokemon = image.id_pokemon WHERE image.chemin LIKE '%.gif' ORDER BY id_pokemon";
    return readDB($mysqli, $sql );
}

function get_info_poke($mysqli,$poke){
    return readDB($mysqli, "SELECT * FROM pokemon WHERE id_pokemon = $poke");
}

function get_types_poke($mysqli,$poke){
    return readDB($mysqli, "SELECT type.libelle FROM esttype JOIN type ON esttype.id_type = type.id_type WHERE esttype.id_pokemon = $poke ");
}

function get_capacities_poke($mysqli,$id){
    return readDB($mysqli, "
    SELECT capacite.libelle_capacite,capacite.pp_capacite,capacite.puissance_capacite,capacite.precision_capacite,type.libelle 
    
    as libelle_type FROM capacite 
    JOIN type ON capacite.id_type = type.id_type 
    JOIN lance ON capacite.id_capacite = lance.id_capacite
     WHERE lance.id_pokemon = $id ");
}

function get_imgs_poke($mysqli,$poke){
    return readDB($mysqli, "SELECT chemin FROM image WHERE id_pokemon = $poke");
}

function get_evos_poke($mysqli,$poke){
    // $evolution = readDB($mysqli, "SELECT evolue.id_pokemon_evolue,evolue.niveau,pokemon.nom FROM evolue  WHERE id_pokemon_base = $poke " );

    $evolution = readDB($mysqli, "
        WITH RECURSIVE pokevol AS (
            SELECT evolue.*,pokemon.nom,image.chemin
            FROM evolue
            JOIN pokemon ON pokemon.id_pokemon = evolue.id_pokemon_evolue

            JOIN image ON image.id_pokemon = pokemon.id_pokemon

            WHERE id_pokemon_base = $poke && image.chemin LIKE '%.gif'

            UNION ALL

            SELECT evolue.*,pokemon.nom,image.chemin
            FROM pokevol , evolue
            JOIN pokemon ON pokemon.id_pokemon = evolue.id_pokemon_evolue

            JOIN image ON image.id_pokemon = pokemon.id_pokemon

            WHERE pokevol.id_pokemon_evolue = evolue.id_pokemon_base && image.chemin LIKE '%.gif'
        )
        SELECT * FROM pokevol
    ");

    return $evolution;
}


function dresseur_exists($mysqli,$login,$password){

    $get = readDB($mysqli, "SELECT * FROM dresseur WHERE nom_dresseur = '$login' AND mdp_dresseur = '$password'");
    if (isset($get[0])){
        if ($get[0]["nom_dresseur"] == $login && $get[0]["mdp_dresseur"] == $password ){
            return $get;
        }
        else{
            return array();
        }
    }
    return $get;
}

function info_poke_dresseur($mysqli,$id_dresseur,$id_pokemon){
    return readDB($mysqli, "SELECT * FROM pokedex WHERE id_dresseur = '$id_dresseur' AND id_pokemon = '$id_pokemon' ");
}

function getPokedexDresseur($mysqli,$id_dresseur){
    $sql = "SELECT pokemon.id_pokemon,pokemon.numero,pokemon.nom,image.chemin,pokedex.nbVue,pokedex.nbAttrape 
            FROM pokemon
            JOIN image USING(id_pokemon)
            LEFT JOIN (SELECT * from pokedex WHERE id_dresseur = '$id_dresseur') as pokedex USING(id_pokemon)
            WHERE image.chemin LIKE '%.gif'
            ORDER BY id_pokemon";
    return readDB($mysqli, $sql );
}