<?php
    session_start();
    include_once "./adoConnection.php";

    $returnData = array();
    $returnData[ "message" ] = "";
    $returnData[ "code" ] = -1;
    //------------------------------------------------------------------------------
    if ( isset( $_POST[ "email" ] ) ) $email = $_POST[ "email" ]; // retrieve data

    $sql = "select email from remind_user where email = ?";
    $sql = $conn->prepare( $sql );
    $result = $conn->execute( $sql , $email );

    if ( $result->EOF ) {
        $returnData[ "code" ] = 0;
        $returnData[ "message" ] = "";
    }
    else {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "電子郵件已被使用!!";
    }

    echo json_encode( $returnData );

    $conn->close();
 ?>
