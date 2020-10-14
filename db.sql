-- Don't know how to write comments
-- To create the smf, showmefinance, database
-- Be sure to put the semicolon at the end
-- CREATE DATABASE smf ;
-- CREATE TABLE country (ISO CHARACTER VARYING(8) NOT NULL,
--                       countryName CHARACTER VARYING(64) NOT NULL,
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
-- to remove a TABLE
-- drop table country
--
-- to load the content of a csv file into, here, the country table
-- copy country (iso, countryname) from '/Users/jmfalisse/Documents/Professionnel/
-- Projets/ShowMeFinance/countrylist/data/country-iso-countryname.csv'
-- with (format csv);
