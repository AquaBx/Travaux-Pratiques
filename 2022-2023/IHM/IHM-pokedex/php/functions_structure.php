<?php

function display_imgs($imgs){
    echo "<div class='flexpoke'>";
    foreach ($imgs as $img){
        echo "<img alt='poke' src='" . $img["chemin"] . "'>";
    } 
    echo "</div>";
}

function display_infos($info_poke,$types){
    echo "<span class='poketitle'>";
    echo "<h2>" . $info_poke["nom"] . "";
    echo " #" . $info_poke["numero"] . "</h2>";
    foreach ($types as $type){
        echo "<img alt='type' src='./images/types/Miniature_Type_" . $type["libelle"] . "_EV.png'>" ;
    }
    echo "</span>";
    echo "<p>" . $info_poke["description"] . "</p>" ;
}


function display_capacities($capas){
    if ($capas == []) return;

    echo "<table>";

    echo "<thead><tr>";
    echo "<td>Capacité</td>";
    echo "<td>Power Point</td>";
    echo "<td>Puissance</td>";
    echo "<td>Précision</td>";
    echo "<td>Type</td>";
    echo "</tr></thead>";

    foreach ($capas as $capa){
        echo "<tr>";
        echo "<td>" . $capa["libelle_capacite"] . "</td>";
        echo "<td>" . $capa["pp_capacite"] . "</td>";
        echo "<td>" . $capa["puissance_capacite"] . "</td>";
        echo "<td>" . $capa["precision_capacite"] . "</td>";
        echo "<td>" . $capa["libelle_type"] . "</td>";
        echo "</tr>";
    }
    echo "</table>";
}


function display_evos($capas){
    if ($capas == []) return;
    echo "<table>";

    echo "<thead><tr>";
    echo "<td>Nom Evolution</td>";
    echo "<td>Niveau</td>";
    echo "</tr></thead>";

    foreach ($capas as $capa){
        echo "<tr>";
        echo "<td>";
        echo "<img alt='capacité' src='" . $capa["chemin"] . "'>";
        echo $capa["nom"] . "</td>";
        echo "<td>" . $capa["niveau"] . "</td>";
        echo "</tr>";
    }
    echo "</table>";
}

function display_poke_dresseur($infos){
    if ($infos == []) return;

    echo "<table>";

    echo "<thead><tr>";
    echo "<td>Vues</td>";
    echo "<td>Capturés</td>";
    echo "</tr></thead>";

    foreach ($infos as $info){
        echo "<tr>";
        echo "<td>" . $info["nbVue"] . "</td>";
        echo "<td>" . $info["nbAttrape"] . "</td>";
        echo "</tr>";
    }
    echo "</table>";
}

function displayPokedex($pokedex) {
    
    echo "<div class='gridpoke'>";
    foreach($pokedex as $pokemon){

        $class = array();
        if ( !(isset($pokemon["nbVue"]) && $pokemon["nbVue"]) && isset($_SESSION["connected"]) ){
            array_push($class,"vue");
        }
        if (isset($pokemon["nbAttrape"]) && $pokemon["nbAttrape"]){
            array_push($class,"attrape");
        }

        $classes = implode(" ", $class);

        echo "<div class='$classes'>";
        echo "<a href='pokemon.php?pokemon=".$pokemon["id_pokemon"]."'><img alt='". $pokemon["nom"] ."' src='". $pokemon["chemin"] ."'></a>";
        echo "<h3>" . $pokemon["nom"] ."</h3>";
        echo "<p>#" . $pokemon["numero"] ."</p>";
        echo "</div>";
    }
    echo "</div>";
}

function structure_option($table){
    foreach($table as $poke){
        $pokename = $poke["nom"];
        $pokeid = $poke["id_pokemon"];

        if (isset($_GET["poke"]) && $_GET["poke"] == $pokeid){
            echo "<option selected value='$pokeid'>$pokename</option>";
        }
        else{
            echo "<option value='$pokeid'>$pokename</option>";
        }
    }
}

function infobox($msg){
    echo "<div class='infobox'>$msg</div>";
}