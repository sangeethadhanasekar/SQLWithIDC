-- Number patients within each service
SELECT
    patient_id,
    name,
    service,
    satisfaction,
    ROW_NUMBER() OVER (PARTITION BY service ORDER BY satisfaction DESC) AS row_num
FROM patients;
-- Rank patients by satisfaction (with ties)
SELECT
    patient_id,
    name,
    satisfaction,
    RANK() OVER (ORDER BY satisfaction DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY satisfaction DESC) AS dense_rank FROM patients;
-- Top 3 weeks by satisfaction per service
SELECT *FROM (
    SELECT
        service,
        week,
        patient_satisfaction,
        RANK() OVER (PARTITION BY service ORDER BY patient_satisfaction DESC) AS sat_rank
    FROM services_weekly
)
WHERE sat_rank <= 3;
-- Rank services by total admissions
SELECT
    service,
    SUM(patients_admitted) AS total_admitted,
    RANK() OVER (ORDER BY SUM(patients_admitted) DESC) AS admission_rank
FROM services_weekly
GROUP BY service;


-- Quick mental trick
-- GROUP BY = squish rows together, aggregate
-- Window function = stay row by row, just calculate extra info


-- ### Practice Questions:
-- 1. Rank patients by satisfaction score within each service.
select * from patients;
select patient_id,name,satisfaction,service, 
Rank() OVER ( PARTITION BY service ORDER BY satisfaction DESC) as Rank
from patients;
-- 2. Assign row numbers to staff ordered by their name.
select * from staff;
select *,ROW_NUMBER() OVER(ORDER BY staff_name) as row_number from staff;
-- 3. Rank services by total patients admitted.
select * ,RANK() OVER( ORDER BY total_patients_admitted DESC) as rank_number
from (
select service, SUM(patients_admitted) as total_patients_admitted
from services_weekly
group by service)

-- ### Daily Challenge:
-- **Question:** For each service, rank the weeks by patient satisfaction score (highest first). 
-- Show service, week, patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service.

select * from services_weekly;
select * from(
select *,RANK() OVER(PARTITION BY service ORDER BY patient_satisfaction desc) as rank_number from(
select service,week,patient_satisfaction,patients_admitted from services_weekly)
) where rank_number<=3 

