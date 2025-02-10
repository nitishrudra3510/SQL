select * from crime;
select * from department; 


-- create databzse

CREATE database campusx;

-- drop the database
DROP DATABASE campusx;

-- better to way to create database..
CREATE DATABASE IF NOT EXISTS campusx;

-- BETTER WAY TO DROP THE DATABSE..
DROP DATABASE IF EXISTS campusx;


--
CREATE DATABASE IF NOT EXISTS campusx;

-- CREATE A TABLE
USE campusx;
CREATE TABLE users(
	col_id INTEGER,
    name VARCHAR(255),
    email varchar(255),
    password varchar(255)
)



-- EMPTY THE TABLE
-- TRUNCATE TABLE users;

-- drop the table 
-- drop table if exists users;


-- create table  : use not null
-- USE campusx;
-- CREATE TABLE users(
-- 	user_id INTEGER NOT NULL,
--     name VARCHAR(255) NOT NULL,
--     email varchar(255),
--     password varchar(255)
-- )

-- use not null & unique
/*
CREATE TABLE users(
	user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email varchar(255) NOT NULL unique,
    password varchar(255) NOT NULL
    
    -- this is the secondd way to create constraints..
    -- constraint users_email_unique UNIQUE (email, name, password)
)
*/



-- primary key
USE campusx;
-- CREATE TABLE users(
-- 	user_id INTEGER NOT NULL,
--     name VARCHAR(255) NOT NULL,
--     email varchar(255) NOT NULL,
--     password varchar(255) NOT NULL,
--     
--     -- this is the secondd way to create constraints..
--     -- constraint users_email_unique UNIQUE (user_id, name),
--     constraint users_email_unique PRIMARY KEY (user_id, name)
-- )

CREATE TABLE users(
	user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email varchar(255) NOT NULL UNIQUE,
    password varchar(255) NOT NULL
    
)


