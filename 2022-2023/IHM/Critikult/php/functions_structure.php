<?php

function display_articles($articles){
    if (count($articles)==0){
        echo "<p class='texte_centre'>Aucun article !</p>";
    }
    else{
        echo "<div class='articles'>";
        $i=0;
        foreach ($articles as $article){
        
            $id = $article["id"];
            echo "<div style='--i:$i;' class='article'>";
    
            $img = 'data:image;base64,' . base64_encode( $article["couverture"] ) ;
    
                echo "<img src='$img' alt='Couverture de l article '>";
    
                echo "<a  href='article.php?id=$id' class='slide'>";
                echo "<h2>" . $article["jeu"] . "</h2>";
                echo "<p class='accroche'>" . $article["titre"] . "</p>";
                echo "<p class='date'>" . $article["date_creation"] . "</p>";
                echo "</a>";
            echo "</div>";
            $i++ ;
        }
        echo "</div>";
    }
}

function liste_users($users){
    echo "<table class='users'>";
    echo "<tr>
    <td>login</td>
    <td>membre</td>
    <td>rédacteur</td>
    <td>administrateur</td>
    <td></td>
    </tr>";
    foreach ($users as $user){
        $checked1 = $user["privilege"] == "membre" ? "checked" : ""; 
        $checked2 = $user["privilege"] == "rédacteur" ? "checked" : ""; 
        $checked3 = $user["privilege"] == "administrateur" ? "checked" : ""; 

        echo "<tr class='user'><form method='POST' action='./php/post_admin.php'>";
        $log = $user["login"];
        $id = $user["id"];
        echo "<td><a href='./profil.php?id=$id'>$log</a><input type='hidden' name='id' value='$id'></td>";
        echo "<td><input type='radio' $checked1 name='fonction' value='membre'></td>";
        echo "<td><input type='radio' $checked2 name='fonction' value='rédacteur'></td>";
        echo "<td><input type='radio' $checked3 name='fonction' value='administrateur'></td>";
        echo "<td><input type='submit' name='privilege' value='modifier'></td>";
        echo "</form></tr>";
    } 
    echo "</div>";
}

function liste_illus($illus){
    echo "<div style='display:grid;grid-template-columns: repeat(2, 1fr);gap:1em;margin:2em 0;'>";
    foreach ($illus as $illu){
        $data = base64_encode($illu["data"]);
        echo "<img width='100%' src='data:image;base64,$data' alt='Image d illustration du jeu'>";
    }
    echo "</div>";
}

function displayJeuxSansArticle($jeux){
    foreach($jeux as $val){
        $jeu = $val["nom"];
        $id  = $val["id"];
        echo "<option value='$id'>$jeu</option>";
    }
}

function OptionsArticles($articles){
    foreach($articles as $article){
        $titre = $article["titre"];
        $id  = $article["id"];
        echo "<option value='$id'>$titre</option>";
    }
}

function OptionsJeux($games){
    foreach($games as $game){
        $nom = $game["nom"];
        $id  = $game["id"];
        echo "<option value='$id'>$nom</option>";
    }
}


function OptionsCategories($categories){
    foreach($categories as $categorie){
        $nom = $categorie["nom"];
        $id  = $categorie["id_categorie"];
        echo "<option value='$id'>$nom</option>";
    }
}


function modal($message,$type=""){

    echo "<div class='modal $type'>";
        echo $message;
    echo "</div>";
}

function display_article($article,$categories,$supports){
    $synopsis = $article["synopsis"];
    $titre = $article["titre"];
    $couv = $article["couverture"];
    $content = $article["contenu"];

    $nom_jeu =  $article["nom"];
    $prix = $article["prix"];

    


    echo "<h1 style='text-align:center'>$titre</h1>";
    echo "<div class='article_head' style='position:relative'>";
    $img = 'data:image;base64,' . base64_encode( $couv ) ;
    echo "<img style='object-fit:cover;height:100%;width:100%;position:relative;'  src='$img' alt='Jaquette du jeu'>" ;

    echo "<div>";
  
    echo "<p>Prix : $prix €</p>";

    echo "<p>Catégories : ";

    foreach($categories as $categorie){
        $nom = $categorie['nom'];
        echo "<span class='supcat'>$nom </span>";
    }

    echo "</p>";
    echo "<p>Supports : ";


    foreach($supports as $support){
        $nom = $support['nom'];
        echo "<span class='supcat'>$nom </span>";
    }

    echo "</p>";

    echo "</div>";

    echo "</div>";

    echo "<h1>Présentation de $nom_jeu</h1>";


    echo "<p>$synopsis</p>";

    
    echo "<br>";

    echo "<h1>Notre avis sur le jeu</h1>";

    echo "<p>$content</p>";
}

