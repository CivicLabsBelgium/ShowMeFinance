## Don't know how to write comments
## To create the smf, showmefinance, database
## Be sure to put the semicolon at the end
CREATE DATABASE smf ; 
CREATE TABLE country (ISO CHAR(2) NOT NULL,
                      countryName VARCHAR(40) NOT NULL,
                      PRIMARY KEY (ISO)
                      );