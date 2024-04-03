<?php 
    session_start();
    
    include("./includes/config-bdd.php");
    include("./php/functions-DB.php");
    include("./php/functions_query.php");
    include("./php/functions_structure.php");

    if ( ! isset($_GET["id"])){
        header("Location: index.php");
        exit();
    }


    $mysqli = connectionDB();

    $user = getUserById($mysqli,$_GET["id"]);

    if ( ! isset($user[0])){
        header("Location: index.php");
        exit();
    }

    $user=$user[0];

    $login = $user["login"];

    $id = $user["id"];
    $pdp = $user['pdp'];
    $name = $user['prenom'] . " " . $user['nom'] ;
    $privi = $user['privilege'];
    $date_creation = $user['date_creation'];
    $date_last_login = $user['date_last_login'];
    $birthday = $user['birthday'] ;
    $email = $user['email'] ;

    $avis = InfosAvisUser($mysqli,$id);
    $articles = ProfilArticles($mysqli,$id);

    if (isset($_SESSION["id"])){
        $privisession = getPriviByUserId($mysqli,$_SESSION["id"]);
    }
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

    <main>
    <?php

    profil($pdp,$name,$login,$privi,$date_creation,$date_last_login,$birthday,$email);

    echo "<h2>Avis</h2>";

    if (isset($_SESSION["id"])){
        display_profil_avis($avis,$privisession,$_SESSION["id"]);
    }
    else{
        display_profil_avis($avis,'','');
    }

    echo "<h2>Articles</h2>";

    display_articles($articles);
?>
</main>
</body>
</html>