<!DOCTYPE html>

<?php
    session_start();

    if ( isset( $_SESSION[ "username" ] ) && $_SESSION[ "username" ] != "" &&
         isset( $_SESSION[ "id" ] ) && $_SESSION[ "id" ] != "" &&
         isset( $_SESSION[ "email" ] ) && $_SESSION[ "email" ] ) {
        header( "Location: ./viewNFinishedRemind.php" );
    }
 ?>

<html>
    <head>
        <title>備忘錄系統</title>

        <!-- jquery file -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <!-- bootstrap include -->
        <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
        <script type="text/javascript" src="./js/bootstrap.min.js"></script>

        <!-- custom css file -->
        <link rel="stylesheet" type="text/css" href="./custom.css">
    </head>

    <!--body style="background-color: #a9d9f9"-->
    <body style="background-color: #a9d9f9;">
        <br><br>
        <a href="./index.php"><h1 style="text-align: center;">備忘錄系統</h1></a>
        <div id="status" style="text-align: center; font-size: 23px; color: red;"></div><br>

        <div class="row">
            <div class="column bgAdjust">
                <h2>登入</h2><br>
                <form name="signin">
                    電子郵件:<br>
                    <input type="text" id="signin_email" placeholder="你的電子郵件"><br><br>
                    <div id="checkEmail_"></div>

                    密碼:<br>
                    <input type="password" id="signin_password" placeholder="你的密碼"><br><br>
                    <div id="checkPassword_"></div>

                    <div class="row">
                        <div class="column buttonAdjust"><button class="btn btn-primary btn-lg" id="signin_submit" type="button">登入</button></div>
                        <div class="column buttonAdjust"><button class="btn btn-lg" id="signin_resetButton" type="reset">清空輸入格</button></div>
                    </div>
                </form>
            </div>

            <div class="column bgAdjust">
                <h2>註冊</h2><br>
                <form name="signup">
                    你的名字:<br>
                    <input type="text" id="signup_username" placeholder="你的名字" onblur="checkUsername( this.value )">
                    <div id="_checkUsername"></div><br><br>

                    你的電子郵件:<br>
                    <input type="text" id="signup_email" placeholder="你的電子郵件" onblur="checkEmail( this.value )">
                    <div id="_checkEmail"></div><br><br>

                    你的密碼: ( 英文與數字混和 至少8個字元 )<br>
                    <input type="password" id="signup_password" placeholder="你的密碼" onblur="checkPassword( this.value )">
                    <div id="_checkPassword"></div><br><br>

                    重新輸入密碼:<br>
                    <input type="password" id="signup_password_check" placeholder="你的密碼" onblur="matchPassword( this.value )">
                    <div id="_matchPassword"></div><br><br>

                    <div class="row">
                        <div class="column buttonAdjust"><button class="btn btn-primary btn-lg" type="button" id="signup_submit">註冊</button></div>
                        <div class="column buttonAdjust"><button class="btn btn-lg" type="reset" id="signup_resetButton">清空輸入格</button></div>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>

<script type="text/javascript">
    $( "#signin_submit" ).on( "click" , function() {
        // sign in
        var _email = $( "#signin_email" ).val();
        var _password = $( "#signin_password" ).val();

        if ( checkSigninStatus() ) {
            $.post( "./signin.php" , { email : _email , password : _password } , function( data ) {
                // returnData : 0 -- success , 1 -- error
                if ( data.code == 0 ) {
                    window.location.replace( "./viewNFinishedRemind.php" );
                }
                else {
                    $( "#status" ).text( data.message ).addClass( "incorrect" );
                    $( "#signin_password" ).val( "" );
                }
            } , "json" ).fail( function() {
                $( "#status" ).text( "出現錯誤!! 請重試" ).addClass( "incorrect" );
            });
        }
    });

    $( "#signup_submit" ).on( "click" , function() {
        // sign up
        var _username = $( "#signup_username" ).val();
        var _email = $( "#signup_email" ).val();
        var _password = $( "#signup_password" ).val();

        if ( checkSignupStatus() ) {
            // contact with server only if everything is okay
            $.post( "./signup.php" , { username : _username , email : _email , password : _password } , function( data ) {
                // returnData : 0 -- success , 1 -- error
                if ( data.code == 0 ) {
                    window.location.replace( "./viewNFinishedRemind.php" );
                }
                else {
                    $( "#status" ).text( data.message ).addClass( "incorrect" );
                    $( "#signin_password" ).val( "" );
                }
            } , "json" ).fail( function() {
                $( "#status" ).text( "出現錯誤!! 請重試" ).addClass( "incorrect" );
            });
        }
    });

    $( "#signin_resetButton" ).on( "click" , function() {
        $( "#checkEmail_" ).text( "" );
        $( "#checkPassword_" ).text( "" );
        $( "#status" ).text( "" );
    });

    $( "#signup_resetButton" ).on( "click" , function() {
        // clean
        $( "#_checkUsername" ).text( "" );
        $( "#_checkEmail" ).text( "" );
        $( "#_checkPassword" ).text( "" );
        $( "#_matchPassword" ).text( "" );
        $( "#status" ).text( "" );
    });
