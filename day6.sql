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