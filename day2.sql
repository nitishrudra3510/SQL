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
-- execution order by FROM JOIN WHERE GROUP BY HAVING SELECT DISTICT ORDER BY 
-- (FJWGHSDO)

-- FIND THE brands who sell phones with price > 50000

SELECT DISTINCT(brand_name) FROM campusx.smartphones where price > 100000;	

-- IN and NOT IN

select * from campusx.smartphones
where processor_brand = 'snapdragon' OR
processor_brand = 'exynos' OR
processor_brand = 'bionic';

-- easy way 
select * from campusx.smartphones
where processor_brand IN ('snapdragon', 'exynos', 'bionic');

select * from campusx.smartphones
where processor_brand NOT IN ('snapdragon', 'exynos', 'bionic');



# UPDATE : update karna in the row..
select * from campusx.smartphones
where processor_brand = 'mediatek';

--  mediatek ke jagah pr dimensity
UPDATE campusx.smartphones
SET processor_brand = 'dimensity'
where processor_brand = 'mediatek';


-- @gmail.com ke jagah pr @yahoo.com..
UPDATE campusx.users
SET email = 'swayam@yahoo.com'
where name = 'swayam';

-- DELETE THOSE ROWS WHOSE PRICE GREATER THAN 200000
DELETE FROM campusx.smartphones
where price > 200000;

-- Here will be show error.
SELECT * FROM campusx.smartphones
where price > 200000;

-- battery > 70000
SELECT * FROM campusx.smartphones
where primary_camera_rear > 150;

-- delete primary_camera_rear > 150 with samsuung
delete FROM campusx.smartphones
where primary_camera_rear > 150 and brand_name='samsung';

Select * FROM campusx.smartphones
where primary_camera_rear > 150 and brand_name='samsung';
			
-- ## FUNCTIONS : 

-- find max values in the price 

select MAX(price) FROM campusx.smartphones;

-- min
select MIN(price) FROM campusx.smartphones;


-- find the price of the costlist samsung phone..
SELECT * FROM campusx.smartphones
where brand_name = "samsung" AND price = "110999";

-- AVG : 
SELECT AVG(rating) FROM campusx.smartphones
WHERE brand_name = 'apple';

-- SUM : 
select sum(price) from campusx.smartphones;


-- count : apple ka phone kitna hai..
select COUNT(*) from campusx.smartphones
WHERE brand_name = 'apple';

-- Distinct(count) : NO OF BRAND_NAME

SELECT count(DISTINCT(brand_name)) from campusx.smartphones;

-- STD 

select STD(screen_size) from campusx.smartphones;

-- VARIANCE
select variance(screen_size) from campusx.smartphones;


-- # Scaler functions
-- ABS 
SELECT ABS(price - 100000) AS 'temp' FROM campusx.smartphones;

-- ROUND : FIND THE PPI WITH 2 DECIMAL
SELECT model, 
ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size, 2) AS 'PPI'
FROM campusx.smartphones;


-- CEILING 
-- 4.1 -> 5
-- 5.9 -> 6

-- FLOOR -
-- 5.5 - 4
-- 6.9 - 6

select ceil(screen_size) from campusx.smartphones;
select FLOOR(screen_size) from campusx.smartphones;


-- ** Find the average battery capacity and the average primary rear camera resolution for all smartphones with a price greater than or equal to 100000
SELECT AVG(battery_capacity) AS 'AVG battery_capacity' , AVG(primary_camera_rear) AS 'Avg_primary_camera_rear' FROM campusx.smartphones
where price >= 100000;

SELECT * FROM campusx.smartphones;
-- find the number of smartphoens with 5g capability..
SELECT count(brand_name) FROM campusx.smartphones where has_5g='True';

-- ** Find the average internal memory capacity of smartphones that have a refresh rate of 120 Hz or higher and a front-facing camera
-- resolution greater than or equal to 20 megapixels.
-- resolution greater than or equal to 20 megapixels.
SELECT AVG(internal_memory) 
FROM campusx.smartphone 
WHERE refresh_rate >= 120 
AND front_camera_resolution >= 20;