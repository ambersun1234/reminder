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

            <!-- delete remind Modal -->
            <div class="modal fade" id="delete_remind_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">刪除提醒事項</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">
                            <div id="delete_fake_id"></div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-danger" id="delete_submit">確定</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end delete remind Modal -->
        </table>
    </body>
</html>

<script type="text/javascript">
    function decreaseFakeId( id ) {
        $( "#row_" + id ).nextAll().find( "td:first-child" ).each( function() {
            var temp = parseInt( $( this ).text() );
            temp--;
            $( this ).text( temp );
        });
    }

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

        $( "#delete_remind_modal #delete_fake_id" ).html( "你確定要刪除 <span style='color: red;'>" + fake_id + "號提醒事項</span> 嗎??" ); // write fake id
        $( "#delete_remind_modal" ).modal( "show" );

        $( "#delete_submit" ).on( "click" , function() {
            $.post( "./deleteRemind.php" , { deleteId : id } , function( data ) {
                // returnData : 0 -- success , 1 -- error
                if ( data.code == 0 ) {
                    // decrease fake id
                    decreaseFakeId( id );

                    $( "#row_" + id ).remove();

                    $( "#status" ).text( "" ).removeClass( "incorrect" );
                }
                else {
                    $( "#status" ).text( data.message ).addClass( "incorrect" );
                }

                $( "#delete_remind_modal" ).modal( "hide" ); // hide popup modal
            } , "json" ).fail( function() {
                $( "#status" ).text( "出現錯誤!! 請重試" ).addClass( "incorrect" );
                $( "#delete_remind_modal" ).modal( "hide" ); // hide popup modal
            });
        });
    });
</script>
