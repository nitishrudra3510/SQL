USE accenture;
CREATE TABLE EmployeeDetails(
EmpId INT PRIMARY KEY,
    FullName VARCHAR(50),
    ManagerId INT,
    DateOfJoining DATE,
    City VARCHAR(50)
);



INSERT INTO EmployeeDetails(EmpId, FullName, ManagerId, DateOfJoining,  City) VALUES (
1, 'Praful Sharma', 100, '2019-01-31', 'Jhansi'
),
(2, 'Manglam Sen', 105, '2023-01-30', 'Kolkata'),
(3, 'Mohit Agarwal', 107, '2022-11-27', 'New Delhi');

INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City)
VALUES (4, 'Ravi Kumar', 108, '2023-03-01', 'Mumbai');



DROP TABLE IF EXISTS EmployeeSalary;
USE accenture;

CREATE TABLE EmployeeSalary (
    EmpId INT,
    Project VARCHAR(10),
    Salary INT,
    Variable INT,
    FOREIGN KEY (EmpId) REFERENCES EmployeeDetails(EmpId)
);
INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable)
VALUES
(1, 'P1', 8000, 400),
(3, 'P2', 7000, 1000),
(4, 'P1', 12000, 0);



# print all records from rthe tables ;

SELECT * FROM EmployeeDetails;

# print details of the employee with employee id is 1;

select * from EmployeeDetails where empid = 1;

# print details of the Employess whose manager id is 100 and their city is jhasi..

select * from EmployeeDetails where managerid = 100 AND city = "Jhansi";


# print all projects avalable in the employeeSalary table;

select Distinct(Project) from EmployeeSalary;


# fetch count of Employees Working in the P1 Project?

SELECT COUNT(*) from EmployeeSalary where project = "P1";


# write an sql to find the maximum, minimum and the avg salary of the employess;

select avg(salary), min(salary), max(salary) from EmployeeSalary; 


# WRITE AN SQL TO FIND the emp id whose salary lies in the range of 9000 and 15000.


SELECT EmpId, Salary from EmployeeSalary 
where salary BETWEEN 9000 AND 15000;

# • Print All Employees Id Who live in Jhansi City or Their Manager Id is 100

select Empid FROM EmployeeDetails where city = "Jhansi" or managerid = 100;


# who work on the prohjects other than p2;

select EmpId from  EmployeeSalary
where NOT Project='P2';

# to fetch all those employees who work on the projects other than p2;

SELECT EmpId FROM EmployeeSalary where Project <> "P2";

# Wite the Sauvite Variay the toral salary of each employee adding the Salary with Variable

SELECT EmpId, Salary+Variable as TotalSalary
From EmployeeSalary;

select * from EmployeeSalary;



# Write an SQL query to display the Names of the Employee Where Second Letter of the Name is a.
 
Select FullName FROM EmployeeDetails Where FullName LIKE '_a%';

#Write an SQL query to fetch all the Emplds which are present in either of the tables - 'EmployeeDetails and EmployeeSalary.

SELECT EmpId FROM EmployeeDetails UNIon 
SELECT EmpId FROM EmployeeSalary;


select EmpId from EmployeeDetails
where EmpId IN 
(SELECT EmpId FROM EmployeeSalary);


# #Write an SQL query to fetch all the Emplds which are present in either of the tables - 'EmployeeDetails and but not in the EmployeeSalary.

select EmpId from EmployeeDetails
where EmpId NOT IN (SELECT EmpId FROM EmployeeSalary);


# Write an sql query to fetch the employee ful names and replace the space with '-;';

SELECT REPLACE(FullName, ' ', '-')from EmployeeDetails;

# both empid and managerid together

SELECT concat(EmpId, ManagerId) as NewId from EmployeeDetails;


# Write a query to fetch only the first name (string before space) from the FullName column of the EmployeeDetails table.

SELECT 
  SUBSTRING(FullName, 1, LOCATE(' ', FullName) - 1) AS FirstName
FROM EmployeeDetails;


-- LOCATE(' ', FullName) → finds the position of the first space in the name
-- SUBSTRING(FullName, 1, LOCATE(' ', FullName) - 1) → extracts characters from position 1 up to just before the space
-- AS FirstName → gives the column a readable alias


# Write an SoL query to uppercase the name of the employee and lowercase the city values

SELECT UPPER(FullName), Lower(City)
FROM EmployeeDetails;


# update the employees name by the removing learing and trining spaces;;;

Update EmployeeDetails
SET FullName = 
TRIM(FullName);

SELECT * FROM EmployeeDetails;

-- TRIM() removes both leading and trailing spaces.

-- LTRIM() removes only leading spaces (spaces on the left).

-- RTRIM() removes only trailing spaces (spaces on the right).


# • Write an SQL query to fetch employee names having a salary greater than or equal to 5000 and less than of equal to 10000.

