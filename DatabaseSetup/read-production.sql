CREATE DATABASE movieDB;
USE movieDB;

-- read from title.akas.csv

CREATE TABLE titleAkas (
    titleId varchar(256),
    ordering int,
    title varchar(560),
    region varchar(256),
    language varchar(256),
    types varchar(256),
    attributes varchar(256),
    isOriginalTitle int
    
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.akas.csv'
INTO TABLE titleakas
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE INDEX idx_titleId ON titleAkas (titleId);
CREATE INDEX idx_title ON titleAkas (title);

-- read from title.basics.csv

CREATE TABLE titleBasics (
    titleId varchar(256),
    titleType varchar(256),
    primaryTitle varchar(560),
    originalTitle varchar(560),
    isAdult INT,
    startYear varchar(4),
    endYear varchar(4),
    runtimeMinutes varchar(16),
    genres TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.basics.csv'
INTO TABLE titleBasics
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(titleId, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes, genres, @dummy, @dummy, @dummy, @dummy, @dummy);

-- read from title.ratings.csv
CREATE TABLE titleRatings (
    titleId varchar(256),
    averageRating FLOAT,
    numVotes INT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.ratings.csv'
INTO TABLE titleRatings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE INDEX idx_titleId ON titleRatings (titleId);

-- read from title.episode.csv
CREATE TABLE titleEpisode (
    titleId varchar(256),
    parentId varchar(256),
    seasonNum INT,
    episodeNum INT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.episode.csv'
INTO TABLE titleEpisode
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- read from title.crew.csv
CREATE TABLE titleCrew (
    titleId varchar(256),
    directorId TEXT,
    writerId LONGTEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.crew.csv'
INTO TABLE titleCrew
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- read from title.principals.csv
CREATE TABLE titlePrincipals (
    titleId varchar(256),
    ordering INT,
    personId varchar(256),
    category varchar(256),
    job varchar(256),
    characters TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.principals.csv'
INTO TABLE titlePrincipals
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(titleId, ordering, personId, category, job, characters, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

-- read from name.basics.csv
CREATE TABLE nameBasics (
    personId varchar(256),
    primaryName varchar(256),
    birthYear varchar(4),
    deathYear varchar(4),
    primaryProfession varchar(256),
    knownForTitles varchar(256)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/name.basics.csv'
INTO TABLE nameBasics
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(personId, primaryName, birthYear, deathYear, primaryProfession, knownForTitles, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);



-- create table for users

CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) NOT NULL UNIQUE,
    fname VARCHAR(50),
    lname VARCHAR(50),
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX idx_email ON users (email);
CREATE UNIQUE INDEX idx_emailpassword ON users (email,password);

-- create table for viewingHistory

CREATE TABLE viewingHistory (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    titleId varchar(256) NOT NULL,
    date VARCHAR(21) NOT NULL
);

CREATE INDEX idx_userId ON viewingHistory (userId);

-- create table for contactForm

CREATE TABLE contactForm (
    cid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date VARCHAR(10) NOT NULL,
    isComplete INT NOT NULL,
    name VARCHAR(50),
    email VARCHAR(50),
    content VARCHAR(1000),
    SId INT
);

-- create table for User comment/rating

CREATE TABLE comment (
    commentId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    comment VARCHAR(1000) NOT NULL,
    rating INT NOT NULL,
    userId INT NOT NULL,
    titleId VARCHAR(256) NOT NULL,
    date VARCHAR(21) NOT NULL
);

CREATE INDEX idx_userId ON comment (userId);

-- hot movies

CREATE TABLE hot (
    titleId varchar(256) NOT NULL,
    averageRating FLOAT
);

SET @lastUpdateHot = "";

-- update_hot() will update hot movie relation if and only if it is not updateded today
DELIMITER &&  
CREATE PROCEDURE update_hot ()
BEGIN
    IF @lastUpdateHot < CURDATE() THEN
    SET @lastUpdateHot = CURDATE();
    TRUNCATE TABLE hot;
    INSERT INTO hot(titleid, averageRating) SELECT titleid, averageRating
    FROM titleratings
    WHERE EXISTS (SELECT title FROM titleakas WHERE titleakas.titleId= titleratings.titleid)
    ORDER BY titleRatings.averageRating*LOG(titleRatings.numVotes) DESC LIMIT 5;
    END IF;
END &&
DELIMITER ;

CALL update_hot();

-- muti-language 

-- Create Languages table

CREATE TABLE Languages (
    LanguageID INT PRIMARY KEY AUTO_INCREMENT,
    LanguageCode VARCHAR(10) NOT NULL,
    LanguageName VARCHAR(50) NOT NULL
);

-- Create Translations table

CREATE TABLE Translations (
    TranslationID INT PRIMARY KEY AUTO_INCREMENT,
    LanguageID INT,
    OriginalText TEXT NOT NULL,
    TranslatedText TEXT NOT NULL,
    FOREIGN KEY (LanguageID) REFERENCES Languages(LanguageID)
);

INSERT INTO Languages (LanguageCode, LanguageName) VALUES 
('en', 'English'), 
('fr', 'French'), 
('es', 'Spanish');

INSERT INTO Translations (LanguageID, OriginalText, TranslatedText) VALUES
((SELECT LanguageID FROM Languages WHERE LanguageCode = 'fr'), 'Welcome to our website!', 'Bienvenue sur notre site web!'),
((SELECT LanguageID FROM Languages WHERE LanguageCode = 'es'), 'Welcome to our website!', '¡Bienvenido a nuestro sitio web!');

