<?php

$chaine = array("Iron Man","Avengers","Dune");
$chaine2 = array("Iron Man" => 5e5,"Avengers" => 6e8 ,"Dune" => 3e2);
// echo $chaine;
// echo "<br/>";
// print_r($chaine);
// echo "<br/>";
// var_dump($chaine);



function to_table($arr){
    $table = "<table><tbody>";
    foreach($arr as $key => $val){
        $table = $table . "<tr><td>$key</td><td>$val</td></tr>";
    }
    $table = $table . "</tbody></table>";
    return $table;
}

function to_liste($arr){
    $ul = "<ul>";
    foreach($arr as $key => $val){
        $ul = $ul . "<li>$val</li>";
    }
    $ul = $ul . "</ul>";
    return $ul;
}

if (isset($chaine)) {
    echo '<p>$chaine existe</p>';
    echo to_table($chaine);
    echo to_liste($chaine);
    echo to_table($chaine2);
}