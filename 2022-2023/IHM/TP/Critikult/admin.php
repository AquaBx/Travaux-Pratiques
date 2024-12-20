<?php 
    session_start();
    
    include("./includes/config-bdd.php");
    include("./php/functions-DB.php");
    include("./php/functions_query.php");
    include("./php/functions_structure.php");

    if(!isset($_SESSION["privilege"])){
      header("Location: index.php");
      exit();
    }

    $mysqli = connectionDB();
    $privi = getPriviByUserId($mysqli,$_SESSION["id"]);
    closeDB($mysqli);

    
    if($privi !== "administrateur" ){
      header("Location: index.php");
      exit();
    }

    $mysqli = connectionDB();
    $users = getUsers($mysqli);
    closeDB($mysqli);

?>

<!DOCTYPE html>
<html lang="fr">
    <head>
        <link rel="stylesheet" href="./css/index.css">

        <link rel="stylesheet" href="./fontawesome/css/solid.min.css">
        <link rel="stylesheet" href="./fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./fontawesome/css/regular.min.css">
        <link rel="stylesheet" href="./fontawesome/css/brands.min.css">       

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Critikult</title>
        <link rel="icon" href="./images/favicon.webp">
        <meta name="author" content="Jean-Eudes BORNERT Tom CHAUVEL">
        <meta name="keywords" content="Jeux video">
    </head>

    <body>
        <?php include("./static/nav.php");  ?>
        <?php include("./static/modal.php");  ?>

        <?php liste_users($users); ?>

        </body>

</html>