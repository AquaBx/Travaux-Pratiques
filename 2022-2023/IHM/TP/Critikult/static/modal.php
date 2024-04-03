<?php 

if ( isset ( $_SESSION["form_result"] ) ){
    modal( $_SESSION["form_msg"],$_SESSION["form_result"] );
    unset( $_SESSION["form_msg"]);
    unset( $_SESSION["form_result"] );
}

?>