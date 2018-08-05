<?php
    include_once "./adodb5/adodb.inc.php"; // include adodb essential

    // set database connection essential variable
    $server = "localhost";
    $user = "root";
    $password = "";
    $db = "reminders";

    $conn = newADOConnection( "mysqli" );
    $conn->connect( $server , $user , $password , $db );
    $conn->setCharset( "utf8" );

    // set use field name
    $ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;
 ?>
