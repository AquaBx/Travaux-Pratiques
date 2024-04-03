<?php
date_default_timezone_set('Etc/GMT+2');

//Menu  avec tous les articles
function MenuArticles($mysqli,$nombres,$offset,$categorie,$name){
    if ($categorie == "") {
        $sql = "SELECT DISTINCT article.id, jeu.nom as jeu,article.titre,article.date_creation,jeu.couverture FROM jeu 
        LEFT JOIN est_categorise ON jeu.id = est_categorise.id_jeu 
        JOIN article ON jeu.id = article.id_jeu 

        LEFT JOIN categorie ON est_categorise.id_categorie = categorie.id_categorie

        WHERE jeu.nom LIKE ?
        ORDER BY article.date_creation DESC LIMIT ? OFFSET ?;
        ";
        $list = ['%'.$name.'%',$nombres,$offset];

    }
    else{
            $sql = "SELECT DISTINCT article.id, jeu.nom as jeu,article.titre,article.date_creation,jeu.couverture FROM jeu 
            LEFT JOIN est_categorise ON jeu.id = est_categorise.id_jeu 
            JOIN article ON jeu.id = article.id_jeu 
    
            LEFT JOIN categorie ON est_categorise.id_categorie = categorie.id_categorie
    
            WHERE jeu.nom LIKE ? AND categorie.id_categorie LIKE ? 
            ORDER BY article.date_creation DESC LIMIT ? OFFSET ?;
            ";
            $list = ['%'.$name.'%',$categorie,$nombres,$offset];
    }

    return readPrepare($mysqli, $sql, $list  );
}

function ProfilArticles($mysqli,$id_redac){

    $sql = "SELECT DISTINCT article.id, jeu.nom as jeu,article.titre,article.date_creation,jeu.couverture FROM jeu 
    JOIN article ON jeu.id = article.id_jeu 

    WHERE id_redacteur=?
    ORDER BY article.date_creation DESC;
    ";

    $list = [$id_redac];
    return readPrepare($mysqli, $sql, $list  );
}

function countArticles($mysqli,$categorie,$name){

    $sql = "SELECT count(*) as nb FROM ( 
        SELECT DISTINCT article.id FROM jeu 
        LEFT JOIN est_categorise ON jeu.id = est_categorise.id_jeu 
        JOIN article ON jeu.id = article.id_jeu 

        LEFT JOIN categorie ON est_categorise.id_categorie = categorie.id_categorie

        WHERE jeu.nom LIKE ? AND ( categorie.id_categorie LIKE ? OR categorie.id_categorie IS NULL )
    ) AS subquery
    ";

    if ($categorie == "") { $categorie = "%";}


    $list = ['%'.$name.'%',$categorie];

    return readPrepare($mysqli, $sql, $list  )[0]["nb"];
}

//Fonctions pour les infos de chaque article
function InfosArticle($mysqli,$id_art){
    $sql="SELECT * FROM jeu JOIN article ON jeu.id = article.id_jeu WHERE article.id=?";
    $list = [$id_art];
    return readPrepare($mysqli, $sql, $list );
}

function CategorieJeu($mysqli,$id_jeu){
    $sql="SELECT categorie.nom FROM est_categorise JOIN categorie ON categorie.id_categorie = est_categorise.id_categorie WHERE est_categorise.id_jeu=?";
    $list = [$id_jeu];
    return readPrepare($mysqli, $sql, $list );
}

function SupportJeu($mysqli,$id_jeu){
    $sql="SELECT support.nom FROM est_supporte JOIN support ON est_supporte.id_support = support.id_support WHERE est_supporte.id_jeu=?";
    $list = [$id_jeu];
    return readPrepare($mysqli, $sql, $list );
}

function InfosAvis($mysqli,$id_jeu){
    $sql="SELECT *  FROM avis JOIN user on avis.id_user = user.id  WHERE id_jeu=? ORDER BY date DESC";
    $list = [$id_jeu];
    return readPrepare($mysqli, $sql, $list );
}

function InfosAvisUser($mysqli,$id_user){
    $sql="SELECT avis.*,user.id as id_user,article.id as id_art, article.titre as titre_art  FROM avis JOIN user on avis.id_user = user.id JOIN article ON article.id_jeu = avis.id_jeu WHERE id_user=? ORDER BY date DESC";
    $list = [$id_user];
    return readPrepare($mysqli, $sql, $list );
}

function InfosJeu($mysqli,$id_jeu){
    $sql="SELECT *  FROM jeu WHERE id=?";
    $list = [$id_jeu];
    return readPrepare($mysqli, $sql, $list );
}


