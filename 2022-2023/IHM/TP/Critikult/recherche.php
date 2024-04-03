<?php 
    session_start();
    
    include("./includes/config-bdd.php");
    include("./php/functions-DB.php");
    include("./php/functions_query.php");
    include("./php/functions_structure.php");

    $mysqli=connectionDB();
    $categories = getCategories($mysqli);


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
    <?php include("./static/nav.php"); ?>
    <?php include("./static/modal.php");  ?>

    <main>

        <h2>Recherche</h2>
        <form method="GET" action="./index.php">

            <label for="name">Nom du jeu</label>
            <input id="name" name="name">

            <label for="categorie">Catégorie du jeu</label>
            <select id='categorie' name="categorie">
                <option value=''>
            <?php 
            OptionsCategories($categories);
            
            ?>
            </select>

            <input type="submit">
        </form>



    </main>
</body>


</html>
