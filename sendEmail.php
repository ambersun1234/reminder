<?php
    date_default_timezone_set( "Asia/Taipei" );

    include_once "C:/xampp/htdocs/www/adoConnection.php";

    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\Exception;
    // load Composer's autoloader
    require 'C:/xampp/htdocs/www/vendor/autoload.php';

    $mail = new PHPMailer( true );
    try {
        // setup phpmailer
        $mail->isSMTP();
        $mail->Host = "smtp.gmail.com";
        $mail->SMTPAuth = true;
        $mail->Username = "YOUR_EMAIL";
        $mail->Password = "YOUR_EMAIL'S_PASSWORD";
        $mail->SMTPSecure = "ssl";
        $mail->Port = 465;
        $mail->charSet = "UTF-8";

        $sql = "select item.id as id , item.item_subject as subject , item.item_remark as remark ,
                user.email as email , user.name as username
                from remind_item as item , remind_user as user
                where '" . date( "Y-m-d H:i:s" ) . "' = notify_datetime
                and item.user_guid = user.id and item.is_delete = 0 and item.notify = 1";
        // reminder id , subject , remark , email , user name
        $result = $conn->execute( $sql );

        if ( $result->EOF ) {
            echo date( "Y-m-d H:i" ) . "--no email send\n";
        }
        while ( !$result->EOF ) {
            // set sender
            $mail->setFrom( "YOUR_EMAIL" , "reminder" );
            // set receiver
            $mail->addAddress( $result->fields[ "email" ] , $result->fields[ "username" ] );

            $mail->Subject = mb_encode_mimeheader( $result->fields[ "subject" ] , "UTF-8" );

            $remark = ( $result->fields[ "remark" ] == "" ? "無" : $result->fields[ "remark" ] );
            $username = $result->fields[ "username" ];
            $subject = $result->fields[ "subject" ];

            $body = "收件者: " . $username . "\n" . "主題: " . $subject . "\n" . "備註: " . $remark . "\n";

            $mail->Body = $body;

            $mail->send();

            $id = $result->fields[ "id" ];
            echo date( "Y-m-d H:i" ) . "--mail send ( reminder item id = $id )\n";
            $result->moveNext();
        }
    }
    catch ( Exception $e ) {
        echo "mail could not be send( reminder id = $id ) " . $mail->ErrorInfo;
    }
    $conn->close();
 ?>
