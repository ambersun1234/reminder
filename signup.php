<?php
    session_start();
    include_once "./adodb5/adodb.inc.php"; // include adodb essential
    include_once "./adoConnection.php";

    $username = $email = $password = $result = "";
    $returnData = array();
    $returnData[ "message" ] = "";
    $returnData[ "code" ] = -1;
    //-------------------------------------------------------

    // get data from front-end
    if ( isset( $_POST[ "username" ] ) && $_POST[ "username" ] != "" ) {
        $username = $_POST[ "username" ];
    }
    if ( isset( $_POST[ "email" ] ) && $_POST[ "email" ] != "" ) {
        $email = $_POST[ "email" ];
    }
    if ( isset( $_POST[ "password" ] ) && $_POST[ "password" ] != "" ) {
        $password = $_POST[ "password" ];
    }

    // back-end check
    if ( $username == "" || !preg_match( "/[a-z]/i" , $username ) ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "使用者名稱須包含至少一個英文字母";
    }
    if ( $email == "" || !preg_match( "/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,})$/i" , $email ) ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "電子郵件格式錯誤!!";
    }
    if ( $password == "" || !preg_match( "/[a-z0-9]/i" , $password ) ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "密碼格式錯誤!!";
    }
    else {
        $password = password_hash( $password , PASSWORD_DEFAULT );
    }

    if ( $returnData[ "message" ] != "" ) {
        echo json_encode( $returnData );
        exit();
    }

    $sql = "insert into remind_user( name , password , email ) values( ? , ? , ? )";
    $sql = $conn->prepare( $sql );
    $result = $conn->execute( $sql , array( $username , $password , $email ) );

    if ( $result == true ) {
        $returnData[ "code" ] = 0;
        $returnData[ "message" ] = "";

        // get userid
        $sql = "select id from remind_user where email = ?";
        $sql = $conn->prepare( $sql );
        $result = $conn->execute( $sql , array( $email ) );
        if ( $result == false ) {
            $returnData[ "code" ] = 1;
            $returnData[ "message" ] = "查詢錯誤!! 請重試";
        }
        // register session
        $_SESSION[ "username" ] = $username;
        $_SESSION[ "id" ] = $result->fields[ "id" ];
        $_SESSION[ "email" ] = $email;
    }
    else {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "查詢錯誤!! 請重試";
    }

    echo json_encode( $returnData );

    $conn->close(); // close database connection ( optional choice
 ?>
