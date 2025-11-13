-- ### Practice Questions:
-- 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
select * from patients;
select patient_id,name,service ,
CASE WHEN satisfaction>=80 THEN 'High'
WHEN satisfaction<80 and satisfaction>=40 THEN 'Medium'  
ELSE 'Low' END AS satisfaction_category from patients;

-- 2. Label staff roles as 'Medical' or 'Support' based on role type.
select DISTINCT role from staff;
select staff_name,service,role, CASE WHEN role ='doctor' or role ='nurse' THEN 'Medical' ELSE 'Support' END as staff_role_label  from staff;

-- 3. Create age groups for patients (0-18, 19-40, 41-65, 65+).
select * from patients;
select name,age, CASE WHEN age>0 and age<=18 THEN '0-18' WHEN age>=19 and age<=40 THEN '19-40'
WHEN age>=41 and age<=65 THEN '41-65' ELSE '65+' END as age_group from patients;

-- ### Daily Challenge:
-- **Question:** Create a service performance report showing service name, total patients admitted,
-- and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 
-- 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.


select * from services_weekly;
select service , SUM(patients_admitted) as total_patients_admitted, ROUND(AVG(patient_satisfaction),1),
CASE WHEN AVG(patient_satisfaction)>=85 THEN 'Excellent' 
WHEN AVG(patient_satisfaction)>=75 THEN 'Good'  
WHEN AVG(patient_satisfaction)>=65 THEN 'Fair'
ELSE 'Needs Improvement' END AS performance_category from services_weekly GROUP BY service ORDER BY AVG(patient_satisfaction) DESC
