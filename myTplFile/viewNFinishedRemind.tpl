<!DOCTYPE html>

<html>
    <head>
        <title>未完成提醒事項</title>

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
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                新增提醒事項
            </button>
            <a href="./viewFinishedRemind.php">已完成提醒事項</a>
        </span>
        <a href="./viewNFinishedRemind.php"><h2 id="prompt">未完成提醒事項</h2></a>

        <div id="status" style="text-align: center;"></div><br>

        <table id="tableStyle" align="center">
            <tr>
                <th>編號</th>
                <th>提醒事項主題</th>
                <th>提醒事項備註</th>
                <th>狀態</th>
                <th>寄送通知</th>
                <th>寄送時間</th>
                <th>編輯</th>
                <th>刪除</th>
            </tr>
            <!-- START BLOCK : reminds -->
            <tr id="row_{showId}"><!-- real id -->
                <td>{showCountId}</td><!-- fake id -->

                <td><span class="m_subject_{showId}">{showSubject}</span></td>
                <td><span class="m_remark_{showId}">{showRemark}</span></td>
                <td><span class="m_status_{showId}">{showStatus}</span></td>
                <td><span class="m_notify_{showId}">{showNotify}</span></td>
                <td><span class="m_notifyTime_{showId}">{showNotifyTime}</span></td>
                <td><button class="btn modify_remind" value="{showId}" type="button">更新</button></td>
                <td><button class="btn btn-danger delete_remind" value="{showId}" type="button" style="background-color: #ff1933; color: #ffffff;">刪除</button></td>
            </tr>

            <tr id="modify_row_{showId}" style="display: none;">
                <td>{showCountId}</td><!-- fake id -->

                <td id="subject_{showId}" style="padding: 5px;"><!-- subject -->
                    <input class="m_subject_{showId}" type="text" value="{showSubject}" style="width: 100%;">
                </td>

                <td id="remark_{showId}" style="padding: 5px;"><!-- remark -->
                    <input class="m_remark_{showId}" type="text" value="{showRemark}" style="width: 100%;">
                </td>

                <td id="status_{showId}"><!-- finish or not -->
                    <span class="sm_status_{showId}">
                        <input class="m_status_{showId}" type="radio" name="status_check{showId}" value="yes" >已完成
                        <input class="m_status_{showId}" type="radio" name="status_check{showId}" value="no" checked>未完成
                    </span>
                </td>

                <td id="notify_{showId}"><!-- send email or not -->

                    <span class="sm_notify_{showId}">
                        <input class="general_notify m_notify_{showId}" type="radio" name="notify_check{showId}" value="yes" checked>寄送
                        <input class="general_notify m_notify_{showId}" type="radio" name="notify_check{showId}" value="no">不寄送
                    </span>
                </td>

                <td id="notifyTime_{showId}"><!-- when to send email -->
                    <input class="m_notifyTime_{showId}" type="datetime-local">
                </td>

                <td>
                    <button class="btn btn-success save_remind" value="{showId}" type="button">存檔</button>
                </td>

                <td>
                    <button class="btn cancel_remind" value="{showId}" type="button">取消</button>
                </td>
            </tr>
            <!-- END BLOCK : reminds -->
        </table>

        <!-- add remind Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content" style="background-color: #d1f1ff;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">新增提醒事項</h5>
                        <!-- 叉叉 -->
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <div id="add_status" style="text-align: center;"></div>
                        <form id="addRemind_form">
                                <h5>提醒事項主題: </h5>
                                <textarea placeholder="主題(不可為空)" id="input_subject"></textarea><br>
                            <div id="check_input_subject"></div><br>
                                <h5>提醒事項備註: </h5>
                                <textarea placeholder="備註(可為空)" id="input_remark"></textarea><br>
                            <div class="row row_form" style="font-size: 20px;">
                                <div class="column" style="background-color: #ffffff;">
                                    <h5 style="margin-top: 10px; margin-bottom: 10px;">email寄信通知: </h5><input type="radio" value="yes" name="checkEmail">寄送 <input type="radio" value="no" checked name="checkEmail">不寄送<br>
                                </div>
                                <div class="column" style="background-color: #ffffff;">
                                    <h5 style="margin-top: 10px; margin-bottom: 10px;">email寄信通知時間: </h5><input id="current_date_time" type="datetime-local" disabled>
                                </div>
                            </div>
                            <div class="row row_form" style="font-size: 20px; background-color: #ffffff;">
                                <div class="column" style="background-color: #ffffff;">
                                    <h5 style="margin-top: 10px; margin-bottom: 10px;">預設寄送email為: </h5>{showEmail}
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="modal-footer">

                        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-success" id="add_submit">存檔</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- end add remind Modal -->

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
    </body>
