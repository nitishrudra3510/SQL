## Window fucntions :  window row wise output deta hai...
## group by me group wise output deta hai..
use campusx;
CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);

## aggregate function with OVER() : means ek windows alag se bna deta hai.. 
-- analytical query run karne le kiye....
-- is used with window functions to perform calculations across a set of rows related to 
-- the current row. It helps with running totals, ranking, and comparing values without collapsing rows.


SELECT *, AVG(marks) OVER() FROM campusx.marks; 

SELECT *, AVG(marks) OVER(PARTITION BY branch) FROM campusx.marks;

SELECT *,
AVG(marks) OVER(),
MIN(marks) OVER(),
MAX(marks) OVER(),
MIN(marks) OVER(PARTITION BY branch),
MAX(marks) OVER(PARTITION BY branch)
FROM campusx.marks
;

## finnd the student whose who have higher thsan avg marks of brach..

SELECT * FROM (SELECT *,
AVG(marks) OVER(PARTITION BY branch) AS BRANCH_AVG
from marks) t
WHERE t.marks > t.BRANCH_AVG ;


## RANK/DENSE_RANK/ROW_NUMBER
-- 1. RANK : PARTITION ME RANKING DETA HAI.. eg : har branch me 4 4 children hai to har partition me konse number pr hai wo deta hai..

SELECT *,
RANK() OVER(ORDER BY marks DESC) -- over all data pr rank dega
from marks;

 
SELECT *,
RANK() OVER(PARTITION BY branch ORDER BY marks DESC) -- branch ke basis pr rank de raha hai
from marks;


## DENSE_RANK : rank me aagr 2 students ka marks same hai. rank do no ka sam rahega or uske rank 3 show akrega direct but in the dense_rank 3 ke jagah pr 2 show karega..

SELECT *,
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC) -- branch ke basis pr rank de raha hai
from marks;


## ROW_NUMBER : pure data me row assign karta hai 

SELECT *, 
ROW_NUMBER() OVER()
from marks;

SELECT *, 
ROW_NUMBER() OVER(PARTITION BY branch) -- branch ke basis pr rows number assign karta hai 
from marks;

-- branch ke sath row number lagana...
SELECT *, 
CONCAT(branch, '-', ROW_NUMBER() OVER(PARTITION BY branch))
from marks;


use zomato;

-- per month ke top 2 customer kon hai jo jyada kharch kiya hai..

SELECT date,MONTH(date), MONTHNAME(DATE) FROM orders;

SELECT *
FROM (
    SELECT 
        MONTHNAME(date) AS month_name,
        MONTH(date) AS month_num,
        user_id,
        SUM(amount) AS total_amount,
        RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY SUM(amount) DESC) AS month_rank
    FROM orders
    GROUP BY MONTHNAME(date), MONTH(date), user_id
) t1
WHERE t1.month_num > 3
ORDER BY t1.month_num ASC, t1.month_rank ASC;


-- FIRST_VALUE/ LAST_VALUE & NTH values

-- first_value
use campusx;
SELECT *,
FIRST_VALUE(name) OVER(ORDER BY marks DESC) from marks ;

-- last_value : ye rule se output deta hai unbounded preceding(1st row) and unbounded floowing (last row)
-- follows the frame rule -> tables -> group -> frame
SELECT *,
LAST_VALUE(marks) OVER(PARTITION BY branch
					ORDER BY marks DESC
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
					from marks ;
                    
                    
-- NTH VAlues..direct posotion nikal sakte hai..
SELECT *,
NTH_VALUE(name, 2) OVER(PARTITION BY branch
					ORDER BY marks DESC
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
					from marks;
                    
                    
-- find the branch toppers 

SELECT name, branch, marks FROM (SELECT *,
FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS tooper_name,
FIRST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC) AS topper_marks
from marks) t1
WHERE t1.name = t1.tooper_name AND t1.marks = t1.topper_marks;

-- LEAD & LAG

-- LAG : hamesha ek row piche chalega original values se... or sabse pahela value null ho jayegi
SELECT *,
LAG(marks)  over(ORDER BY student_id)
from marks;


-- LEAD : hamesha ek row age chalega original values se... or sabse last value null ho jayegi..
SELECT *,
LEAD(marks)  over(ORDER BY student_id)
from marks;

SELECT *,
LEAD(marks)  over(PARTITION BY branch ORDER BY student_id)
from marks;


-- find the month on month revenue growth of zomato...alter

USE zomato;

WITH MonthlyRevenue AS (
    SELECT 
        MONTH(date) AS month_number, 
        MONTHNAME(date) AS month_name, 
        SUM(amount)  AS total_revenue
    FROM orders
    GROUP BY MONTH(date), MONTHNAME(date)
)
SELECT 
    month_name, 
    total_revenue,
    ((total_revenue - LAG(total_revenue) OVER (ORDER BY month_number))/total_revenue)*100 AS mom_growth
FROM MonthlyRevenue
ORDER BY month_number;
