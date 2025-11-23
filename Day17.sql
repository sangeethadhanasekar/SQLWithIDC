-- ### Practice Questions:

-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT p.patient_id, p.name, p.service, p.satisfaction,
       s.service_avg
FROM patients p
JOIN (
    SELECT service, AVG(satisfaction) AS service_avg
    FROM patients
    GROUP BY service
) s ON p.service = s.service;



--2. Create a derived table of service statistics and query from it.
SELECT
	*
FROM 
	(SELECT 
		service,
		AVG(patient_satisfaction) AS AVG_Patient_Satisfaction,
		AVG(patients_admitted) AS AVG_Patients_admitted,
		AVG(patients_refused) AS AVG_Patients_refused
	FROM services_weekly
	GROUP BY service
	) AS service_statistics
	
	-- 3. Display staff with their service's total patient count as a calculated field.

SELECT
	staff.staff_name,
	staff.service,
	COUNT(p.patient_id) as Total_patient_count
FROM 
	(SELECT 
		staff_name,service
	FROM staff
	) AS staff
JOIN patients p ON p.service=staff.service
GROUP BY staff.staff_name,staff.service
-- Question: Create a report showing each service with: service name, total patients admitted, the difference between their total admissions and the average admissions across all services, and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.
SELECT 
    *,
    CASE 
        WHEN "Total_Admission_difference" > "AVG_admissions_Per_Service" THEN 'Above Average'
        WHEN "Total_Admission_difference" < "AVG_admissions_Per_Service" THEN 'Below Average'
        ELSE 'Average'
    END AS "Rank"
FROM
(
    SELECT 
        sw.service,
        SUM(sw.patients_admitted) AS "Total_admissions_Per_Service",
        AVG(sw.patients_admitted) AS "AVG_admissions_Per_Service",
        (SELECT SUM(patients_admitted) FROM services_weekly) - SUM(sw.patients_admitted) AS "Total_Admission_difference"
    FROM services_weekly sw
    GROUP BY sw.service
) AS Admission_stats
ORDER BY "Total_admissions_Per_Service" DESC;

	
