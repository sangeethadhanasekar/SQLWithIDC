-- Simple CTE for service statistics
WITH service_stats AS (
    SELECT
        service,
        COUNT(*) AS patient_count,
        AVG(satisfaction) AS avg_satisfaction
    FROM patients
    GROUP BY service
)
SELECT *FROM service_stats
WHERE avg_satisfaction > 75 ORDER BY patient_count DESC;
-- Multiple CTEs for complex analysisWITH
patient_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_patients,
        AVG(age) AS avg_age,
        AVG(satisfaction) AS avg_satisfaction
    FROM patients
    GROUP BY service
),
staff_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_staff
    FROM staff
    GROUP BY service
),
weekly_metrics AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused
    FROM services_weekly
    GROUP BY service
)
SELECT
    pm.service,
    pm.total_patients,
    pm.avg_age,
    pm.avg_satisfaction,
    sm.total_staff,
    wm.total_admitted,
    wm.total_refused,
    ROUND(100.0 * wm.total_admitted /
          (wm.total_admitted + wm.total_refused), 2) AS admission_rate
FROM patient_metrics pm
LEFT JOIN staff_metrics sm ON pm.service = sm.service
LEFT JOIN weekly_metrics wm ON pm.service = wm.service
ORDER BY pm.avg_satisfaction DESC;
-- CTE referencing another CTEWITH
all_admissions AS (
    SELECT
        service,
        SUM(patients_admitted) AS total
    FROM services_weekly
    GROUP BY service
),
high_performing_services AS (
    SELECT service
    FROM all_admissions
    WHERE total > (SELECT AVG(total) FROM all_admissions)
)
SELECT *FROM patients
WHERE service IN (SELECT service FROM high_performing_services);


-- ### Practice Questions:
-- 1. Create a CTE to calculate service statistics, then query from it.
select * from services_weekly;
WITH service_statistics as (
select  service,
AVG(patients_admitted) as AVG_patientsadmitted,
AVG(patients_refused) as AVG_patientsrefused,
AVG(patient_satisfaction) as AVG_patientsatisfaction
from services_weekly group by service
)
select * from service_statistics where service in ('ICU','surgery')

-- 2. Use multiple CTEs to break down a complex query into logical steps.
-- 3. Build a CTE for staff utilization and join it with patient data.
with staff_utilization as(
select service,role,sum(present) from staff_schedule group by role,service order by service,role
)
select * from patients JOIN staff_utilization ON staff_utilization.service = patients.service order by patients.service;


-- Question: Create a comprehensive hospital performance dashboard using CTEs. 
-- Calculate: 1) Service-level metrics (total admissions, refusals, avg satisfaction),
-- 2) Staff metrics per service (total staff, avg weeks present), 
-- 3) Patient demographics per service (avg age, count). 
-- Then combine all three CTEs to create a final report showing service name, all calculated metrics, 
-- and an overall performance score (weighted average of admission rate and satisfaction).
-- Order by performance score descending.


WITH  
service_level_metrics as(
select service, SUM(patients_admitted) as total_admission, SUM(patients_refused) as total_refusals,
AVG(patient_satisfaction) as avg_satisfaction from services_weekly group by service
),

staff_metrics_per_service As(
	select service,
			COUNT(staff_id) AS total_staff,
			AVG(week_present) as avg_week_present 
	from   (select service,staff_id,sum(present) as week_present 
			from staff_schedule
			group by staff_id,service
			) 
	as weekly_data 
	group by service),


patient_demographics_per_service as(
	select service,AVG(age) as avg_age,
	COUNT(patient_id) as patient_count 
	from patients 
	group by service)

SELECT
    s.service,
	s.total_admission,s.total_refusals,s.avg_satisfaction,
	sm.total_staff,sm.avg_week_present,
	pd.avg_age,pd.patient_count,
	((s.total_admission * 1.0) / NULLIF((s.total_admission + s.total_refusals),0)) * 0.7 + s.avg_satisfaction * 0.3 AS overall_performance_score

FROM service_level_metrics s
INNER JOIN staff_metrics_per_service sm ON s.service=sm.service
INNER JOIN patient_demographics_per_service pd ON s.service = pd.service
ORDER BY  overall_performance_score DESC













