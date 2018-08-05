<?php
    session_start();
    include_once "./TemplatePower/class.TemplatePower.inc.php";
    include_once "./adoConnection.php";

    $notifyOutput = $sql = $username = $email = "";
    $count = $dbId = 0;
    //-----------------------------------------------------------------------------------
    if ( isset( $_SESSION[ "username" ] ) ) {
        $username = $_SESSION[ "username" ];
    }
    if ( isset( $_SESSION[ "email" ] ) ) {
        $email = $_SESSION[ "email" ];
    }

    $tpl = new TemplatePower( "./myTplFile/viewFinishedRemind.tpl" ); // your own tpl file

    $tpl->prepare();
    $tpl->assign( "session_name" , htmlspecialchars( $username ) ); // show who's login on the screen

    $sql = "select i.id , item_status as status , i.item_subject as subject , i.item_remark as remark ";
    $sql .= ", i.notify as notify , i.notify_datetime as notify_time from remind_item as i , remind_user as u ";
    $sql .= "where i.user_guid = u.id and u.email = ? and i.item_status = 1 and i.is_delete = 0";
    // select with session email and not-finished item and not-delete item
    // subject , remark , notify , notify_time , id , status

    $sql = $conn->prepare( $sql );
    $result = $conn->execute( $sql , array( $email ) );

    // set associative array using field name

    $count = 1; // set item counter
    while ( !$result->EOF ) {
        $tpl->newBlock( "reminds" );

        $tpl->assign( "showCountId" , htmlspecialchars( $count ) );
        $tpl->assign( "showId" , htmlspecialchars( $result->fields[ "id" ] ) );
        $tpl->assign( "showSubject" , htmlspecialchars( $result->fields[ "subject" ] ) );
        $tpl->assign( "showRemark" , $result->fields[ "remark" ] == "" ? htmlspecialchars( "無" ) : htmlspecialchars( $result->fields[ "remark" ] ) );
        $tpl->assign( "showStatus" , htmlspecialchars( "已完成" ) );
        $tpl->assign( "showNotify" , $result->fields[ "notify" ] == 0 ? htmlspecialchars( "不寄送" ) : htmlspecialchars( "寄送" ) );
        $tpl->assign( "showNotifyTime" , $result->fields[ "notify" ] == 0 ? htmlspecialchars( "無" ) : htmlspecialchars( $result->fields[ "notify_time" ] ) );

        $result->moveNext();
        $count += 1;
    }

    $tpl->printToScreen();
    $conn->close();
 ?>
