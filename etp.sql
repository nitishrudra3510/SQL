CREATE DATABASE EmpIDCompanyDB;

USE CompanyDB;

CREATE TABLE Employeesss (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL
);

INSERT INTO Employeesss (EmpID, Name, Department, Salary)
VALUES 
(1, 'Nitish Kumar', 'IT', 65000.00),
(2, 'Anjali Sharma', 'HR', 55000.00),
(3, 'Rahul Verma', 'Sales', 48000.00),
(4, 'Pooja Mehta', 'IT', 70000.00);


SELECT * FROM Employeesss;


# creating indexing
CREATE INDEX idx_dept ON Employeesss(Department);

SELECT * FROM Employeesss WHERE Department = 'Sales';
