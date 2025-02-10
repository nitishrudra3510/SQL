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
);



-- EMPTY THE TABLE
-- TRUNCATE TABLE users;

-- drop the table 
drop table if exists users;


create table  : use not null
USE campusx;
CREATE TABLE users(
	user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email varchar(255),
    password varchar(255)
);

-- use not null & unique

CREATE TABLE users(
	user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email varchar(255) NOT NULL unique,
    password varchar(255) NOT NULL
    
    -- this is the secondd way to create constraints..
    -- constraint users_email_unique UNIQUE (email, name, password)
);




-- primary key
-- USE campusx;
CREATE TABLE users(
	user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    
    -- this is the secondd way to create constraints..
    -- constraint users_email_unique UNIQUE (user_id, name),
    constraint users_email_unique PRIMARY KEY (user_id, name)
);


CREATE TABLE users(
	user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email varchar(255) NOT NULL UNIQUE,
    password varchar(255) NOT NULL
    
);



-- create table students;

CREATE TABLE student1(
	student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name varchar(50) not null,
    age INTEGER CHECK (age > 6 AND age < 25),
    
    CONSTRAINT students_age_check CHECK (age > 6 AND AGE < 25)
);


-- CREATE table and use default functions;


create table ticket(
	ticket_id INTEGER PRIMARY KEY,
    name varchar(255) NOT NULL,
    travel_data DATETIME DEFAULT CURRENT_TIMEStamp
);



-- create table for foreign key
use campusx;
CREATE TABLE IF NOT EXISTS customers (
    cid INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);


CREATE TABLE orders(
	oid INTEGER PRIMARY KEY AUTO_INCREMENT,
    cid INTEGER NOT NULL,
	order_date DATETIME NOT NULL DEFAULT current_timestamp,
    
    CONSTRAINT ORDER_fg_key FOREIGN KEY (cid) references customers(cid) 
);


-- drop the orders table but it will not drops because it has used foreign key

drop table orders;


-- alter table commands 

ALTER TABLE customers ADD COLUMN password varchar(255) NOT NULL;

-- IF WE WANT TO ADD THE COLUMN BETWEEN NAME AND EMAIL

ALTER TABLE customers ADD COLUMN surname varchar (255) not null AFTER name;

-- add the columns in the last.. of datetime..alter

ALTER TABLE customers
ADD COLUMN pan_number VARCHAR(255) AFTER surname,
ADD COLUMN joining_date DATETIME NOT NULL DEFAULT current_timestamp;


-- DELETE THE COLUMNS 

ALTER TABLE customers DROP COLUMN pan_number;

-- DELETE THE multiple COLUMNS 

ALTER TABLE customers
DROP COLUMN surname,
DROP COLUMN joining_date
;

-- modified the columns
ALTER TABLE customers MODIFY COLUMN password varchar(255) Not null;

-- 
ALTER TABLE customers ADD COLUMN age INTEGER NOT NULL;


-- EXISTING CONSTRAINTS ME DIRECT EDIT NAHI HOTA HAI PAHELE DELETE KARO PHIR ADD KARO
ALTER TABLE customers ADD constraint CUSTOMER_AGE_CHECK CHECK (age > 20);

-- ALTER TABLE customers MODIFY constraint CUSTOMER_AGE_CHECK CHECK (age > 6);

ALTER TABLE customers DROP constraint CUSTOMER_AGE_CHECK CHECK (age > 6)
