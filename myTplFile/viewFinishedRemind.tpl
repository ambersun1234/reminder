<!DOCTYPE html>

<html>
    <head>
        <title>已完成提醒事項</title>

        <!-- jquery file -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <!-- bootstrap include -->
        <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
        <script type="text/javascript" src="./js/bootstrap.min.js"></script>

        <!-- custom css file -->
        <link rel="stylesheet" type="text/css" href="./custom.css">
    </head>

    <body style="background-color: #a9d9f9;">
        <a href="./index.php"><h1 style="text-align: center;">備忘錄系統</h1></a>
        <span style="font-size: 22px; white-space: pre;">
            登入中使用者: {session_name}   <button class="btn" type="button" id="signOut">登出</button>
            <a href="./viewNFinishedRemind.php">未完成提醒事項</a>
        </span>
        <a href="./viewFinishedRemind.php"><h2 id="prompt">已完成提醒事項</h2></a>

        <div id="status" style="text-align: center;"></div><br>

        <table id="tableStyle" align="center">
            <tr>
                <th>提醒事項編號</th>
                <th>提醒事項主題</th>
                <th>提醒事項備註</th>
                <th>狀態</th>
                <th>寄送通知</th>
                <th>寄送時間</th>
                <th>刪除</th>
            </tr>
            <!-- START BLOCK : reminds -->
            <tr id="row_{showId}">
                <td>{showCountId}</td><!-- fake id -->

                <td><span class="m_subject_{showId}">{showSubject}</span></td>
                <td><span class="m_remark_{showId}">{showRemark}</span></td>
                <td><span class="m_status_{showId}">{showStatus}</span></td>
                <td><span class="m_notify_{showId}">{showNotify}</span></td>
                <td><span class="m_notifyTime_{showId}">{showNotifyTime}</span></td>
                <td><button class="delete_remind btn btn-danger" value="{showId}" type="button" style="background-color: #ff1933; color: #ffffff;">刪除</button></td>
            </tr>

            <!-- END BLOCK : reminds -->
        </table>
    </body>
</html>

<script type="text/javascript">
    $( "#signOut" ).on( "click" , function() {
        $.post( "./signout.php" , function( data ) {
            // returnData : 0 -- success
            if ( data.code == 0 ) {
                window.location.replace( "./index.php" );
            }
        } , "json" ).fail( function() {
            $( "#status" ).text( "出現錯誤!! 請重試" ).addClass( "incorrect" );
        });
    });

    $( ".delete_remind" ).on( "click" , function() {
        var id = $( this ).val();
        var fake_id = $( this ).parent( "td" ).siblings( "td:first-child" ).text();

        var choice = confirm( "你確定要刪除 \"" + fake_id + "號提醒事項\" ??" );

        if ( choice ) {
            $.post( "./deleteRemind.php" , { deleteId : id } , function( data ) {
                // returnData : 0 -- success , 1 -- query error
                if ( data.code == 0 ) {
                    // decrease fake id
                    $( "#row_" + id ).nextAll().find( "td:first-child" ).each( function() {
                        var temp = parseInt( $( this ).text() );
                        temp--;
                        $( this ).text( temp );
                    });

                    $( "#row_" + id ).remove();
                }
                else {
                    $( "#status" ).text( data.message ).addClass( "incorrect" );
                }
            } , "json" ).fail( function() {
                $( "#status" ).text( "出現錯誤!! 請重試" ).addClass( "incorrect" );
            });
        }
    });
</script>
