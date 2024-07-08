==============================================================================================================================

Website Setup Guide


1. Download and active all required application (Apache, MySQL, XAMPP)
2. In MySQL command client, run the following command. It return the path to the principal directory to store the input files.

    SELECT @@secure_file_priv;

3. Copy all sample data and real data files to the above address. If you are not using MySQL 8.0 or did not download MySQL by default, replace the path in read-sample.sql by your path.

4. In MySQL command client, run read-sample.sql by following command to set up sample database:

    source [path to read-sample.sql];

5. If you set the mysql password, type it in config.php

6. In any browser, search localhost/index.php to open the web. (If you are using xampp, you need to copy all files in directory WebsiteSetup to xampp/htdocs)

==============================================================================================================================

Features:


1. Basic search feature (search by exact title and print details).
2. User login/register.
3. Top navigate bar.
4. User history (NEW)
5. User comment (NEW)
6. User rating (NEW)
7. Movie detailed information (NEW)

==============================================================================================================================

File Description:


1. Directory DatabaseSetup store sql files to setup the databases (C2,C3,C4)
2. Directory SampleDatbase store csv file containing sample data (first 500 row of original data).
3. Directory WebsiteSetup store php files to setup the web (C5)
4. README.md (C1)