<?php
    session_start();
    include_once "./adoConnection.php";

    $subject = $remark = $status = $notify = $notify_time = "";
    $user_guid = $id = 0;
    $returnData = array();
    $returnData[ "message" ] = "";
    $returnData[ "code" ] = -1;
    //--------------------------------------------------------------------
    $user_guid = $_SESSION[ "id" ];
    // get data from front-end
    if ( isset( $_POST[ "id" ] ) ) {
        $id = $_POST[ "id" ];
    }
    if ( isset( $_POST[ "subject" ] ) ) {
        $subject = $_POST[ "subject" ];
    }
    if ( isset( $_POST[ "remark" ] ) ) {
        $remark = $_POST[ "remark" ];
    }
    if ( isset( $_POST[ "status" ] ) ) {
        $status = $_POST[ "status" ];
    }
    if ( isset( $_POST[ "notify" ] ) ) {
        $notify = $_POST[ "notify" ];
    }
    if ( isset( $_POST[ "notify_time" ] ) ) {
        $notify_time = $_POST[ "notify_time" ];
    }

    // check data
    if ( $id == -1 ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "id錯誤!! 請重試";
    }
    if ( $subject == "" ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "主題不可為空!!";
    }
    if ( !( $status != "yes" ^ $status != "no" ) ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "狀態錯誤!! 請重試";
    }
    if ( !( $notify != "yes" ^ $notify != "no" ) ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "通知錯誤!! 請重試";
    }
    if ( $notify == "yes" && !preg_match( "/(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2})/" , $notify_time ) ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "寄信時間格式錯誤!! 請重試";
    }

    // check if it's time to return;
    if ( $returnData[ "message" ] != "" ) {
        echo json_encode( $returnData );
        exit();
    }

    // write into database
    $sql = "update remind_item set
            item_subject = ? ,
            item_remark = ? ,
            item_status = ? ,
            notify = ? , notify_datetime = ? where id = ? and user_guid = ?";
    $sql = $conn->prepare( $sql );
    $result = $conn->execute( $sql , array( $subject ,
                                            $remark ,
                                            ( $status == "no" ? 0 : 1 ) ,
                                            ( $notify == "no" ? 0 : 1 ) ,
                                            ( $notify == "no" ? NULL : $notify_time ) ,
                                            $id , $user_guid ) );

    if ( $result == false ) {
        $returnData[ "code" ] = 1;
        $returnData[ "message" ] = "查詢錯誤!! 請重試";
        echo json_encode( $returnData );
        exit();
    }
    else {
        $returnData[ "code" ] = 0;
        $returnData[ "message" ] = "";
        echo json_encode( $returnData );
        exit();
    }
 ?>
