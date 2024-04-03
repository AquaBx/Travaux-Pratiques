<?php 

var_dump($_SERVER['SERVER_ADDR']);
session_start();
$_SESSION["user"] = "toto";

var_dump($_SESSION);