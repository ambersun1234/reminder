<?php
    session_start();

    $returnData = array();
    $returnData[ "message" ] = "";
    $returnData[ "code" ] = -1;
    //------------------------------------------------
    
    unset( $_SESSION[ "username" ] );
    unset( $_SESSION[ "id" ] );
    unset( $_SESSION[ "email" ] );

    $returnData[ "code" ] = 0;
    $returnData[ "message" ] = "";
    echo json_encode( $returnData );
    exit();
 ?>
