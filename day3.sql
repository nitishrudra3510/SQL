-- sorting the data

-- 1. find the top samsung phone top 5 USE (ORDER BY )
SELECT model, screen_size FROM campusx.smartphones where brand_name = "samsung"
ORDER BY screen_size DESC LIMIT 5;

-- SORT OF ALL THE PHONES in descending order number of total cameras..
SELECT model,  num_rear_cameras AS 'Total_cameraS' 
FROM campusx.smartphones
ORDER BY Total_cameraS desc;

-- sort the data on the basis of ppi in the desending orders..
SELECT model, 
ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size, 2) AS 'PPI'
FROM campusx.smartphones 
order by PPI ASC;

-- FIND THE PHONE WITH 2ND LARGEST BATTERY..
SELECT model, battery_capacity FROM campusx.smartphones 
ORDER BY battery_capacity DESC limit 1,1; -- 

SELECT model, battery_capacity FROM campusx.smartphones 
ORDER BY battery_capacity DESC limit 1;

SELECT model, battery_capacity FROM campusx.smartphones 
ORDER BY battery_capacity DESC limit 3,2; -- it represnets the x,y x means here(0-2 print nahi karega uske badh) 2(3,4) print karega only

SELECT model, battery_capacity FROM campusx.smartphones 
ORDER BY battery_capacity DESC limit 5,5; 


-- find the name and rating with of the worst rated apple phone..

SELECT model, rating from campusx.smartphones where brand_name = 'apple'
order by rating asc limit 1;

SELECT model, rating
FROM campusx.smartphones
where brand_name = 'apple'
ORDER BY rating ASC LIMIT 1 ;

-- SORT PHONES  alphabetically and then on the basics of rating in des order..
SELECT * FROM campusx.smartphones
ORDER BY brand_name ASC, rating DESC;

-- SORT PHONES  alphabetically and then on the basics of price as asc order..
SELECT * FROM campusx.smartphones
ORDER BY brand_name ASC, price ASC;


select * from campusx.smartphones order by brand_name ASC, price ASC;
;
-- # GROUPING DATA

-- 1. Group smartphones by brand and get the count, average price, max rating, avg screen size and avg battery capacity
SELECT brand_name, COUNT(*) AS 'num_phones', -- count the number of rows
ROUND(AVG(price), 2) AS 'AVG price',
MAX(rating) AS 'MAX Rating',
ROund(AVG(screen_size),2) AS 'Avg Screen Size',
ROUND(avg(battery_capacity), 2) AS'AVG BATTERY CAPACITY'
FROM campusx.smartphones
group by brand_name
ORDER BY num_phones DESC LIMIT 15;

-- group by animation
-- 2. Group smartphones by whether they have an NFC and get the average price and rating
SELECT has_nfc, AVG(price) AS 'Avg price',
AVG(rating) AS 'Avg Rating'
FROM campusx.smartphones
GROUP BY has_nfc;

SELECT has_5g, AVG(price) AS 'Avg price',
AVG(rating) AS 'Avg Rating'
FROM campusx.smartphones
GROUP BY has_5g;

-- fast charging available...

SELECT fast_charging_available, AVG(price) AS 'Avg price',
AVG(rating) AS 'Avg Rating'
FROM campusx.smartphones
GROUP BY fast_charging_available;


-- 3. Group smartphones by the extended memory available and get the average price
SELECT extended_memory_available, AVG(price)
FROM campusx.smartphones
GROUP BY extended_memory_available;

-- 4. Group smartphones by the brand and processor brand and get the count of models and the average primary camera resolution (rear)
SELECT brand_name, 
processor_brand,
COUNT(*) AS 'nums phones',
ROUND(AVG(primary_camera_rear),2) AS 'avg camera resolution'
FROM campusx.smartphones
GROUP BY brand_name, processor_brand; 

-- 5. find top 5 most costly phone brands

select brand_name, avg(price) AS 'avg_price'
from campusx.smartphones
GROUP BY brand_name
ORDER BY avg_price DESC LIMIT 5
;

SELECT brand_name, AVG(price) AS 'Avg_Price'
FROM campusx.smartphones
Group BY brand_name
ORDER BY Avg_Price DESC LIMIT 5;


-- 6. which brand makes the smallest screen smartphones
SELECT brand_name, AVG(screen_size) AS 'Avg_Sreec_Size'
FROM campusx.smartphones
Group BY brand_name
ORDER BY Avg_Sreec_Size asc LIMIT 1;

