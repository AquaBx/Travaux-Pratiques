<navbar>
    <?php
        
    ?>
    <div><a href="./index.php"><h1>Critikult</h1></a></div>
    
    <div class="icons" >

        
        <a href="./recherche.php"><i class="fa-solid fa-magnifying-glass"></i></a>

        <?php if (isset($_SESSION["privilege"]) ) { if ( $_SESSION["privilege"]==="rédacteur" || $_SESSION["privilege"]==="administrateur"){ ?>
        
        <div tabindex="-1" class="dropbox">
            <a class='btn'><i class='fa-solid fa-toolbox'></i></a>
            <ul class="hide">

                <?php

                echo "<li><a href='./new_article.php'>Créer un article</a></li>";
                echo "<li><a href='./modif_article.php'>Modifier un article</a></li>";
                echo "<li><a href='./new_game.php'>Ajouter un jeu</a></li>";
                echo "<li><a href='./modif_game.php'>Modifier un jeu</a></li>";

                if ($_SESSION["privilege"]==="administrateur"){
                    echo "<li><a href='./admin.php'>Administration</a></li>";
                }
                ?>
                
            </ul>
        </div>
        <?php }} ?>

        <div tabindex="-1" class="dropbox">
            <a class='btn'><i class="fa-regular fa-circle-user"></i></a>
            <ul class="hide">

                <?php
                if (isset($_SESSION["id"])){
                    $idlogin = $_SESSION["id"];


                    echo "<li><a href='./profil.php?id=$idlogin'>Profil</a></li>";
                    echo "<li><a href='./modif_profil.php'>Paramètres</a></li>";
                    echo "<li><a href='./php/logout.php'>Déconnexion</a></li>";
                }
                else{
                    echo "<li><a href='./login.php'>Connexion</a></li>";
                    echo "<li><a href='./signup.php'>Créer un compte</a></li>";
                }
                ?>
                
            </ul>


        </div>
    </div>
</navbar>
