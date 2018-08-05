<?php
    session_start();
    include_once "./adoConnection.php"; // connect to database , use $conn

    $deleteId = $username = $userid = $result = "";
    $returnData = array();
    $returnData[ "message" ] = "";
    $returnData[ "code" ] = -1;
    //------------------------------
    $userid = $_SESSION[ "id" ];
    // get data from front-end
    if ( isset( $_POST[ "deleteId" ] ) && $_POST[ "deleteId" ] != "" ) {
        $deleteId = $_POST[ "deleteId" ];
    }

    // query mysql
    $sql = "update remind_item set is_delete=1 where id = ? and user_guid = ?";
    $sql = $conn->prepare( $sql );
    $result = $conn->execute( $sql , array( $deleteId , $userid ) );

    if ( $result == false ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "查詢錯誤!! 請重試";
    }
    else {
        $returnData[ "code" ] = 0;
        $returnData[ "message" ] = "";
    }

    echo json_encode( $returnData );
    exit();
 ?>
