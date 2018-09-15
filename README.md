# Reminder

+ ### Build For Everyone!!<hr>
    + This is Reminder , a website that allow user to create personal remind item .
    + Basically , user can view , modify and delete your own remind item . We also provide "send notify email" to your personal mailbox , you can choose to notify or not on web page. Sign up or Sign in to check more !!

+ ### Getting Started<hr>
    + #### Requirements
        + windows 10 version 1803
        + xampp v3.2.2

    + #### Clone Repo
        ```shell=1
        git clone https://github.com/ambersun1234/reminder.git C:\xampp\htdocs\www
        ```

    + #### Configure Xampp
        1. launch xampp control panel
        2. press Apache's config , and choose **Apache (httpd.conf)**
        3. find
        ```=1
        DocumentRoot "C:\xampp\htdocs"
        <Directory "C:\xampp\htdocs">
        ```
        4. and change to the following
        ```=1
        DocumentRoot "C:\xampp\htdocs\www"
        <Directory "C:\xampp\htdocs\www">
        ```
        5. start apache & mysql

	+ #### Configure Mysql
        + create the database that reminder needed
        ```=1
        CREATE DATABASE IF NOT EXISTS `reminders`;

        CREATE TABLE IF NOT EXISTS `remind_user` (
          `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
          `name` char(100) NOT NULL COMMENT '使用者名稱',
          `password` char(128) NOT NULL COMMENT '使用者密碼',
          `email` varchar(100) NOT NULL COMMENT '使用者帳號',
          `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否刪除',
          `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建置時間',
          PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='使用者資料表';

        CREATE TABLE IF NOT EXISTS `remind_item` (
          `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
          `user_guid` bigint(20) unsigned NOT NULL COMMENT 'remind_user.id',
          `item_subject` varchar(100) NOT NULL COMMENT '提醒事項主題',
          `item_remark` varchar(300) NOT NULL COMMENT '提醒事項備註',
          `item_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '提醒事項狀態0未完成1已完成',
          `notify` tinyint(1) NOT NULL DEFAULT '0' COMMENT '寄信通知0不寄送1寄送',
          `notify_datetime` datetime DEFAULT NULL COMMENT '寄信通知時間',
          `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否刪除',
          `create_time` datetime NOT NULL COMMENT '建立時間',
          `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新時間',
          PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='提醒事項資料表';
        ```

    + #### Configure Send Email
        + sendEmail.php
            + $mail->Username = "YOUR_EMAIL"
            + $mail->Password = "YOUR_EMAIL'S_PASSWORD"
            + $mail->setFrom( "YOUR_EMAIL" , "reminder" );
            + the rest of the email setup , please visit [PHPMailer](https://github.com/PHPMailer/PHPMailer)
        + auto.bat
            + we use windows 10 build in **Task Scheduler** to perform auto send email
            + please **Create Task**
                1. set execute time to ***one minute***
                2. action: start a program , choose **auto.bat**

+ #### Running
    + just start apache & mysql server , and type **localhost** in your web browser

+ #### License
    + This project is licensed under **GPL v3.0** see the [LICENSE](https://github.com/ambersun1234/reminder/blob/master/LICENSE) for detail

+ #### Photo<hr>
    + index
        + ![](https://i.imgur.com/cuvdYJA.jpg)
    + view not finished remind item
        + ![](https://i.imgur.com/97aKto1.jpg)
    + modify remind item
        + ![](https://i.imgur.com/tBTjzwq.jpg)
    + delete remind item
        + ![](https://i.imgur.com/pssq7UD.jpg)
    + create remind item
        + ![](https://i.imgur.com/jPfzvc8.jpg)
