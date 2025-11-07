-- ### Practice Questions:

-- 1. Count the total number of patients in the hospital.
select COUNT(*) as total_number from patients;

-- 2. Calculate the average satisfaction score of all patients.
select AVG(satisfaction) as average_satisfaction_score from patients;

-- 3. Find the minimum and maximum age of patients.
select MIN(age) as min_age , MAX(age) as max_age from patients;


-- Question: 
-- Calculate the total number of patients admitted, total patients refused, 
-- and the average patient satisfaction across all services and weeks. 
-- Round the average satisfaction to 2 decimal places.
select * from patients;
select * from services_weekly;

WRONG : select COUNT(patients_admitted) as total_number_of_patients_admitted,
COUNT(patients_refused) as total_patients_refused,
ROUND(AVG(patient_satisfaction),2) as average_patient_satisfaction
from services_weekly ;
--COUNT(patients_admitted) only counts non-null rows, not the sum of admitted patients.
-- -- If patients_admitted is a numeric column (e.g., number of patients), you should use SUM(), not COUNT().
-- -- Similarly, for patients_refused, use SUM() if it’s a numeric total per service/week.

CORRECT:
select SUM(patients_admitted) as total_number_of_patients_admitted,
SUM(patients_refused) as total_patients_refused,
ROUND(AVG(patient_satisfaction),2) as average_patient_satisfaction
from services_weekly ;
