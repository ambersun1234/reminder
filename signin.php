<?php
    session_start(); // start session
    include_once "./adoConnection.php";

    $email = $password = $result = "";
    $returnData = array();
    $returnData[ "message" ] = "";
    $returnData[ "code" ] = -1;
    //-----------------------------------------------------------------

    // get data from front-end
    if ( isset( $_POST[ "email" ] ) && $_POST[ "email" ] != "" ) {
        $email = $_POST[ "email" ];
    }
    if ( isset( $_POST[ "password" ] ) && $_POST[ "password" ] != "" ) {
        $password = $_POST[ "password" ];
    }

    if ( $_POST[ "email" ] == "" || $_POST[ "password" ] == "" ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "帳號或密碼不可為空!!";
    }

    if ( $returnData[ "message" ] != "" ) {
        echo json_encode( $returnData );
        exit();
    }

    $sql = "select name , id , email , password from remind_user where email = ?";
    $sql = $conn->prepare( $sql );
    $result = $conn->execute( $sql , array( $email ) );

    // check query status
    if ( !$result ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "查詢錯誤!! 請重試";
    }

    // check whether password is correct or not
    if ( !password_verify( $password , $result->fields[ "password" ] ) ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "帳號或密碼錯誤!!";
    }

    if ( $returnData[ "message" ] != "" ) {
        echo json_encode( $returnData );
        exit();
    }

    // register session
    $_SESSION[ "id" ] = $result->fields[ "id" ];
    $_SESSION[ "email" ] = $result->fields[ "email" ];
    $_SESSION[ "username" ] = $result->fields[ "name" ];

    // return true
    $returnData[ "code" ] = 0;
    $returnData[ "message" ] = "";

    echo json_encode( $returnData );

    $conn->close();
 ?>
