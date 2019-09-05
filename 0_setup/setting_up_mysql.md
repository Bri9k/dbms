# Basic MySQL

## Installing MySQL on Debian (or Ubuntu)
Note that everything I write here is a less accurate, albeit simple copy of [this](https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/).
Procedure:

Add the APT repository by installing the file mysql-apt-config\_0.8.13-1\_all.deb with dpkg. 
Their method uses

    sudo dpkg -i mysql-apt-config_0.8.13-1_all.deb

however, I did

    sudo apt install mysql-apt-config_0.8.13-1_all.deb

which is just as well. Then

    sudo apt update
    sudo apt install mysql-server

During installation, you are prompted to decide your password as database administrator, among other things.

Once installed, the server runs as a *service* which starts everytime your computer starts. So there might be a need to start or stop the server.

    sudo service mysql status
    sudo service mysql stop
    sudo service mysql start

There is a GUI for managing MySQL called mysql-workbench

    sudo apt install mysql-workbench-community

Simply typing in 'mysql' after installation will cause *this*:

    shell> mysql
    ERROR 1045 (28000): Access denied for user 'user'@'localhost' (using password: NO)

(haha I am not going to tell you my usernam)

What you need to do (now that you have installed on your own machine)

    shell> mysql -u user -p
    password:

Enter the password. You are in!

    mysql>

## Basics:

Most of this is copied from [here](https://dev.mysql.com/doc/refman/8.0/en/tutorial.html).

    mysql>

Queries in mysql are CaSe InsenSITIVe. 

    mysql> select now();
    +---------------------+
    | now()               |
    +---------------------+
    | 2019-08-04 15:14:36 |
    +---------------------+

    mysql> select user(), now();
    +----------------+---------------------+
    | user()         | now()               |
    +----------------+---------------------+
    | root@localhost | 2019-08-04 15:16:46 |
    +----------------+---------------------+
    1 row in set (0.01 sec)

Other possible queries are *VERSION()*, *(SIN(PI() / 4))*, *CURRENT_DATE*.


A query can be entered over multiple lines:

    mysql> select now(),
        -> version();

The nature of the -> could be telling you that you are missing a \' or a \" or for the end of a comment

But all this is useless unless we have a *database*. There already are certain databases in your system.

    mysql> show databases;

Will show them.
To create your own database:

    mysql> create database menagerie;

You can see this by doing

    mysql> show databases;

Now you can start using menagerie by doing

    mysql> use menagerie;


https://dev.mysql.com/doc/refman/8.0/en/load-data-local.html
