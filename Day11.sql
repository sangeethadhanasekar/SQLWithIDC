-- ### Practice Questions:
-- 1. List all unique services in the patients table.
select DISTINCT service from patients;
-- 2. Find all unique staff roles in the hospital.
select DISTINCT role from staff;
-- 3. Get distinct months from the services_weekly table.
select * from services_weekly;
select DIStiNCT month from services_weekly ORDER BY month ASC;
-- ### Daily Challenge:
-- **Question:** 
-- Find all unique combinations of service and event type from the services_weekly table
-- where events are not null or none, along with the count of occurrences for each combination. 
-- Order by count descending.
select * from services_weekly;
select DISTINCt service, event ,count(service) as occureneces_combination from services_weekly WHERE event IS NOT NULL GROUP BY event;

SELECT service,  event, COUNT(service) AS occurrences_combination
FROM services_weekly
WHERE  event IS NOT NULL AND event != 'none' 
GROUP BY service, event
ORDER BY  occurrences_combination DESC;

