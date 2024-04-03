<?php 
date_default_timezone_set('Europe/Paris');


$hour = (int)date("G");

function message($hour){
    if ($hour < 12){
        return "Bonjour";
    }
    elseif ($hour < 17){
        return "Bon après midi";
    }
    else {
        return "Bonsoir";
    }
}

$msg = message($hour);
$date = date("d/m/y");
echo "$msg, nous sommes le $date"; 
