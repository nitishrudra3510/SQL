-- # cross join - casmetic join(user and groups)

SELECT * FROM sql_cx_live.users t1
CROSS JOIN sql_cx_live.groups t2;

-- inner join with membership and users
SELECT * FROM sql_cx_live.membership t3
INNER JOIN sql_cx_live.users1 t4

-- # combined the user_id of users table and user_id of membership tables

ON t3.user_id = t4.user_id;


-- # left join 
SELECT * FROM sql_cx_live.membership t3
LEFT JOIN sql_cx_live.users1 t4

-- combined the user_id of users table and user_id of membership tables
ON t3.user_id = t4.user_id;


-- right join 
SELECT * FROM sql_cx_live.membership t3
right JOIN sql_cx_live.users1 t4

-- # combined the user_id of users table and user_id of membership tables

ON t3.user_id = t4.user_id;

-- ## FULL JOIN
SELECT * FROM sql_cx_live.membership t3
LEFT JOIN sql_cx_live.users1 t4
ON t3.user_id = t4.user_id

union

SELECT * FROM sql_cx_live.membership t3
RIGHT JOIN sql_cx_live.users1 t4
ON t3.user_id = t4.user_id;


-- # set operators..
-- 1. UNION
SELECT * FROM sql_cx_live.person1
UNION
SELECT * FROM sql_cx_live.person1;

-- 2. UNION ALL
SELECT * FROM sql_cx_live.person1
UNION ALL
SELECT * FROM sql_cx_live.person1;

-- INTERSET

-- SELECT * FROM sql_cx_live.person1
-- INTERSECT
-- SELECT * FROM sql_cx_live.person1;

-- -- EXCEPT
-- SELECT * FROM sql_cx_live.person1
-- EXCEPT
-- SELECT * FROM sql_cx_live.person1;


-- ## self join (a joined a table with itself)

SELECT * FROM sql_cx_live.users1 t1
JOIN sql_cx_live.users1 t2
ON t1.emergency_contact = t2.user_id;



-- # joining more than one columns..

SELECT * FROM sql_cx_live.students t1
JOIN sql_cx_live.class t2
ON t1.class_id = t2.class_id
AND t1.enrollment_year = t2.class_year;


-- ## joining more than one tables
SELECT * FROM sql_cx_live.order_details t1
JOIN sql_cx_live.orders t2
ON t1.order_id = t2.order_id -- join  on the basis of order id

JOIN sql_cx_live.users t3 -- add the third table
ON t2.user_id = t3.user_id;

-- filtering the columns
SELECT t1.order_id, t1.amount, t1.profit, t3.name FROM sql_cx_live.order_details t1
JOIN sql_cx_live.orders t2
ON t1.order_id = t2.order_id 

JOIN sql_cx_live.users t3 
ON t2.user_id = t3.user_id;


-- find the order_id, name and city by joining users and orders..

SELECT t1.order_id, t2.name, t2.city 
FROM sql_cx_live.orders t1
JOIN sql_cx_live.users t2
ON t1.user_id = t2.user_id
;

-- find order_id, product category by joining order_details and category

SELECT t1.order_id, t2.category FROM sql_cx_live.order_details t1 
Join sql_cx_live.category t2
ON t1.category_id = t2.category_id;

-- find the order from the pune
SELECT * FROM sql_cx_live.orders t1
JOIN sql_cx_live.users t2
ON t1.user_id = t2.user_id
WHERE t2.city = 'Pune' AND t2.name = 'Sarita';

-- find all orders under chairs category..
SELECT * FROM sql_cx_live.category;

-- find all profitable orders
SELECT t1.order_id, SUM(t2.profit) FROM sql_cx_live.orders t1
JOIN sql_cx_live.order_details t2
ON t1.order_id = t2.order_id
GROUP BY t1.order_id
HAVING SUM(t2.profit) > 0;

-- find the cusotmer who has placed max number of orders
SELECT name, COUNT(*) AS 'num_orders' FROM sql_cx_live.orders t1
JOIN sql_cx_live.users t2
ON t1.user_id = t2.user_id
GROUP BY t2.name
ORDER BY num_orders DESC LIMIT 1;

-- which is the most profitable category..
SELECT t2.vertical, SUM(profit) AS 'profit_category' from sql_cx_live.order_details t1
JOIN sql_cx_live.category t2
ON t1.category_id = t2.category_id
GROUP BY t2.vertical
ORDER BY profit_category DESC LIMIT 1;


-- which is the most profitable state..
SELECT state, SUM(profit) AS 'profit_state' FROM sql_cx_live.orders t1
JOIN sql_cx_live.order_details t2
ON t1.order_id = t2.order_id
JOIN sql_cx_live.users t3
ON t1.user_id = t3.user_id
GROUP BY state
ORDER BY profit_state DESC LIMIT 1;

-- find all the category with profit higher than 5000
SELECT t2.vertical, SUM(profit) FROM sql_cx_live.order_details t1
JOIN sql_cx_live.category t2
ON t1.category_id = t2.category_id
GROUP BY t2.vertical
HAVING SUM(profit) > 3000