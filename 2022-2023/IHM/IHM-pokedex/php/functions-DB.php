<?php

#connexion à la base de données en MySQLi (base de données SQL)
function connectionDB()
{
	$mysqli = mysqli_connect(SERVEUR, USER, PWD, DB_NAME);

	if (mysqli_connect_errno()) {
		printf("Échec de la connexion : %s\n", mysqli_connect_error());
		exit();
	}

	mysqli_set_charset($mysqli,"utf8");

 	return $mysqli;
}

#ferme la connexion à la base de données
function closeDB($mysqli)
{
	return mysqli_close($mysqli);
}

#lecture de la base de données en fonction d'une requête SQL passée en paramètre d'entrée
#retourne un tableau associatif contenant les résultats de la requête
#à utiliser pour les requêtes de type SELECT
function readDB($mysqli, $sql_input)
{
	//exécution de la requête $sql_input et récupération du résultat de type mysqli_result

	//vérification de la requête : 
		//si la requête est incorrect ou le nombre de ligne retourné égal à 0,
		//on retourne un tableau vide

	//Sinon, on retourne un tableau associatif

	// $sql_input = mysqli_real_escape_string($mysqli,$sql_input);
	// echo $sql_input;
	
	$result = mysqli_query($mysqli, $sql_input);

	if ($result == false || mysqli_num_rows($result) == 0) {
		return array();
	}
	else{
		return mysqli_fetch_all($result, MYSQLI_ASSOC);
	}
}

#ecrit/modifie la base de données grâce à la requête SQL passée en paramètre d'entrée
#à utiliser pour les requêtes de type INSERT INTO, UPDATE, DELETE
function writeDB($mysqli, $sql_input)
{
	//exécution de la requête $sql_input

	//retourne le résultat de la requête

	// $sql_input = mysqli_real_escape_string($mysqli,$sql_input);
	$result = mysqli_query($mysqli, $sql_input);
	return $result;

}

?>