function star_note($note){

    $noteinv = 10-$note;
    echo "<svg width='100%' viewBox='0 0 10 0.95' fill='none' xmlns='http://www.w3.org/2000/svg'>
<g clip-path='url(#clip0_1011_13)'>
<mask id='mask0_1011_13' style='mask-type:alpha' maskUnits='userSpaceOnUse' x='0' y='0' width='10' height='1'>
<path d='M2.51634 0.0157336L2.64223 0.312976L2.96135 0.341777C2.97562 0.342884 2.98587 0.355439 2.98477 0.369839C2.98404 0.376855 2.98111 0.382763 2.97599 0.387194L2.73445 0.599879L2.80582 0.915214C2.80911 0.929245 2.80033 0.942907 2.78642 0.94623C2.77947 0.947707 2.77215 0.94623 2.76666 0.942538L2.49219 0.777116L2.21699 0.943276C2.20491 0.950661 2.18918 0.946599 2.18186 0.934414C2.1782 0.928506 2.17746 0.921491 2.17893 0.915214L2.25029 0.599879L2.00876 0.387194C1.99814 0.377963 1.99705 0.361347 2.0062 0.350639C2.01132 0.3451 2.01791 0.342515 2.02449 0.342146L2.34288 0.313345L2.46877 0.0157336C2.47426 0.00244082 2.48926 -0.00346709 2.50244 0.00207158C2.50902 0.00465629 2.51378 0.00982571 2.51634 0.0157336Z' fill='#CCCCCC'/>
<path d='M4.51634 0.0157336L4.64223 0.312976L4.96134 0.341777C4.97562 0.342884 4.98586 0.355439 4.98476 0.369839C4.98403 0.376855 4.98111 0.382763 4.97598 0.387194L4.73445 0.599879L4.80581 0.915214C4.8091 0.929245 4.80032 0.942907 4.78641 0.94623C4.77946 0.947707 4.77214 0.94623 4.76665 0.942538L4.49218 0.777116L4.21698 0.943276C4.20491 0.950661 4.18917 0.946599 4.18185 0.934414C4.17819 0.928506 4.17746 0.921491 4.17892 0.915214L4.25028 0.599879L4.00875 0.387194C3.99814 0.377963 3.99704 0.361347 4.00619 0.350639C4.01131 0.3451 4.0179 0.342515 4.02449 0.342146L4.34287 0.313345L4.46876 0.0157336C4.47425 0.00244082 4.48926 -0.00346709 4.50243 0.00207158C4.50902 0.00465629 4.51378 0.00982571 4.51634 0.0157336Z' fill='#CCCCCC'/>
<path d='M0.51634 0.0157336L0.64223 0.312976L0.961347 0.341777C0.975619 0.342884 0.985866 0.355439 0.984768 0.369839C0.984036 0.376855 0.981108 0.382763 0.975985 0.387194L0.734452 0.599879L0.805814 0.915214C0.809108 0.929245 0.800325 0.942907 0.786418 0.94623C0.779465 0.947707 0.772146 0.94623 0.766656 0.942538L0.492187 0.777116L0.216986 0.943276C0.204909 0.950661 0.189173 0.946599 0.181854 0.934414C0.178194 0.928506 0.177462 0.921491 0.178926 0.915214L0.250288 0.599879L0.00875499 0.387194C-0.00185782 0.377963 -0.0029557 0.361347 0.00619328 0.350639C0.0113167 0.3451 0.017904 0.342515 0.0244912 0.342146L0.342876 0.313345L0.468766 0.0157336C0.474255 0.00244082 0.489259 -0.00346709 0.502434 0.00207158C0.509021 0.00465629 0.513779 0.00982571 0.51634 0.0157336Z' fill='#CCCCCC'/>
<path d='M5.51634 0.0157336L5.64223 0.312976L5.96135 0.341777C5.97562 0.342884 5.98587 0.355439 5.98477 0.369839C5.98404 0.376855 5.98111 0.382763 5.97598 0.387194L5.73445 0.599879L5.80581 0.915214C5.80911 0.929245 5.80033 0.942907 5.78642 0.94623C5.77947 0.947707 5.77215 0.94623 5.76666 0.942538L5.49219 0.777116L5.21699 0.943276C5.20491 0.950661 5.18917 0.946599 5.18185 0.934414C5.17819 0.928506 5.17746 0.921491 5.17893 0.915214L5.25029 0.599879L5.00875 0.387194C4.99814 0.377963 4.99704 0.361347 5.00619 0.350639C5.01132 0.3451 5.0179 0.342515 5.02449 0.342146L5.34288 0.313345L5.46877 0.0157336C5.47426 0.00244082 5.48926 -0.00346709 5.50243 0.00207158C5.50902 0.00465629 5.51378 0.00982571 5.51634 0.0157336Z' fill='#CCCCCC'/>
<path d='M6.51634 0.0157336L6.64223 0.312976L6.96135 0.341777C6.97562 0.342884 6.98587 0.355439 6.98477 0.369839C6.98404 0.376855 6.98111 0.382763 6.97598 0.387194L6.73445 0.599879L6.80581 0.915214C6.80911 0.929245 6.80033 0.942907 6.78642 0.94623C6.77947 0.947707 6.77215 0.94623 6.76666 0.942538L6.49219 0.777116L6.21699 0.943276C6.20491 0.950661 6.18917 0.946599 6.18185 0.934414C6.17819 0.928506 6.17746 0.921491 6.17893 0.915214L6.25029 0.599879L6.00875 0.387194C5.99814 0.377963 5.99704 0.361347 6.00619 0.350639C6.01132 0.3451 6.0179 0.342515 6.02449 0.342146L6.34288 0.313345L6.46877 0.0157336C6.47426 0.00244082 6.48926 -0.00346709 6.50243 0.00207158C6.50902 0.00465629 6.51378 0.00982571 6.51634 0.0157336Z' fill='#CCCCCC'/>
<path d='M7.51634 0.0157336L7.64223 0.312976L7.96135 0.341777C7.97562 0.342884 7.98587 0.355439 7.98477 0.369839C7.98404 0.376855 7.98111 0.382763 7.97598 0.387194L7.73445 0.599879L7.80581 0.915214C7.80911 0.929245 7.80033 0.942907 7.78642 0.94623C7.77947 0.947707 7.77215 0.94623 7.76666 0.942538L7.49219 0.777116L7.21699 0.943276C7.20491 0.950661 7.18917 0.946599 7.18185 0.934414C7.17819 0.928506 7.17746 0.921491 7.17893 0.915214L7.25029 0.599879L7.00875 0.387194C6.99814 0.377963 6.99704 0.361347 7.00619 0.350639C7.01132 0.3451 7.0179 0.342515 7.02449 0.342146L7.34288 0.313345L7.46877 0.0157336C7.47426 0.00244082 7.48926 -0.00346709 7.50243 0.00207158C7.50902 0.00465629 7.51378 0.00982571 7.51634 0.0157336Z' fill='#CCCCCC'/>
<path d='M8.51634 0.0157336L8.64223 0.312976L8.96135 0.341777C8.97562 0.342884 8.98587 0.355439 8.98477 0.369839C8.98404 0.376855 8.98111 0.382763 8.97598 0.387194L8.73445 0.599879L8.80581 0.915214C8.80911 0.929245 8.80033 0.942907 8.78642 0.94623C8.77947 0.947707 8.77215 0.94623 8.76666 0.942538L8.49219 0.777116L8.21699 0.943276C8.20491 0.950661 8.18917 0.946599 8.18185 0.934414C8.17819 0.928506 8.17746 0.921491 8.17893 0.915214L8.25029 0.599879L8.00875 0.387194C7.99814 0.377963 7.99704 0.361347 8.00619 0.350639C8.01132 0.3451 8.0179 0.342515 8.02449 0.342146L8.34288 0.313345L8.46877 0.0157336C8.47426 0.00244082 8.48926 -0.00346709 8.50243 0.00207158C8.50902 0.00465629 8.51378 0.00982571 8.51634 0.0157336Z' fill='#CCCCCC'/>
<path d='M9.51634 0.0157336L9.64223 0.312976L9.96135 0.341777C9.97562 0.342884 9.98587 0.355439 9.98477 0.369839C9.98404 0.376855 9.98111 0.382763 9.97598 0.387194L9.73445 0.599879L9.80581 0.915214C9.80911 0.929245 9.80033 0.942907 9.78642 0.94623C9.77947 0.947707 9.77215 0.94623 9.76666 0.942538L9.49219 0.777116L9.21699 0.943276C9.20491 0.950661 9.18917 0.946599 9.18185 0.934414C9.17819 0.928506 9.17746 0.921491 9.17893 0.915214L9.25029 0.599879L9.00875 0.387194C8.99814 0.377963 8.99704 0.361347 9.00619 0.350639C9.01132 0.3451 9.0179 0.342515 9.02449 0.342146L9.34288 0.313345L9.46877 0.0157336C9.47426 0.00244082 9.48926 -0.00346709 9.50243 0.00207158C9.50902 0.00465629 9.51378 0.00982571 9.51634 0.0157336Z' fill='#CCCCCC'/>
<path d='M3.5362 0.0157336L3.66693 0.312976L3.99832 0.341777C4.01314 0.342884 4.02378 0.355439 4.02264 0.369839C4.02188 0.376855 4.01884 0.382763 4.01352 0.387194L3.7627 0.599879L3.8368 0.915214C3.84022 0.929245 3.8311 0.942907 3.81666 0.94623C3.80944 0.947707 3.80184 0.94623 3.79614 0.942538L3.51111 0.777116L3.22533 0.943276C3.21279 0.950661 3.19645 0.946599 3.18885 0.934414C3.18505 0.928506 3.18429 0.921491 3.18581 0.915214L3.25991 0.599879L3.00909 0.387194C2.99807 0.377963 2.99693 0.361347 3.00643 0.350639C3.01175 0.3451 3.01859 0.342515 3.02543 0.342146L3.35606 0.313345L3.48679 0.0157336C3.49249 0.00244082 3.50807 -0.00346709 3.52176 0.00207158C3.5286 0.00465629 3.53354 0.00982571 3.5362 0.0157336Z' fill='#CCCCCC'/>
<path d='M1.5362 0.0157336L1.66693 0.312976L1.99832 0.341777C2.01315 0.342884 2.02379 0.355439 2.02265 0.369839C2.02189 0.376855 2.01885 0.382763 2.01353 0.387194L1.7627 0.599879L1.83681 0.915214C1.84023 0.929245 1.83111 0.942907 1.81667 0.94623C1.80945 0.947707 1.80185 0.94623 1.79615 0.942538L1.51112 0.777116L1.22533 0.943276C1.21279 0.950661 1.19645 0.946599 1.18885 0.934414C1.18505 0.928506 1.18429 0.921491 1.18581 0.915214L1.25992 0.599879L1.00909 0.387194C0.998071 0.377963 0.996931 0.361347 1.00643 0.350639C1.01175 0.3451 1.0186 0.342515 1.02544 0.342146L1.35607 0.313345L1.4868 0.0157336C1.4925 0.00244082 1.50808 -0.00346709 1.52176 0.00207158C1.5286 0.00465629 1.53354 0.00982571 1.5362 0.0157336Z' fill='#CCCCCC'/>
</mask>
<g mask='url(#mask0_1011_13)'>

<rect width='$noteinv' height='0.95' transform='matrix(-1 0 0 1 10 0)' fill='#DADADA'/>
<rect width='$note' height='0.95' fill='#FFCC00'/>
</g>
</g>

</svg>";
}


