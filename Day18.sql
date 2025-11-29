
-- Combine patient and staff names
SELECT name AS full_name, '0' AS type, service
FROM patients
UNION ALL SELECT staff_name AS full_name, 'Staff' AS type, service
FROM staff
ORDER BY service, type, full_name;
-- High and low performers
SELECT patient_id, name, satisfaction, 'High Performer' AS category FROM patients
WHERE satisfaction >= 90 UNION SELECT patient_id, name, satisfaction, 'Low Performer' AS category FROM patients
WHERE satisfaction < 80 ORDER BY satisfaction DESC;
-- All unique services from multiple tables
SELECT DISTINCT service FROM patients
UNION SELECT DISTINCT service FROM staff
UNION SELECT DISTINCT service FROM services_weekly;
-- Monthly summary from different metrics
SELECT
    'Admissions' AS metric,
    month,
    SUM(patients_admitted) AS value FROM services_weekly
GROUP BY month UNION ALL SELECT
    'Refusals' AS metric,
    month,
    SUM(patients_refused) AS value FROM services_weekly
GROUP BY month ORDER BY month, metric;









-- ### Practice Questions:
-- 1. Combine patient names and staff names into a single list.
select p.name, 'PATIENT' as type from patients p  UNION ALL select  s.staff_name,'Staff' as type from staff s;
-- 2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
select * 
from (
    select p.name,'High Satifaction' as emotion from patients p where p.satisfaction>90
    UNION
    select p.name,'Low Satifaction' as emotion from patients p where p.satisfaction<90
) t
order by name,emotion;
-- 3. List all unique names from both patients and staff tables.

select DISTINCT p.name, 'PATIENT' as type from patients p  UNION 
select  DISTINCT s.staff_name,'STAFF' as type from staff s ORDER BY type DESC;

-- ### Daily Challenge:
-- **Question:** Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), 
-- full name, type ('Patient' or 'Staff'), and associated service. Include only those in 'surgery' or 'emergency' services. 
-- Order by type, then service, then name.
select * from patients;
select * from staff;
select * from (
select patient_id,name, 'Patient' as type, service from patients UNION ALL 
select staff_id,staff_name, 'Staff' as type, service from staff
)where service IN ('surgery','emergency') order by type,service,name





