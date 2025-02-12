### Perform the following queries
-- insurance data sets
Select * from campusx.insurance;

-- 1. Show records of 'male' patient from 'southwest' region.
select * from campusx.insurance
where gender = 'male' AND region = 'southwest';


-- 2. Show all records having bmi in range 30 to 45 both inclusive.
select * from campusx.insurance
where bmi BETWEEN 30 AND 45;

-- 3. Show minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively.\
select smoker,diabetic, MAX(bloodpressure) AS 'MaxBP', MIN(bloodpressure) AS 'MinBP' FROM campusx.insurance
where smoker = 'yes' AND diabetic = 'yes';


-- 4. Find no of unique patients who are not from southwest region.
SELECT COUNT(DISTINCT PatientID) AS unique_patients
FROM campusx.insurance
WHERE region != 'southwest';

-- 5. Total claim amount from male smoker.
SELECT SUM(claim) AS 'Total Amt male' FROM campusx.insurance
where gender = 'male' and smoker = 'yes';

-- 6. Select all records of south region.
SELECT * FROM campusx.insurance
where region LIKE '%south%';

-- 7. No of patient having normal blood pressure. Normal range[90-120]
Select COUNT(*) AS 'NO_of_Patients' from campusx.insurance
where bloodpressure between 90 AND 120;

-- 8. No of pateint belo 17 years of age having normal blood pressure as per below formula -
--     - BP normal range = 80+(age in years × 2) to 100 + (age in years × 2)

SELECT COUNT(*) AS 'NO_of_patient' 
FROM campusx.insurance
WHERE age < 70
AND bloodpressure between (80 + (age * 2)) AND (100 + (age * 2));

--     - Note: Formula taken just for practice, don't take in real sense. 

Select * from campusx.insurance;
-- 9. What is the average claim amount for non-smoking female patients who are diabetic?
SHOW COLUMNS FROM campusx.insurance;

SELECT DISTINCT smoker, diabetic FROM campusx.insurance;

SELECT AVG(claim) AS avg_claim_amt 
FROM campusx.insurance
WHERE gender = 'female'  
AND smoker = 'No' 
AND diabetic = 'Yes';


-- 10. Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.
UPDATE campusx.insurance
SET patientID = '5000'
WHERE patientID = '1234';

select * from campusx.insurance where PatientID = '5000';

-- 11. Write a SQL query to delete all records for patients who are smokers and have no children.
DELETE FROM campusx.insurance
where smoker = 'Yes' AND children = '0';

Select * FROM campusx.insurance
where smoker = 'Yes' AND children = '0'