function profil_opinion($avi,$role,$user){

    $name = $avi['titre_art'];
    $note = $avi['note'];
    $datecrea = $avi['date'];
    $contenu = $avi['contenu'];
    $id = $avi['id_art'];
    $id_user = $avi['id_user'];
    $id_jeu = $avi['id_jeu'];

    echo "<div class='opinion'>";

    if ($role == 'administrateur' || $user==$id_user ){
        echo "<a class='trash' href='./php/delete_avis.php?id=$id_user&id_jeu=$id_jeu'><i class='fa-regular fa-trash-can'></i></a>";
    }

    echo "<div class='grid'>";

    echo "<h2><a href='./article.php?id=$id'>$name</a></h2>";
    star_note($note);
            
    echo "<p>$contenu</p>";

    echo "<a>";

    $date1 = date("d/m/Y", strtotime($datecrea));

    echo "Créé le $date1";

    echo '</a>';
            
    echo "</div>";

    echo "</div>";
}


function opinion($avi,$role,$user){

    $name = $avi['prenom'] . " " . $avi['nom'];
    $pdp = $avi['pdp'];
    $note = $avi['note'];
    $datecrea = $avi['date'];
    $contenu = $avi['contenu'];
    $id = $avi['id'];
    $id_jeu = $avi['id_jeu'];

    


    echo "<div class='opinion opinion_pdp'>";

    if ($role == 'administrateur' || $user==$id ){
        echo "<a class='trash' href='./php/delete_avis.php?id=$id&id_jeu=$id_jeu'><i class='fa-regular fa-trash-can'></i></a>";
    }

    echo "<div class='grid'>";

    if ($pdp){
        $img = 'data:image;base64,' . base64_encode( $pdp ) ;
    }
    else{
        $img = './images/blank_pdp.webp';
    }

    echo "<img style='width:6em; border-radius:360em;' src='$img' alt='photo de profil de l utilisateur'>";
    echo "<h2><a href='./profil.php?id=$id'>$name</a></h2>";
    star_note($note);
            
    echo "<p>$contenu</p>";

    echo "<a>";

    $date1 = date("d/m/Y", strtotime($datecrea));

    echo "Créé le $date1";

    echo '</a>';
            
    echo "</div>";

    echo "</div>";
}