SELECT brand_name, AVG(screen_size) AS 'Avg_Sreec_Size'
FROM campusx.smartphones
Group BY brand_name
ORDER BY Avg_Sreec_Size asc LIMIT 1;
;

-- 7. Avg price of 5g phones vs avg price of non 5g phones
SELECT has_5g, AVG(price)
FROM campusx.smartphones
GROUP BY has_5g;

-- 8. Group smartphones by the brand, and find the brand with the highest number of models that have both NFC and an IR blaster
-- SELECT brand_name, COUNT(*) AS 'num phones'
-- FROM campusx.smartphones
-- WHERE has_nfc = 'True' AND has_ir_blaster = 'TRUE'
-- GROUP BY brand_name
-- ORDER BY count DESC LIMIT 1;


SELECT brand_name, COUNT(*) AS num_phones
FROM campusx.smartphones
WHERE LOWER(has_nfc) = 'true' AND LOWER(has_ir_blaster) = 'true'
GROUP BY brand_name
ORDER BY num_phones DESC LIMIT 1;


-- 9. Find all samsung 5g enabled smartphones and find out the avg price for NFC and Non-NFC phones
SELECT has_nfc, AVG(price) AS 'avg_price'
FROM campusx.smartphones
WHERE brand_name = 'samsung'
Group  BY has_nfc;


-- 10. find the phone name, price of the costliest phone
  
Select brand_name, price from campusx.smartphones
ORDER BY price DESC LIMIT 1;

-- count no of rows
SELECT COUNT(*) FROM campusx.smartphones;
SELECT COUNT(*) FROM campusx.ipl;


-- ## Having clause -> filtering your groupby
-- select - where
-- groupby -- having

-- avg price on at least 20 model of the brands..

SELECT brand_name,
COUNT(*) AS 'count', AVG(price) AS 'Avg_Price'
FROM campusx.smartphones
GROUP BY brand_name
HAVING count > 45 -- count of phones > 45 wo avg value show karega only..and
ORDER BY Avg_Price DESC;


-- 1. find the avg rating of smartphone brands which have more than 20 phones
SELECT brand_name,COUNT(*) AS 'Count',
ROUND(AVG(rating), 2 ) AS 'Avg_Rating'
FROM campusx.smartphones
GROUP BY brand_name
Having Count > 20
ORDER BY Avg_Rating DESC;

SELECT * FROM campusx.smartphones;
-- 2. Find the top 3 brands with the highest avg ram that have a refresh rate of at least 90 Hz and fast charging available and dont consider brands which have less than 10 phones
SELECT brand_name, ROUND(AVG(ram_capacity),2) AS 'Avg_RAM'
FROM campusx.smartphones
WHERE refresh_rate > 90 AND fast_charging_available = 1
GROUP BY brand_name
HAving COUNT(*) > 10
ORDER BY Avg_RAM DESC LIMIT 3;


-- 3. find the avg price of all the phone brands with avg rating › 70 and num phones more than 10 among all 5g enabled phones
SELECT brand_name, AVG(rating) AS 'Avg_rating', AVG(price) AS 'Avg_price'
FROM campusx.smartphones 
WHERE has_5g = 'True'
Group BY brand_name
Having AVG(rating) > 70 AND COUNT(*) > 10;



-- ***
-- Practice
-- - find the top 5 batsman in IPL
SELECT * FROM campusx.ipl;
SELECT batter, SUM(batsman_run) AS 'runs'
FROM campusx.ipl
GROUP BY batter
ORDER BY runs DESC LIMIT 5;


-- - find the 2nd highest 6 hitter in IPL
SELECT batter, COUNT(*) AS 'num_sixes'
FROM campusx.ipl
WHERE batsman_run = '6'
GROUP BY batter
order by num_sixes DESC LIMIT 1,1;


-- - Find Virat Kohli's performance against all IPL teams[input not available]
SELECT * FROM campusx.ipl
Where batter = 'V Kohli'
group by boll;

-- - Find top 10 batsman with centuries in IPL
SELECT batter, ID, SUM(batsman_run) AS 'Scores'  from campusx.ipl
GROUP BY batter, ID
Having Scores >= 100
ORDER BY batter DESC;

-- - find the top 5 batsman with highest strike rate who have played a min of 1000 balls
SELECT batter, SUM(batsman_run) AS 'Scores', COUNT(batsman_run) AS 'count',
(SUM(batsman_run)/Count(batsman_run))*100 AS 'SR'
from campusx.ipl
group by batter
HAving count > 1000
ORDER BY SR DESC LIMIT 5