function getIllustrationByJeu($mysqli,$id_jeu){
    $sql="SELECT *  FROM images WHERE id_jeu=?";
    $list = [$id_jeu];
    return readPrepare($mysqli, $sql, $list );
}


//Fonction permettant de modifier les droits d'un utilisateur

function getUsers($mysqli){
    $sql = "SELECT * FROM user";
    return readDB($mysqli, $sql );
}

function getUserById($mysqli,$id){
    $sql = "SELECT * FROM user WHERE id=?";
    $list = [$id];
    return readPrepare($mysqli, $sql, $list );
}

function getUser($mysqli,$login){
    $sql = "SELECT * FROM user WHERE login=?";
    $list = [$login];
    return readPrepare($mysqli, $sql, $list );
}


function getPriviByUserId($mysqli,$id){
    $sql = "SELECT privilege FROM user WHERE id=?";
    $list = [$id];
    return readPrepare($mysqli, $sql, $list )[0]["privilege"];
}

function getArticlesByRedac($mysqli,$id){
    $sql = "SELECT * FROM article WHERE id_redacteur=?";
    $list = [$id];
    return readPrepare($mysqli, $sql, $list );
}

function getJeux($mysqli){
    $sql = "SELECT * FROM jeu";
    $list = [];
    return readPrepare($mysqli, $sql, $list );
}

//Fonction pour la création d'un compte 
function upload_illus($mysqli,$data,$id_jeu){
    $sql = "INSERT into images (id_jeu,data) VALUES (?,?)";
    $list=[$id_jeu,$data];
    return writePrepare($mysqli, $sql,$list);
}

function create_game($mysqli,$nom,$prix,$date_sortie,$synopsis,$couverture){
    $sql = "INSERT into jeu ( nom,prix,date_sortie,synopsis,couverture ) VALUES (?,?,?,?,?)";
    $list=[$nom,$prix,$date_sortie,$synopsis,$couverture];
    return writePrepare($mysqli, $sql,$list);
}

function create_account($mysqli,$login,$password,$name,$firstname,$email,$birthday){
    $sql = "INSERT into user (login,password,nom,prenom,email,birthday) VALUES (?,?,?,?,?,?)";
    $list=[$login,$password,$name,$firstname,$email,$birthday];
    return writePrepare($mysqli, $sql,$list);
}

function connect($mysqli,$id){
    $update = "SET GLOBAL time_zone = '+2:00';";
    writeDB($mysqli,$update);
    $sql = "UPDATE user SET date_last_login=NOW() WHERE user.id=?";
    $list=[$id];
    return writePrepare($mysqli, $sql,$list);
}

function modifPrivi($mysqli,$id,$privilege){
    $sql = "UPDATE user SET privilege=? WHERE user.id=?";
    $list=[$privilege,$id];
    return writePrepare($mysqli, $sql,$list);
}

function update_game_couv($mysqli,$nom,$prix,$date_sortie,$synopsis,$couverture,$id){
    $sql = "UPDATE jeu set nom=?,prix=?,date_sortie=?,synopsis=?,couverture=? where id = ?";
    $list=[$nom,$prix,$date_sortie,$synopsis,$couverture,$id];
    return writePrepare($mysqli, $sql,$list);
}

function update_game($mysqli,$nom,$prix,$date_sortie,$synopsis,$id){
    $sql = "UPDATE jeu set nom=?,prix=?,date_sortie=?,synopsis=? where id = ?";
    $list=[$nom,$prix,$date_sortie,$synopsis,$id];
    return writePrepare($mysqli, $sql,$list);
}

function update_article($mysqli,$titre,$contenu,$note,$id){
    $sql = "UPDATE article set titre=?,contenu=?,note=? where id = ?";
    $list=[$titre,$contenu,$note,$id];
    return writePrepare($mysqli, $sql,$list);
}

function update_user_pdp($mysqli,$id,$login,$nom,$prenom,$email,$pdp){
    $sql = "UPDATE user set nom=?,prenom=?,email=?,login=?,pdp=? where id = ?";
    $list=[$nom,$prenom,$email,$login,$pdp,$id];
    return writePrepare($mysqli, $sql,$list);
}

function update_user($mysqli,$id,$login,$nom,$prenom,$email){
    $sql = "UPDATE user set nom=?,prenom=?,email=?,login=? where id = ?";
    $list=[$nom,$prenom,$email,$login,$id];
    return writePrepare($mysqli, $sql,$list);
}

