-- Running total of patients admitted per serviceSELECT
    service,
    week,
    patients_admitted,
    SUM(patients_admitted) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS cumulative_admissions
FROM services_weekly
ORDER BY service, week;
-- 3-week moving average of satisfaction
SELECT
    service,
    week,
    patient_satisfaction,
    ROUND(AVG(patient_satisfaction) OVER (
        PARTITION BY service
        ORDER BY week
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW    ), 2) AS moving_avg_3week
FROM services_weekly
ORDER BY service, week;
-- Compare to service average
SELECT
    service,
    week,
    patients_admitted,
    AVG(patients_admitted) OVER (PARTITION BY service) AS service_avg,
    patients_admitted - AVG(patients_admitted) OVER (PARTITION BY service) AS diff_from_avg
FROM services_weekly;
-- Running min/max
SELECT
    service,
    week,
    patient_satisfaction,
    MIN(patient_satisfaction) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS min_so_far,
    MAX(patient_satisfaction) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS max_so_far
FROM services_weekly;








-- ### Practice Questions:

-- 1. Calculate running total of patients admitted by week for each service.
select * from services_weekly;
select service,week,patients_admitted,SUM(patients_admitted) OVER ( PARTITION BY service ORDER BY week)  as running_total
from services_weekly 
-- 2. Find the moving average of patient satisfaction over 4-week periods.
select service,week,patient_satisfaction,
ROUND(AVG(patient_satisfaction) OVER ( PARTITION BY service ORDER BY week ROWS BETWEEN 3 PRECEDING and current row),2) as moving_avg
from services_weekly
-- 3. Show cumulative patient refusals by week across all services.
select * from services_weekly
select service,week,patients_refused,SUM(patients_refused) OVER(Partition by service order by week) cumulative_patient_refusal_by_week from services_weekly
### Daily Challenge:

-- **Question:** 
-- Create a trend analysis showing for each service and week: week number, 
-- patients_admitted, running total of patients admitted (cumulative), 3-week moving average 
-- of patient satisfaction (current week and 2 prior weeks), and the difference between current week admissions 
-- and the service average. Filter for weeks 10-20 only.
select * from services_weekly
select * from (
select service,week,patients_admitted,avg(patients_admitted) over (partition by service ) as service_avg, sum(patients_admitted) over ( partition by service order by week) as cumulative_total_patient_admitted,
avg(patient_satisfaction) over (PARTITION BY service order by week rows between 2 preceding and current row) as week_moving_average,
patients_admitted - avg(patients_admitted) over (partition by service) as diff_btwn_currentweekadmission_and_service_average 
from services_weekly) where week >=10 and week <=20