function redac_opinion($avi,$redac){

    $name = $redac['prenom'] . " " . $redac['nom'];
    $pdp = $redac['pdp'];
    $note = $avi['note'];
    $datecrea = $avi['date_creation'];
    $datemodif = $avi['date_modification'];
    $id = $redac['id'];
        
    echo "<div class='opinion opinion_pdp'>";
    echo "<div class='grid'>";

    if ($pdp){
        $img = 'data:image;base64,' . base64_encode( $pdp ) ;
    }
    else{
        $img = './images/blank_pdp.webp';
    }

    echo "<img style='width:6em; border-radius:360em;' src='$img' alt='photo de profil utilisateur'>";
    echo "<h2><a href='./profil.php?id=$id'>$name</a></h2>";
    star_note($note);
            

    echo "<a>";

    $date1 = date("d/m/Y", strtotime($datecrea));
    $date2 = date("d/m/Y", strtotime($datemodif));

    echo "Créé le $date1";

    if ($datecrea !== $datemodif && $datemodif !=="" ) { echo " et modifié le $date2"; };

    echo '</a>';
            
    echo "</div>";

    echo "</div>";
}

function profil($pdp,$name,$login,$status,$datecrea,$datemodif,$birthday,$email){
    echo "<div class='profil'>";


    if ($pdp){
        $img = 'data:image;base64,' . base64_encode( $pdp ) ;
    }
    else{
        $img = './images/blank_pdp.webp';
    }
    
    echo "<img style='width:6em; border-radius:360em;' src='$img' alt='photo de profil utilisateur'>";
    echo "<h2>$name ";

    if ($status === "administrateur"){
        echo '<i title="administrateur" class="fa-solid fa-gavel"></i>';
    }
    elseif ($status === "rédacteur"){
        echo '<i title="rédacteur" class="fa-solid fa-feather"></i>';
    }

    echo "</h2>";
    echo "<span class='logintag'>$login</span>";

    

 
    $date1 = date("d/m/Y H:i:s", strtotime($datecrea));
    $date2 = date("d/m/Y H:i:s", strtotime($datemodif));
    $date3 = date("d/m/Y", strtotime($birthday));

    echo "<a>";
    echo "Créé le $date1";
    echo '</a>';

    echo "<a>";
    echo "Dernière connexion le $date2";
    echo '</a>';

    echo "<a href='mailto:$email'>Contact</a>";

            
    echo "<a>";
    echo "Né(e) le $date3";
    echo '</a>';

    echo "</div>";
    echo "<br>";
}

