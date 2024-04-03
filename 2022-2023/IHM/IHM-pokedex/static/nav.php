<nav>
    <ul>
        <li><a href="index.php">Home</a></li>

        <?php
        if (isset($_SESSION["connected"])){
        ?>

            <li><a href="form.php">Formulaire</a></li>
            <li><a href="./php/logout.php">Déconnection</a></li>

        <?php
            } else {
        ?>

            <li><a href="connection.php">Connection</a></li>

        <?php
            }
        ?>

    </ul>
</nav>