//Fonction permettant d'écrire un article 
function create_article($mysqli,$Titre,$corps,$note,$id_redac,$id_jeu){
    $sql = "INSERT into article (titre,contenu,note,id_redacteur,id_jeu) VALUES (?,?,?,?,?)";
    $list=[$Titre,$corps,$note,$id_redac,$id_jeu];
    return writePrepare($mysqli, $sql,$list);
}


function create_avis($mysqli,$commentaire,$note,$id,$id_jeu){
    $sql = "INSERT into avis (contenu,note,id_user,id_jeu) VALUES (?,?,?,?)";
    $list=[$commentaire,$note,$id,$id_jeu];
    return writePrepare($mysqli, $sql,$list);
}

function modif_avis($mysqli,$commentaire,$note,$id,$id_jeu){
    $sql = "UPDATE avis set contenu=?,note=? WHERE id_user=? AND id_jeu=?";
    $list=[$commentaire,$note,$id,$id_jeu];
    return writePrepare($mysqli, $sql,$list);
}

function avg_avis($mysqli,$id_jeu){
    $sql = "SELECT AVG(avis.note) AS avg_avis FROM avis WHERE avis.id_jeu = '$id_jeu';";
    return readDB($mysqli, $sql);
}

// Fonction qui renvoie tous les jeux qui n'ont pas d'article

function jeuxSansArticle($mysqli){
    $sql = "SELECT jeu.id,jeu.nom FROM article right JOIN jeu ON jeu.id=id_jeu WHERE id_jeu is NULL";
    return readDB($mysqli, $sql);
}

//Recuperation des noms des categories de jeu
function getCategories($mysqli){
    $sql = "SELECT id_categorie,nom FROM categorie";
    return readDB($mysqli,$sql);
}

//Recuperation des noms des categories de jeu
function getSupports($mysqli){
    $sql = "SELECT id_support,nom FROM support";
    return readDB($mysqli,$sql);
}

function getAvisByUser($mysqli,$id_user,$id_jeu){
    $sql = "SELECT * FROM avis WHERE id_user=? AND id_jeu=?";
    $list = [$id_user,$id_jeu];
    return readPrepare($mysqli, $sql, $list );
}

function delete_avis($mysqli,$id_jeu,$id){

    $sql = "DELETE FROM avis WHERE id_jeu=? AND id_user=?";
    $list = [$id_jeu,$id] ;

    return writePrepare($mysqli, $sql,$list);
}

function delete_support($mysqli,$id_jeu,$supports=""){
    if ($supports){
        $query = implode (",", array_fill(0,count($supports),"?") );
        $sql = "DELETE FROM est_supporte WHERE id_jeu=? AND id_support NOT IN ($query)";
        $list = array_merge ( [$id_jeu] , $supports ) ;
    }
    else{
        $sql = "DELETE FROM est_supporte WHERE id_jeu=?";
        $list = [$id_jeu];
    }


    return writePrepare($mysqli, $sql,$list);
}

function delete_categorie($mysqli,$id_jeu,$categories=""){
    if ($categories){
        $query = implode (",", array_fill(0,count($categories),"?") );
        $sql = "DELETE FROM est_categorise WHERE id_jeu=? AND id_categorie NOT IN ($query)";
        $list = array_merge ( [$id_jeu] , $categories ) ;
    }
    else{
        $sql = "DELETE FROM est_categorise WHERE id_jeu=?";
        $list = [$id_jeu] ;
    }
    

    return writePrepare($mysqli, $sql,$list);
}

function insert_categorie($mysqli,$id_jeu,$categories){

    $query = "SELECT " . implode (" UNION SELECT ", array_fill(0,count($categories),"?") );
    
    $sql = "INSERT INTO est_categorise (id_jeu,id_categorie)
            ( 
                SELECT ? as id_jeu, a.* FROM (
                    ( $query )
                    EXCEPT 
                    SELECT id_categorie FROM est_categorise WHERE id_jeu=?
                ) as a
            );
    ";
    $list = array_merge ( [$id_jeu] , $categories , [$id_jeu]) ;

    return writePrepare($mysqli, $sql,$list);
}

function insert_support($mysqli,$id_jeu,$supports){

    $query = "SELECT " . implode (" UNION SELECT ", array_fill(0,count($supports),"?") );
    
    $sql = "INSERT INTO est_supporte (id_jeu,id_support)
            ( 
                SELECT ? as id_jeu, a.* FROM (
                    ( $query )
                    EXCEPT 
                    SELECT id_support FROM est_supporte WHERE id_jeu=?
                ) as a
            );
    ";
    $list = array_merge ( [$id_jeu] , $supports , [$id_jeu]) ;

    return writePrepare($mysqli, $sql,$list);
}



?>
