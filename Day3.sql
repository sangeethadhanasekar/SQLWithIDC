-- Single column sort 
SELECT * FROM patients ORDER BY age DESC;
-- Multiple columns (age DESC, then name ASC within same age)
SELECT * FROM patients ORDER BY age DESC, name ASC;
-- Sort by column number (not recommended)
SELECT name, age, service FROM patients ORDER BY 3 DESC;

-- ### Practice Questions:
-- 1. List all patients sorted by age in descending order.
SELECT * FROM patients ORDER BY age DESC;
-- 2. Show all services_weekly data sorted by week number ascending and patients_request descending.
SELECT * FROM services_weekly ORDER BY week asc , patients_request desc ;
-- 3. Display staff members sorted alphabetically by their names.
SELECT * FROM staff ORDER BY  staff_name ASC;


-- ### Daily Challenge:
-- **Question:** 
-- Retrieve the top 5 weeks with the highest patient refusals across 
-- all services, showing week, service, patients_refused, and patients_request. 
-- Sort by patients_refused in descending order.
SELECT week,service,patients_refused,patients_request FROM services_weekly ORDER BY patients_refused DESC LIMIT 5;




