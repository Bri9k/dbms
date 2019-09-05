# Assignment 1

* To see databases which are present:

    mysql>show databases;

* To create a new database:

    mysql>create database <name>;

* To access tables from a particular database

    mysql>use <name>;

* To see tables which are present in the database:
    
    mysql>show tables;

* To create a table, do the following

    mysql>create table student
        ->(name VARCHAR(20),
        -> address VARCHAR(20),
        -> mis INTEGER,
        -> PRIMARY KEY (mis));

> PRIMARY KEY is used to specify  that a particular attribute should be unique for all rows in the table;

* To delete a table from the database:

    mysql>DROP TABLE student;

* To see information about a particular table:

    mysql>DESCRIBE <tablename>;

* To insert a row into a table do

    mysql>INSERT INTO student
        ->VALUE ("Bilbo Baggins", "Bag End, Hobbiton", 13);

* Alternately, do the following:
    mysql> INSERT INTO student (name, address, mis)
        -> VALUE ("Bilbo Baggins", "Bag End, Hobbiton", 13);

* The SELECT command has the following syntax

    mysql>SELECT what
        ->FROM which
        ->WHERE condition;

* To modify an existing table, the command 'ALTER TABLE' is used

 * To modify type

    mysql>ALTER TABLE <tablename>
        ->MODIFY COLUMN <columnname> <type>;

 * To add column

    mysql> ALTER TABLE <tablename>
        -> ADD COLUMN <columnname>;

 * To delete a column

    mysql> ALTER TABLE <tablename>
        -> DROP COLUMN <columnname>;

* To update a value

    mysql> UPDATE student
        -> SET birth = "2019-08-17"
        -> WHERE mis = 111703013;

> We can update a particular entry OR, by proper use of where, update a number of rows

## Example

* Created a LOTR fellowship input file in students.txt

    CREATE TABLE fellowship
    (name VARCHAR(20),
    town VARCHAR(10)
    birth DATE);

    LOAD DATA LOCAL INFILE "students.txt" INTO TABLE fellowship;

* All people who are 'modern' (not legolas)

    SELECT name
    FROM fellowship
    WHERE YEAR(date) > 2800;

* All people having names starting with A

    SELECT name
    FROM fellowship
    WHERE name LIKE "A%";

* All people born in hobbiton

    SELECT *
    FROM fellowship
    WHERE town = "Hobbiton";
