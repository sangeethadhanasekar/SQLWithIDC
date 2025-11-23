-- ### Practice Questions:
-- 1. Find patients who are in services with above-average staff count.
SELECT patient_id,name,service 
from patients 
where service IN (
	SELECT service
	FROM (
	    SELECT service, COUNT(staff_id) AS staff_count
	    FROM staff
	    GROUP BY service
	) AS service_counts
	WHERE staff_count >(
		select AVG(staff_count) 
		from (
		 		select count(staff_id) as staff_count 
				from staff 
				group by service 
			  )as average_staff_count
	)
);


-- 2. List staff who work in services that had any week with patient satisfaction below 70.
SELECT 
    sw.week,
    sw.service,
    sw.patient_satisfaction,
    s.staff_name
FROM services_weekly sw
JOIN staff s 
      ON sw.service = s.service
WHERE sw.patient_satisfaction < 70 order by sw.week,sw.service


-- 3. Show patients from services where total admitted patients exceed 1000.

SELECT * FROM
	(SELECT 
		p.service,
		p.name,
		SUM(sw.patients_admitted) as Total_Admitted_patients
	FROM patients p
	JOIN services_weekly sw ON p.service = sw.service
	GROUP BY p.name,p.service) 
as patient_info 
WHERE patient_info.Total_Admitted_patients>1000
ORDER BY patient_info.Total_Admitted_patients DESC

-- Question: 
-- Find all patients who were admitted to services that had at least one week where
-- patients were refused AND the average patient satisfaction 
-- for that service was below the overall hospital average satisfaction. 
-- Show patient_id, name, service, and their personal satisfaction score.

select DISTINCT * FROM (
select p.patient_id,p.name,p.service,p.satisfaction,(SELECT AVG(patient_satisfaction) FROM services_weekly) AS overall_avg
from services_weekly sw
join patients p on p.service=sw.service
where sw.patients_refused <> 0 AND
	(SELECT AVG(patient_satisfaction) FROM services_weekly) > p.satisfaction
	) AS result






