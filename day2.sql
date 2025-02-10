CREATE TABLE users(
	user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- INSERT THE DATA

INSERT INTO campusx.users(user_id, name, email, password) VALUES (NULL, 'ankie', 'ankit@gmail.com', '12345');

-- for some columns

INSERT INTO campusx.users (name, email, password) VALUES ('swayam', 'swayam@gmail.com', 'd_f');

-- INSERT INTO campusx.users (name, password) VALUES ('ankit', '384567') : it give the error because email value has not provides -> not null hai table me


-- insert multiple row at a time

INSERT INTO campusx.users VALUES
(NULL, 'RISHAB', 'rishababhi@gmail.com', '1234'),
(NULL, 'NITISH', 'nitishb@gmail.com', '21341'),
(NULL, 'SRIKANT', 'rohan@gmail.com', '234324');


-- import the datasets--
-- smartphone_cleaned_datasets..

-- select all the rows and columns

SELECT * FROM campusx.smartphones where 1;

# filter the columns

SELECT price, rating, has_5g FROM campusx.smartphones;

SELECT model, battery_capacity, os FROM campusx.smartphones;

-- alias -> rename the column

SELECT os AS 'operating System', model, battery_capacity AS 'Mah' FROM campusx.smartphones;


-- creating expression in cols..
-- calcuate PPI and model 
SELECT model, resolution_width*resolution_width FROM campusx.smartphones;
SELECT model, resolution_width*resolution_width + resolution_height*resolution_height FROM campusx.smartphones;

SELECT model, 
SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size AS 'PPI'
FROM campusx.smartphones
;

SELECT model, rating/10 FROM campusx.smartphones;

-- constants : add the columns with constant value 
SELECT model, 'Smartphones' AS 'type' FROM campusx.smartphones;


-- Distinct(unique) values from a col.. : ye asabhi brand ka name de dega or repeat nahi karega.. kisi ko
SELECT DISTINCT(brand_name) AS 'ALL Brand' FROM campusx.smartphones;

SELECT DISTINCT(processor_brand) AS 'ALL processor' FROM campusx.smartphones;

SELECT DISTINCT(os) AS 'ALL processor' FROM campusx.smartphones;


-- unique combitions : processor + brand
SELECT DISTINCT brand_name, processor_brand FROM campusx.smartphones;

-- filtering rows where clause..

-- find aal samsung phoen
select * from campusx.smartphones
WHERE brand_name = 'samsung';


-- find all phones with price > 5000

select * from campusx.smartphones where price > 100000;


-- BETWEEN 
-- find all phones int he price range of 10000 to 200000

-- select * from campusx.smartphones where price > 10000 AND price < 20000
select * from campusx.smartphones where price BETWEEN 10000 AND 20000;


-- FIND THe phoens with rating > 80 and price < 25000;

SELECT * FROM campusx.smartphones where rating > 80 and price < 25000;

SELECT * FROM campusx.smartphones where rating > 80 and price < 25000 AND processor_brand='snapdragon';

-- find all sampsung phones with ram > 8 GB

SELECT * FROM campusx.smartphones where brand_name='samsung' AND ram_capacity > 8;


-- find the all samsung phoens and snapdragon processor

SELECT * FROM campusx.smartphones where brand_name='samsung' AND processor_brand = 'snapdragon';

-- # QUery Execution Orders : infytq.onwingspan.com/ websites name 
