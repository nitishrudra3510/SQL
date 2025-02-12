## Freedom Ranking for Different Countries
/*
You can get the dataset from [here](https://drive.google.com/drive/folders/1wr0J571rlfexEJ4-de6_tz1QvU-cJ0df?usp=share_link).

Some feature details of the dataset:

| Feature | Description |
| :--: | :-- |
| A | Electoral Process |
| B | Political Pluralism and Participation |
| C | Functioning of Government |
| D | Freedom of Expression and Belief |
| E | Associational and Organizational Rights |
| F | Rule of Law |
| G | Personal Autonomy and Individual Rights |
| CL | Civil Liberties Scores |
| Status | F=Free, PF=Partly Free, NF=Not Free |
*/

###`Q-1` Find out top 10 countries' which have maximum A and D values.
SELECT t1.Country, A, D
FROM mydatabase.country_ab t1
JOIN mydatabase.country_cd t2
ON t1.Country = t2.Country
ORDER BY A DESC, D DESC
LIMIT 10;

###`Q-2` Find out highest CL value for 2020 for every region. Also sort the result in descending order. Also display the CL values in descending order.

SELECT Country, MAX(CL) AS MAX_value
FROM mydatabase.country_cl
WHERE Edition = '2020'
GROUP BY Country
ORDER BY MAX_value DESC;


## Dataset
-- Data Link-> https://drive.google.com/drive/folders/1bGgNTDy5L_IodNcGHdB_SNCkUI5MUjmY?usp=share_link
-- Four Tables:
-- * Customer
-- * Employee
-- * Sales
-- * Products

###`Q-3` Find top-5 most sold products.
SELECT Name, SUM(t1.Quantity) AS 'Total_Quantity' 
FROM mydatabase.sales1 t1
JOIN mydatabase.products t2
ON t1.ProductID = t2.ProductID
GROUP BY t1.ProductID, t2.Name
ORDER BY Total_Quantity DESC
LIMIT 5;


### `Q-4:` Find sales man who sold most no of products.
SELECT t1.SalesPersonID, t2.FirstName, t2.LastName, 
SUM(t1.Quantity) AS No_Of_Products_Sold 
FROM mydatabase.sales1 t1
JOIN mydatabase.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID, t2.FirstName, t2.LastName
ORDER BY No_Of_Products_Sold DESC
LIMIT 10;

### `Q-5:` Sales man name who has most no of unique customer.
SELECT t1.SalesPersonID, t2.FirstName, t2.LastName, 
COUNT(DISTINCT customers) AS 'Unique_customers'
FROM mydatabase.sales1 t1
JOIN mydatabase.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID, t2.FirstName, t2.LastName
ORDER BY Unique_customers DESC;


###`Q-6:` Sales man who has generated most revenue. Show top 5.
SELECT t1.SalesPersonID, t3.FirstName, t3.LastName, 
SUM(t1.Quantity * t2.Price) AS Total_Revenue
FROM mydatabase.sales1 t1
JOIN mydatabase.products t2 ON t1.ProductID = t2.ProductID
JOIN mydatabase.employees t3 ON t1.SalesPersonID = t3.EmployeeID
GROUP BY t1.SalesPersonID, t3.FirstName, t3.LastName
ORDER BY Total_Revenue DESC
LIMIT 5;

###`Q-7:` List all customers who have made more than 10 purchases.
SELECT t1.SalesPersonID, t2.FirstName, t2.LastName, COUNT(*)  FROM mydatabase.sales1 t1
JOIN coutomers t2
On t1.coustomerID = t2.cusotmerID
GROUP BY t1.CusotmerID
having COUNT(*) > 10;


### `Q-8` : List all salespeople who have made sales to more than 5 customers.
SELECT t1.SalesPersonID, t2.FirstName, t2.LastName, 
COUNT(DISTINCT t1.CustomerID) AS Unique_Customers
FROM mydatabase.sales1 t1
JOIN mydatabase.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID, t2.FirstName, t2.LastName
HAVING Unique_Customers > 5;


### Q-9: List all pairs of customers who have made purchases with the same salesperson.
 SELECT t1.CustomersID AS Customer1, t2.CustomersID AS Customer2, t1.SalesPersonID
FROM mydatabase.sales1 t1
JOIN mydatabase.sales1 t2
ON t1.SalesPersonID = t2.SalesPersonID
AND t1.CustomersID < t2.CustomersID;