function display_avis($avis,$role,$user){
    echo "<div class='avislist'>";
    if (count($avis)==0){
        echo "<p class='texte_centre'>Aucun avis n'a été rédigé pour le moment !</p>";
    }
    else{
        foreach ($avis as $avi){
            opinion($avi,$role,$user);
        }
    }
    echo "</div>";

}

function display_profil_avis($avis,$role,$user){
    echo "<div class='avislist'>";
    if (count($avis)==0){
        echo "<p class='texte_centre'>Aucun avis n'a été rédigé pour le moment !</p>";
    }
    else{
        foreach ($avis as $avi){
            profil_opinion($avi,$role,$user);
        }
    }
    echo "</div>";

}

function cleanify_jeu_cat($list){
    $arr = [];
    foreach ($list as $ent){
        $arr[] = $ent["nom"];
    }
    return $arr;
}

function checkboxs_supports($supsjeu,$supsall){
    $sups = cleanify_jeu_cat($supsjeu);
    foreach ($supsall as $sup){
        $name = $sup["nom"];
        $id = $sup["id_support"];

        $checked = in_array($name, $sups) ? "checked ": "";

        echo "<label for='$name-$id'>$name</label>";
        echo "<input id='$name-$id' $checked name='support[]' value='$id' type='checkbox'>";
    }
}

function checkboxs_categories($catsjeu,$catsall){
    $cats = cleanify_jeu_cat($catsjeu);
    foreach ($catsall as $cat){
        $name = $cat["nom"];
        $id = $cat["id_categorie"];

        $checked = in_array($name, $cats) ? "checked ": "";

        echo "<label for='$name-$id'>$name</label>";
        echo "<input id='$name-$id' $checked name='categorie[]' value='$id' type='checkbox'>";
    }
}

?>