//-----------------------------------------------------------------------------------------------------------------------
    function checkSigninStatus() {
        var okay = true;

        if ( $( "#signin_email" ).val() == "" ) {
            $( "#checkEmail_" ).text( "名字不可為空!!" ).addClass( "incorrect" );
            okay = false;
        }
        else {
            $( "#checkEmail_" ).text( "" ).removeClass( "incorrect" );
            okay = true;
        }

        if ( $( "#signin_password" ).val() == "" ) {
            $( "#checkPassword_" ).text( "密碼不可為空!!" ).addClass( "incorrect" );
            okay = false;
        }
        else {
            $( "#checkPassword_" ).text( "" ).removeClass( "incorrect" );
            okay = true;
        }

        if ( $( "#checkEmail_" ).text() != "" || $( "#checkPassword_" ).text() != "" ) okay = false;

        return okay;
    }

    function checkSignupStatus() {
        // check total status
        var okay = true;

        if ( $( "#signup_username" ).val() == "" ) {
            $( "#_checkUsername" ).text( "名字不可為空!!" ).addClass( "incorrect" );
            okay = false;
        }
        if ( $( "#signup_email" ).val() == "" ) {
            $( "#_checkEmail" ).text( "電子郵件不可為空!!" ).addClass( "incorrect" );
            okay = false;
        }
        if ( $( "#signup_password" ).val() == "" ) {
            $( "#_checkPassword" ).text( "密碼不可為空!!" ).addClass( "incorrect" );
            okay = false;
        }
        if ( $( "#signup_password_check" ).val() == "" ) {
            $( "#_matchPassword" ).text( "確認密碼不可為空!!" ).addClass( "incorrect" );
            okay = false;
        }

        if ( $( "#_checkUsername" ).text() != "" || $( "#_checkEmail" ).text() != "" || $( "#_checkPassword" ).text() != "" || $( "#_matchPassword" ).text() != "" ) okay = false;

        return okay;
    }

    function checkUsername( input ) {
        if ( input == "" ) {
            $( "#_checkUsername" ).text( "名字不可為空!!" ).addClass( "incorrect" );
        }
        else if ( /^\s*$/.test( input ) ) {
            $( "#_checkUsername" ).text( "名字須包含至少一個可顯示字母!!" ).addClass( "incorrect" );
        }
        else if ( !/[a-zA-Z]/.test( input ) ) {
            $( "#_checkUsername" ).text( "名字須包含至少一個英文字母!!" ).addClass( "incorrect" );
        }
        else {
            $( "#_checkUsername" ).text( "" ).removeClass( "incorrect" );
        }
    }

    function checkEmail( input ) {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if ( input == "" ) {
            $( "#_checkEmail" ).text( "電子郵件不可為空!!" ).addClass( "incorrect" );
            return;
        }
        else if ( !re.test( String( input ).toLowerCase() ) ) {
            $( "#_checkEmail" ).text( "電子郵件格式錯誤!!" ).addClass( "incorrect" );
            return;
        }
        else {
            $( "#_checkEmail" ).text( "" ).removeClass( "incorrect" );
        }
        //send to backend to check email via jquery ajax using post method with json
        var request = $.ajax({
            method: "post" ,
            url: "./checkEmail.php" ,
            dataType: "json" , // backend return type
            data: { email : input }
        });
        request.done( function( data ) {
            // no need to parse to javascript object , it will auto covert to javascript object
            // returnData : 0 -- false , 1 -- true
            if ( data.code != 0 ) {
                $( "#_checkEmail" ).text( data.message ).addClass( "incorrect" );
            }
        });
    }

    function checkPassword( input ) {
        var len = input.length;
        var check = /\d/.test( input ) && /[a-zA-Z]/.test( input );
        var message = "";

        if ( input != "" ) {
            if ( check == false ) message = message.concat( "英數混合 " );
            if ( len < 8 ) message = message.concat( "至少8個字元" );
        }
        else message = message.concat( "密碼不可為空" );

        if ( message != "" ) {
            message = message.concat( "!!" );
            $( "#_checkPassword" ).text( message ).addClass( "incorrect" );
        }
        else $( "#_checkPassword" ).text( "" ).removeClass( "incorrect" );
    }

    function matchPassword( input_check ) {
        var input_origin = $( "#signup_password" ).val();

        if ( input_check == "" ) {
            $( "#_matchPassword" ).text( "確認密碼不可為空!!" ).addClass( "incorrect" );
        }
        else {
            if ( input_origin != input_check ) {
                $( "#_matchPassword" ).text( "密碼不符合!!" ).addClass( "incorrect" );
            }
            else {
                $( "#_matchPassword" ).text( "" ).removeClass( "incorrect" );
            }
        }
    }
</script>
