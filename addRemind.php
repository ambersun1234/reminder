<?php
    session_start();
    include_once "adoConnection.php";

    $subject = $remark = $notify = $notify_time = $userid = $curTime = $result = "";
    $returnData = array(); // true , false , serverDown , error
    $returnData[ "message" ] = "";
    $returnData[ "code" ] = -1;
    $returnData[ "id" ] = 0;
    //-----------------------------------------------------------------------------
    $userid = $_SESSION[ "id" ];
    // get data from front-end
    if ( isset( $_POST[ "subject" ] ) ) {
        $subject = $_POST[ "subject" ];
    }
    if ( isset( $_POST[ "remark" ] ) ) {
        $remark = $_POST[ "remark" ];
    }
    if ( isset( $_POST[ "notify" ] ) ) {
        $notify = $_POST[ "notify" ];
    }
    if ( isset( $_POST[ "notify_time" ] ) ) {
        $notify_time = $_POST[ "notify_time" ];
    }

    // check data
    if ( $subject == "" ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "主題不可為空!!";
    }
    // remark no need to check since it can be blank
    if ( !( $notify != "yes" ^ $notify != "no" ) ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "通知錯誤!! 請重試";
    }
    if ( $notify == "yes" && !preg_match( "/(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2})/" , $notify_time ) ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "寄信時間格式錯誤!! 請重試";
    }

    if ( $returnData[ "message" ] != "" ) {
        echo json_encode( $returnData );
        exit();
    }

    $curTime = date( "Y-m-d H:i:s" );

    // write into database
    $sql = "insert into remind_item( user_guid , item_subject , item_remark , notify , notify_datetime , create_time )
            values( ? , ? , ? , ? , ? , ? )";
    $sql = $conn->prepare( $sql );
    $result = $conn->execute( $sql , array( $userid ,
                                            $subject ,
                                            $remark ,
                                            $notify == "yes" ? 1 : 0 ,
                                            $notify == "yes" ?
                                            $notify_time : NULL ,
                                            $curTime ) );

    $sql = "select LAST_INSERT_ID() as id";
    $result = $conn->execute( $sql );
    $returnData[ "id" ] = $result->fields[ "id" ];

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

    $conn->close();
 ?>
