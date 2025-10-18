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


SELECT AVG(marks) FROM campusx.marks;


# windows fucntions : it is basically a analtical fucntion, it performs aggregate functions work on group;

SELECT *, AVG(marks) OVER() FROM campusx.marks; # for all rows

SELECT *, AVG(marks) OVER(partition by branch) FROM campusx.marks; # for branch columns

SELECT *,
AVG(marks) OVER(),
MIN(marks) OVER(),
MAX(marks) OVER(),
MIN(marks) OVER(PARTITION BY branch),
MAX(marks) OVER(PARTITION BY branch)
FROM campusx.marks
ORDER BY student_id;


# display those student has greater than marks of avg of total marks

SELECT * FROM (SELECT *, AVG(marks) OVER(PARTITION BY branch) AS 'branch_avg' FROM marks) t
WHERE t.marks > t.branch_avg;


# RANK/DENSE_RANK/_ROW_NUMBER

# RANK : partiton me rank deta hai... in every group me khud ka rank deta hai... jaise har group me rank 1 se start hoga...
# for over all data

SELECT *,
RANK() OVER(ORDER BY marks DESC)
from marks;

# for branch ke basis pe

SELECT *,
RANK() OVER(partition BY branch ORDER BY marks DESC)
from marks;

# dense_rank : it difference od rank only is it start rank is 1 and 1 then 3 but in the dense rank is 1, 1 then 2;
SELECT *,
RANK() OVER(partition BY branch ORDER BY marks DESC),
DENSE_RANK() OVER(partition BY branch ORDER BY marks DESC)
from marks;

# row_number : EVERY DATA IS GETTING A ROW NUMBER...
SELECT *,
concat(branch, '-',row_number() OVER(PARTITION BY branch))
FROM marks;

use zomato;


SELECT 
    MONTHNAME(date) AS month_name,
    user_id,
    total_amount,
    RANK() OVER (PARTITION BY MONTHNAME(date) ORDER BY total_amount DESC) AS rank_in_month
FROM (
    SELECT 
        MONTHNAME(date) AS month_name,
        MONTH(date) AS month_num,
        user_id,
        SUM(amount) AS total_amount
    FROM orders
    GROUP BY MONTHNAME(date), MONTH(date), user_id
) AS sub
ORDER BY month_num, rank_in_month;


# THIS IS THE 


