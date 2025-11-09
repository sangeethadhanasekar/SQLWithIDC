-- ### Practice Questions:

-- 1. Count the number of patients by each service.
select service, count(*) from patients GROUP BY service;
-- 2. Calculate the average age of patients grouped by service.
select ROUND(AVG(age),2) as average_Age_of_patients,service from patients GROUP BY service;
-- 3. Find the total number of staff members per role.
select * from staff;
select role, COUNT(*)as total_number_of_staff_member_per_role from staff GROUP BY role;


-- Question: 
-- For each hospital service, calculate the total number of patients admitted, total patients refused, 
-- and the admission rate (percentage of requests that were admitted). Order by admission rate descending.
select * from services_weekly;
select service, SUM(patients_admitted) as patients_Admitted,SUM(patients_refused) as patients_Refused, 
ROUND(100.0*SUM(patients_admitted)/SUM(patients_admitted)+SUM(patients_refused),2) as admission_rate_percent
from services_weekly GROUP BY service ORDER BY admission_rate_percent DESC ;
