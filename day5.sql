## SUB-query 

-- find the movies with height rating
SELECT * FROM demo.movies
WHERE score = (SELECT MAX(score) from demo.movies);


 ## Independent Subquery - Scalar Subquery

-- 1. Find the movie with highest profit(vs order by)
SELECT * FROM demo.movies
Where (gross - budget) = (SELECT MAX(gross - budget) from demo.movies);


-- Find how many movies have a rating > the avg of all the movie ratings(Find the count of above average movies) A
use sql_cx_live;
SELECT COUNT(*) FROM  movies
where score  > (SELECT AVG(score) FROM movies);

-- 3. Find the highest rated movie of 2000
SELECt * FROM movies
 where year = '2020' AND score = (select MAx(score) from movies where year = '2020');
  

-- 4. Find the highest rated movie among all movies whose number of votes are >
-- the dataset avg votes

SELECT * from movies
where score = (
SELECT Max(score) FROM movies
where votes >  (SELECT AVG(votes) FROM movies));


## Independent Subquery - Row SubqueryOne Col Multi Rows)
use zomato;

-- 1. Find all users who never ordered
SELEct * from users
WHERE user_id NOT IN (SELECT distinct(user_id)
							FROM orders);

-- 2. Find all the movies made by top 3 directors(in terms of total gross income)
SELECT * FROM sql_cx_live.movies
WHERE director IN (SELECT director
					FROM sql_cx_live.movies
					GROUP BY director
					ORDER BY SUM(gross) DESC LIMIT 3);

WITH top_directors AS (
    SELECT director
    FROM sql_cx_live.movies
    GROUP BY director
    ORDER BY SUM(gross) DESC
    LIMIT 3
)
SELECT * FROM sql_cx_live.movies
WHERE director IN (SELECT * FROM top_directors);


-- 3. Find all movies of all those actors whose filmography's avg rating > 8.5(take
-- 25000 votes as cutoff)

SELECT * FROM movies
WHERE star in (SELECT star from movies
			WHERE votes > 25000
			GROUP BY star
			HAving AVG(score)>8.5)
;
            
## Independent Subquery - Table SubqueryfMulti Col Multi Row)

-- 1. Find the most profitable movie of each year
SELECT * FROM movies
where (year, gross-budget) IN (SELECT year, MAX(gross - budget) from movies
GROUP by year);

-- 2. Find the highest rated movie of each genre votes cutoff of 25000
SELECT * FROM movies
Where (genre, score) IN (SELECT genre, MAx(score) from movies
					WHERE votes > 25000
					Group By genre);
				
-- 3. Find the highest grossing movies of top 5 actor/director combo in terms of
-- total gross income
with top_dir_actor AS (
	select star, director, MAX(gross)
	FROM movies
	GROUP BY star, director
	ORDER BY sum(gross) DESC LIMIT 5
)

SELECT * FROM movies 
WHERE (star, director, gross) IN (SELECT * FROM top_dir_actor);


### (Correlated Subquery : under wala query bahar wale query pe depend karta hai..
use sql_cx_live;
-- 1. Find all the movies that have a rating higher than the average rating of movies
-- in the same genre. [Animation]
SELECT * FROM movies;

SELECT * FROM movies m1
WHERE score > (SELECT AVG(score) FROM movies m2 WHERE m2.genre = m1.genre)
;

-- 2. Find the favorite food of each

use zomato;
WITH fav_food AS (
    SELECT t2.user_id, 
           t1.name, 
           t4.f_name, 
           COUNT(*) AS frequency
    FROM users t1
    JOIN orders t2 ON t1.user_id = t2.user_id
    JOIN order_details t3 ON t2.order_id = t3.order_id
    JOIN food t4 ON t3.f_id = t4.f_id
    GROUP BY t2.user_id, t1.name, t4.f_name
)

SELECT user_id, name, f_name AS favorite_food, frequency
FROM fav_food
WHERE frequency = (
    SELECT MAX(frequency) FROM fav_food f2 WHERE f2.user_id = fav_food.user_id
);


## Usage with SELECT

-- 1. Get the percentage of votes for each movie compared to the total number of votes.
use sql_cx_live;
select name, (votes/(select sum(votes) from movies))*100 from movies;

-- 2. Display all movie names ,genre, score and avg(score) of genre
SELECT name, genre,score, (select avg(score) from movies m2 where m2.genre = m1.genre) from movies m1
;


-- ## using in the from

-- display average rating od all the restaurants  
SELECT r_name, avg_rating
FROM (
SELECT r_id, avg(restaurant_rating) AS 'avg_rating'
	from orders
    GROUP BY r_id) t1 
    JOIN restaurants t2 
    ON t1.r_id = t2.r_id
;
## usage with having

-- 1. find genres having avg score > avg score of all the movies
use sql_cx_live;
SELECT genre, AVG(score)
from movies
group by genre

having avg(score) > (SELECT AVG(score) from movies)
;


## Subquery In INSERT

-- Populate a already created loyal_customers table with records of only those
-- customers who have ordered food more than 3 times.

-- Populate a already created loyal_customers table with records of only those
-- customers who have ordered food more than 3 times.

-- Populate a already created loyal_customers table with records of only those
-- customers who have ordered food more than 3 times.

SELECT * FROM zomato.loyal_user;
use zomato;

INSERT INTO loyal_user (user_id, name)
SELECT t1.user_id, t2.name 
FROM orders t1
JOIN users t2 ON t1.user_id = t2.user_id
GROUP BY t1.user_id, t2.name
HAVING COUNT(*) > 3;


## Subquery in UPDATE

-- Populate the money col of loyal _cutomer table using the orders table.
--  Provide a 10% app money to all customers based on their order value.
use zomato;

UPDATE loyal_user lc
JOIN (
    SELECT user_id, SUM(amount) * 0.1 AS BONUS_MONEY
    FROM orders
    GROUP BY user_id
) t1 ON lc.user_id = t1.user_id
SET lc.money = t1.BONUS_MONEY;

SELECT * FROM loyal_user; 


## Subquery in DELETE

-- Delete all the customers record who have never ordered
-- SELECT * from users;
-- DELETE FROM users
-- WHERE user_id IN (SELECT user_id FROM users
-- WHERE user_id NOT IN (SELECT DISTINCT(user_id) FROM orders))


DELETE FROM zomato.users u
WHERE NOT EXISTS (
    SELECT 1 FROM zomato.orders o 
    WHERE u.user_id = o.user_id
);

SELECT user_id FROM users;

