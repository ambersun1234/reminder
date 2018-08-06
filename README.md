# Reminder

+ ### Build for everyone!!<hr>
    + This is Reminder , a website that allow user to create personal remind item .
    + Basically , user can view , modify and delete your own remind item . We also provide "send notify email" to your personal mailbox , you can choose to notify or not on web page. Sign up or Sign in to check more !!

+ ### Getting started<hr>
    + #### Requirements
        + windows 10 version 1803
        + xampp v3.2.2

    + #### Clone repo
        ```shell=1
        git clone https://github.com/ambersun1234/reminder.git C:\xampp\htdocs\www
        ```

    + #### Configure xampp
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

    + #### Configure send email
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
        + ![](https://i.imgur.com/4T6hLZa.png)
    + view not finished remind item
        + ![](https://i.imgur.com/7NiYVk3.png)
    + modify remind item
        + ![](https://i.imgur.com/hxY04iH.png)
    + delete remind item
        + ![](https://i.imgur.com/NKShjjM.png)
    + create remind item
        + ![](https://i.imgur.com/AXFcXbV.png)
