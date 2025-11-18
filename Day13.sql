-- ### Practice Questions:
-- 1. Join patients and staff based on their common service field (show patient and staff who work in same service).
select * from staff;
select * from services_weekly;
select p.patient_id ,p.name,p.service as patient_service, s.staff_id,s.staff_name,s.service as staff_service 
from patients p INNER JOIN staff s on p.service = s.service ORDER BY p.service;

-- 2. Join services_weekly with staff to show weekly service data with staff information.
select w.week,w.month,w.service,s.staff_name,s.staff_id,s.role from services_weekly as w 
JOIN staff s on w.service=s.service order by s.role;

-- 3. Create a report showing patient information along with staff assigned to their service.
select p.*, s.staff_name,s.staff_id,s.service from patients p JOIN staff s ON p.service = s.service;


-- ### Daily Challenge:
-- **Question:** 
-- Create a comprehensive report showing patient_id, patient name, age, service, and 
-- the total number of staff members available in their service. Only include patients 
-- from services that have more than 5 staff members. Order by number of staff descending, then by patient name.
select p.patient_id,p.name,p.age,p.service,COUNT(s.staff_id) as staff_count from patients p JOIN staff s ON p.service=s.service
GROUP BY s.service,p.patient_id having COUNT(s.staff_id) >5
ORDER BY staff_count DESC , p.name ;


