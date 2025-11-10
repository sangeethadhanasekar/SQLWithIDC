-- ### Practice Questions:
-- 1. Find services that have admitted more than 500 patients in total.
select * from staff_schedule;
select service, SUM(patients_admitted) as admitted from services_weekly GROUP BY service HAVING SUM(patients_admitted) >500;
-- 2. Show services where average patient satisfaction is below 75.
select service, ROUND(AVG(patients_admitted),0) as avg_patient from services_weekly GROUP BY service HAVING AVG(patients_admitted) <75;

-- 3. List weeks where total staff presence across all services was less than 50.
--WRONG select week , SUM(staff_morale) as staff_presence from services_weekly GROUP BY week
select week,SUM(present) from staff_schedule group by week having SUM(present)<50 ORDER BY week ASC;

-- DAILY Question: 
-- Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80. 
-- Show service name, total refused, and average satisfaction.
select * from services_weekly;
select service, SUM(patients_refused) as total_refused , AVG(patient_satisfaction) as average_satisfaction from services_weekly
GROUP BY service HAVING SUM(patients_refused) > 100 and AVG(patient_satisfaction) <80;
