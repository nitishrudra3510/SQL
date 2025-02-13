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
WHERE (star, director, gross) IN (SELECT * FROM top_dir_actor)
