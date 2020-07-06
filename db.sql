-- Don't know how to write comments
-- To create the smf, showmefinance, database
-- Be sure to put the semicolon at the end
-- CREATE DATABASE smf ;
-- CREATE TABLE country (ISO CHAR(2) NOT NULL,
--                       countryName VARCHAR(40) NOT NULL,
--                       PRIMARY KEY (ISO)
--                       );
CREATE TABLE authority (
  authId INT UNIQUE NOT NULL,
  authShort CHAR(8),
  authLong VARCHAR(45),
  authBegin DATETIME,
  authEnd DATETIME,
  authExperimental BOOLEAN,
  PRIMARY KEY(authId)
  );
CREATE TABLE countryauthorityrelation(
  countryISO CHAR(2) NOT NULL,
  authId INT NOT NULL
);
