==============================================================================================================================

Website Setup Guide

1. Download raw data
    https://onedrive.live.com/?id=B432689A86B2CE06%21sb0033c43999b4a2eb6078f156d0aeefb&cid=B432689A86B2CE06&redeem=aHR0cHM6Ly8xZHJ2Lm1zL2YvYy9iNDMyNjg5YTg2YjJjZTA2L0VrTThBN0NibVM1S3RnZVBGVzBLN3ZzQkhHMUNHYklSejdkaGlTSjJDUVEzWlE%5FZT01OjZSOUtQMSZzaGFyaW5ndjI9dHJ1ZSZmcm9tU2hhcmU9dHJ1ZSZhdD05

2. Download and active all required application (Apache, MySQL, XAMPP)
3. In MySQL command client, run the following command. It return the path to the principal directory to store the input files.

    SELECT @@secure_file_priv;

4. Copy all sample data and real data files to the above address. If you are not using MySQL 8.0 or did not download MySQL by default, replace the path in read-sample.sql by your path.

5. In MySQL command client, run read-sample.sql by following command to set up sample database:

    source [path to read-sample.sql];

6.  In MySQL command client, run read-production.sql by following command to set up production database:

    source [path to read-production.sql];

7. If you set the mysql password, type it in config.php

8. In any browser, search localhost/index.php to open the web. (If you are using xampp, you need to copy all files in directory WebsiteSetup to xampp/htdocs)

==============================================================================================================================

Testing Guide

1. In MySQL command client, run text-sample.sql by following command:

    source [path to test-sample.sql];

2.  In MySQL command client, run test-production.sql by following command:

    source [path to test-production.sql];

[!] If you want to compare the time taken for queries with and without INDEX, you have to remove all command that create INDEX in read-production.sql.

[!] In order to observe how well INDEX perform, I temporary remove all INDEX that we addded in read-production.sql. We can see that, for our large movie database, INDEX decrease the time for query from 2-3 seconds to close to 0 seconds.

==============================================================================================================================

Features:

1. User login/register
2. Basic search feature (search by exact title and print details)
3. User history 
4. User comment
5. User rating
6. Movie detailed information (NEW)
7. The 5 most popular movies in main page (NEW)

==============================================================================================================================

Fancy Features:

1. Smart search (NEW)
2. Background (NEW)
3. Dark mode (NEW)
4. Multi-language
5. Top Navigate Bar

==============================================================================================================================

File Description:


1. Directory DatabaseSetup store sql files to setup and test the databases (C2,C3,C4)
2. Directory SampleDatbase store csv file containing sample data.
3. Directory WebsiteSetup store php files to setup the web (C5)
4. README.md (C1)