</html>

<script type="text/javascript">
    $( document ).ready( function() {
        // the following is output current date on window function
        Date.prototype.yyyymmdd = function() {
          var mm = this.getMonth() + 1; // getMonth() is zero-based
          var dd = this.getDate();
          var hh = this.getHours();
          var m = this.getMinutes();
          var result = [ this.getFullYear() , ( mm > 9 ? '' : '0' ) + mm , ( dd > 9 ? '' : '0' ) + dd ].join( '-' ) + "T" + ( hh > 9 ? '' : '0' ) + hh + ":" + ( m > 9 ? '' : '0' ) + m;

          return result;
        };
    });

    function writeEmailToScreen( id ) {
        var temp = $( "span.m_notify_" + id ).text();

        if ( temp == "寄送" ) {
            $( "input[class='general_notify m_notify_" + id + "'][value='yes']" ).prop( "checked" , true ); // set input radio to yes
            var emailTime = $( "span.m_notifyTime_" + id ).text(); // retrieve notify time
            emailTime = emailTime.replace( " " , "T" ); // convert to accepted format
            $( "input[type='datetime-local'][class='m_notifyTime_" + id + "']" ).val( emailTime ); // set screen datetime to db's datetime
        }
        else {
            $( "input[class='general_notify m_notify_" + id + "'][value='no']" ).prop( "checked" , true );
            $( "input[type='datetime-local'][class='m_notifyTime_" + id + "']" ).prop( "disabled" , true ); // disable time block
        }
    }

    function decreaseFakeId( id ) {
        $( "#row_" + id ).nextAll().find( "td:first-child" ).each( function() {
            var temp = parseInt( $( this ).text() );
            temp--;
            $( this ).text( temp );
        });
    }

    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


    $( document ).on( "change" , ".general_notify" , function() {
        var id = $( this ).attr( "class" ).replace( "general_notify m_notify_" , "" ); // get id from class name

        $( "input[type='datetime-local'][class='m_notifyTime_" + id + "']" ).prop( "disabled" , function( i , v ) {
            // i --> property name , v --> property value
            if ( v ) {
                var date = new Date();
                $( "input[type='datetime-local'][class='m_notifyTime_" + id + "']" ).val( date.yyyymmdd() );
                // set current date time
            }
            else {
                $( "input[type='datetime-local'][class='m_notifyTime_" + id + "']" ).val( "" );
            }
             return !v;
         });
    });

    $( "#signOut" ).on( "click" , function() {
        $.post( "./signout.php" , function( data ) {
            if ( data.code == 0 ) {
                window.location.replace( "./index.php" );
            }
        } , "json" ).fail( function() {
            $( "#status" ).text( "出現錯誤!! 請重試" ).addClass( "incorrect" );
        });
    });

    $( document ).on( "click" , ".modify_remind" , function() {
        // modify part
        var id = $( this ).val();

        if ( $( "span.sm_notify_" + id ).is( ":hidden" ) ) {
            // will be visible after the following done , so need to write time on to screen
            writeEmailToScreen( id );
        }

        $( "#modify_row_" + id ).addClass( "modify_row" );
        $( "#modify_row_" + id ).show();
        $( "#row_" + id ).hide();
    });

    $( document ).on( "click" , ".save_remind" , function() {
        var _id = $( this ).val();
        var _subject = $( "input[class='m_subject_" + _id + "']" ).val();
        var _remark = $( "input[class='m_remark_" + _id + "']" ).val();
        var _status = $( "input[name='status_check" + _id + "']:checked" ).val();
        var _notify = $( "input[class='general_notify m_notify_" + _id + "']:checked" ).val();
        var _notify_time = $( "input[class='m_notifyTime_" + _id + "']" ).val();

        if ( _subject == "" ) {
            $( "#status" ).text( "主題不可為空!!" ).addClass( "incorrect" );
        }
        else if ( /^\s*$/.test( _subject ) ) {
            $( "#status" ).text( "請輸入可顯示之字元!!" ).addClass( "incorrect" );
        }
        else {
            $.post( "./updateRemind.php" ,
                { id : _id ,
                  subject : _subject ,
                  remark : _remark ,
                  status : _status ,
                  notify : _notify ,
                  notify_time : _notify_time } , function( data ) {
                // returnData : 0 -- success , 1 -- error
                if ( data.code == 0 ) {
                    // update block value & text
                    if ( _status == "yes" ) {
                        $( "#status" ).text( "" ).removeClass( "incorrect" );
                        decreaseFakeId( _id );
                        $( "#row_" + _id ).remove();
                        $( "#modify_row_" + _id ).remove();
                    }
                    // show block
                    $( "span.m_subject_" + _id ).text( _subject );
                    $( "span.m_remark_" + _id ).text( _remark );
                    $( "span.m_status_" + _id ).text( "未完成" );
                    $( "span.m_notify_" + _id ).text( _notify == "yes" ? "寄送" : "不寄送" );
                    $( "span.m_notifyTime_" + _id ).text( _notify == "yes" ? _notify_time.replace( "T" , " " ) + ":00" : "無" );

                    // input block
                    $( "input.m_subject_" + _id ).val( _subject );
                    $( "input.m_remark_" + _id ).val( _remark );
                    $( "input.m_status_" + _id + "[value='no']" ).prop( "checked" , true );
                    $( "input.m_notify_" + _id + "[value='" + _notify + "']" ).prop( "checked" , true );
                    if ( _notify == "no" ) {
                        $( "input.m_notifyTime_" + _id ).prop( "disabled" , true );
                    }
                    else {
                        var date = new Date();
                        $( "input.m_notifyTime_" + _id ).val( date.yyyymmdd() );
                    }

                    // show block : show , input block : hide
                    $( "#row_" + _id ).show();
                    $( "#modify_row_" + _id ).hide();

                    $( "#status" ).text( "" ).removeClass( "incorrect" );
                }
                else {
                    $( "#status" ).text( data.message ).addClass( "incorrect" );
                }
            } , "json" ).fail( function() {
                $( "#status" ).text( "出現錯誤!! 請重試" ).addClass( "incorrect" );
            });
        }
    });

    $( document ).on( "click" , ".cancel_remind" , function() {
        var id = $( this ).val();

        $( "#status" ).text( "" ).removeClass( "incorrect" );

        $( "#row_" + id ).removeClass( "modify_row" );
        $( "#modify_row_" + id ).hide();
        $( "#row_" + id ).show();
    });

    $( document ).on( "click" , ".delete_remind" , function() {
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
                    $( "#modify_row_" + id ).remove();

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

    $( "input[name=checkEmail]" ).on( "change" , function() {
        $( "#current_date_time" ).prop( "disabled" , function( i , v ) {
            // i --> property name , v --> property value
            if ( v ) {
                var date = new Date();
                $( "#current_date_time" ).val( date.yyyymmdd() );
            }
            else {
                $( "#current_date_time" ).val( "" );
            }
             return !v;
         });
    });

    // the following js is add remind's

    $( document ).ready( function() {
        // the following is output current date on window function
        Date.prototype.yyyymmdd = function() {
          var mm = this.getMonth() + 1; // getMonth() is zero-based
          var dd = this.getDate();
          var hh = this.getHours();
          var m = this.getMinutes();
          var result = [ this.getFullYear() , ( mm > 9 ? '' : '0' ) + mm , ( dd > 9 ? '' : '0' ) + dd ].join( '-' ) + "T" + ( hh > 9 ? '' : '0' ) + hh + ":" + ( m > 9 ? '' : '0' ) + m;

          return result;
        };
    });
    function checkAddStatus() {
        var okay = true;
        var _input_subject = $( "#input_subject" ).val();

        if ( _input_subject == "" ) {
            okay = false;
            $( "#check_input_subject" ).text( "主題不可為空!!" ).addClass( "incorrect" );
        }
        else if ( /^\s*$/.test( _input_subject ) ) {
            okay = false;
            $( "#add_status" ).text( "請輸入可顯示之字元!!" ).addClass( "incorrect" );
        }
        else {
            $( "#check_input_subject" ).text( "" ).removeClass( "incorrect" );
        }

        return okay;
    }

    function parse( str ) {
        var args = [].slice.call( arguments , 1 ) , i = 0;

        return str.replace( /%s/g , function() {
            return args[ i++ ];
        });
    }

    function addTr( subject , remark , notify , notify_time , id , fake_id ) {
        remark = remark == "" ? "無" : remark;
        notify = notify == "no" ? "不寄送" : "寄送";
        notify_time = notify_time == "" ? "無" : notify_time.replace( "T" , " " ) + ":00";

        // show content tr
        var append1 = '<tr id="row_%s"><td>%s</td>';
        append1 += '<td><span class="m_subject_%s">%s</span></td>';
        append1 += '<td><span class="m_remark_%s">%s</span></td>';
        append1 += '<td><span class="m_status_%s">未完成</span></td>';
        append1 += '<td><span class="m_notify_%s">%s{notify}</span></td>';
        append1 += '<td><span class="m_notifyTime_%s">%s</span></td>';
        append1 += '<td><button class="btn modify_remind" value="%s" type="button">更新</button></td>';
        append1 += '<td><button class="btn btn-danger delete_remind" value="%s" type="button" style="background-color: #ff1933; color: #ffffff;">刪除</button></td></tr>';

        append1 = parse( append1 , id , fake_id , id , subject , id , remark , id , id , notify , id , notify_time , id , id );
        $( "table tr:last" ).after( append1 );

        // show input tr
        var append2 = '<tr id="modify_row_%s" style="display: none;">';
        append2 += '<td>%s</td><!-- fake id -->';
        append2 += '<td id="subject_%s"><!-- subject -->';
        append2 += '<input class="m_subject_%s" type="text" value="%s" style="width: 80%;"></td>';
        append2 += '<td id="remark_%s"><!-- remark -->'
        append2 += '<input class="m_remark_%s" type="text" value="%s" style="width: 80%;"></td>';
        append2 += '<td id="status_%s"><!-- finish or not -->';
        append2 += '<span class="sm_status_%s">';
        append2 += '<input class="m_status_%s" type="radio" name="status_check%s" value="yes" >已完成';
        append2 += '<input class="m_status_%s" type="radio" name="status_check%s" value="no" checked>未完成</span></td>';
        append2 += '<td id="notify_%s"><!-- send email or not -->';
        append2 += '<span class="sm_notify_%s">';
        append2 += '<input class="general_notify m_notify_%s" type="radio" name="notify_check%s" value="yes" checked>寄送';
        append2 += '<input class="general_notify m_notify_%s" type="radio" name="notify_check%s" value="no">不寄送</span></td>';
        append2 += '<td id="notifyTime_%s"><!-- when to send email -->';
        append2 += '<input class="m_notifyTime_%s" type="datetime-local"></td>';
        append2 += '<td><button class="btn btn-success save_remind" value="%s" type="button">存檔</button></td>';
        append2 += '<td><button class="btn cancel_remind" value="%s" type="button">取消</button></td></tr>';

        append2 = parse( append2 , id , fake_id , id , id , subject , id , id , remark , id , id , id , id , id , id , id , id , id , id , id , id , id , id , id , id );
        $( "table tr:last" ).after( append2 );
    }
    //------------------------------------------------------------------------------------------------------------------------------------------------------
    $( "#add_submit" ).on( "click" , function() {
        var _subject = $( "#input_subject" ).val();
        var _remark = $( "#input_remark" ).val();
        var _notify = $( "input[name=checkEmail]:checked" ).val();
        var _notify_time = $( "#current_date_time" ).val();

        if ( checkAddStatus() ) {
            $.post( "./addRemind.php" ,
                { subject : _subject , remark : _remark , notify : _notify , notify_time : _notify_time } ,
                function( data ) {
                    if ( data.code == 0 ) {
                        // get insert primary id
                        var id = data.id;
                        var fake_id = parseInt( $( "table tr:last td:first" ).text() ) + 1;

                        // clear data
                        $( "#input_subject , #input_remark" ).val( "" );
                        $( "#addRemind_form input[type='radio'][value='no']" ).prop( "checked" , true );
                        $( "#addRemind_form #current_date_time" ).prop( "disabled" , true );
                        $( "#addRemind_form #current_date_time" ).val( "" );

                        // hide add remind block
                        $( "#myModal" ).modal( "hide" );
                        addTr( _subject , _remark , _notify , _notify_time , id , fake_id );
                    }
                    else {
                        $( "#status" ).text( data.message ).addClass( "incorrect" );
                    }
            } , "json" ).fail( function() {
                $( "#add_status" ).text( "出現錯誤!! 請重試" ).addClass( "incorrect" );
            });
        }
    });

    $( "#myModal" ).on( "hide.bs.modal" , function() {
        $( "#check_input_subject" ).empty().removeClass( "incorrect" );
    });
</script>