SELECT FullName
FROM EmployeeDetails
WHERE EmpId IN (
    SELECT EmpId 
    FROM EmployeeSalary 
    WHERE Salary BETWEEN 5000 AND 10000
);




# Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table.

SELECT * FROM EmployeeDetails E
Where EXists
(SELECT * FROM EmployeeSalary S 
WHERE E.EmpId = S.EmpId);


# • Write an SQL query to fetch the project-wise count of employees sorted by project's count in descending order.


SELECT Project, count(Empid) ProjectCount
FROM EmployeeSalary
Group By Project
Order By ProjectCount DESC;


# • Write an SQL query to fetch all the Employees who are also managers from the EmployeeDetails table.

SELECT DISTINCT E.FullName AS ManagerName
FROM EmployeeDetails E
INNER JOIN EmployeeDetails M
ON E.EmpId = M.ManagerId;




# to fetch records from Employee Details where Manager Id is Coming More than Once.

select * from employeedetails
WHERE ManagerId in (select ManagerId
from EmployeeDetails 
GROUP BY ManagerId
Having count(ManagerId > 1));


# to fetch only odd rows from the table;

select E.EmpId, E.Project, E.Salary FROM (
	SELECT *, Row_number() OVER(ORDER BY EmpId) AS RowNumber
    FROM EmployeeSalary
) E

WHERE E.RowNumber % 2 =1;


-- ROW_NUMBER() OVER (ORDER BY EmpId) assigns a unique sequential number to each row based on EmpId order.
-- It’s used to identify row positions (like 1st, 2nd, 3rd) for tasks such as filtering, ranking, or pagination.


# to fetch only even numebr from the tables 

SELECT * from employeedetails
where MOD(Empid, 2)=0;


# to create a new table with data and structure copied from amother table;

CREATE TABLE newTable 
select * from EmployeeSalary;

select * from newTable;


# to fetch top n records

select * from EmployeeSalary
ORDER BY SALARY DESC LIMIT 3;


# to find the 3rd highest salary from a table without using the TOP/limit keyowrd

select Salary
FROM EmployeeSalary Emp1
WHERE 3-1 = (
	SELECT COUNT(DISTINCT (Emp2.Salary))
    FROM EmployeeSalary Emp2
    WHERE Emp2.Salary > Emp1.Salary
);


# order employee names based on the Alphabetical Order;;

SELECT FullName from EmployeeDetails Order by Fullname;

# Z-A

SELECT FullName 
FROM EmployeeDetails 
ORDER BY FullName DESC;


# Order Employee Names And Salary Based on Salary;

SELECT Fullname, Salary FROM employeedetails E,
employeesalary ES
where E.EmpId = ES.EMpId ORDER by ES.Salary;


# print total salary going from each project;;

SELECT ES.PROJECT, ES.Salary from employeesalary ES GROUP BY es.project;


# print all Employee Details Whose joining Date is Not in last year...

SELECT * FROM employeedetails
WHERE(DateOfJoining < current_date() - INTERVAL 1 year);


# PRINT ALL EMPLOYEE WHO GETS PAID ABOVE AVG SALARY;

SELECT * FROM employeedetails, employeesalary where
employeedetails.EmpId = employeeSalary.EmpId
and employeesalary.Salary > (SELECT avg(salary) from employeesalary);

SELECT avg(salary) from employeesalary;


# print all the employees who is the company for more than 4 years...

SELECT * FROM employeedetails WHERE year(CURRENT_DATE) - year(DateofJoining) > 4;


# print all employee with total number of years as services;

select *,(year(current_date)-year(dateOfJoining)) as "services" from employeedetails;


# print total Employees in each project..

select employeesalary.Project, count(*) as 'TOTAL Employeees' from employeesalary
GROUP BY employeeSalary.Project;


# return list of all manager order by total number of employees managed by them....

select ManagerId, COUNT(*) as NumEmployees 
From Employeedetails
GROUP BY ManagerId
ORDER BY NumEmployees;
 
 
# return list of all employee who are serving for more than 2 years and not in project p2 and P3;

SELECT * from employeeSalary
where Project NOT IN('P2', 'P3')
AND EmpId IN
(SELECT EmpId from employeedetails
where year(CURRENT_DATE) - year(dateOfjoining) > 2);


# select project with total Salary whose total employess salary sum is greater than the maximum of average salry project wise....

SELECT Project, SUM(Salary) AS TotalSalary
FROM EmployeeSalary
GROUP BY Project
HAVING SUM(Salary) > (
    SELECT MAX(AvgSalary)
    FROM (
        SELECT AVG(Salary) AS AvgSalary
        FROM EmployeeSalary
        GROUP BY Project
    ) AS AvgTable
);


# add new column role in the employeedetails

alter table employeedetails
ADD Role varchar(50);

# update the value of ROle if salry+variable < 2000 then Analyst, Otherwise Sr Analyst...

UPDATE employeedetails ed
INNER join employeesalary es on ed.EmpId = 

