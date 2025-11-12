-- ### Practice Questions:
-- 1. Extract the year from all patient arrival dates.
-- select name,CAST(strftime('%Y',arrival_date) AS INTEGER) as year_of_arrival from patients;
select name, EXTRACT(YEAR from arrival_date) as year_of_arrival from patients;

-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
select name, departure_date - arrival_date as length_of_stay from patients;
-- 3. Find all patients who arrived in a specific month.
select * , EXTRACT(MONTH from arrival_date) as month_of_arrival from patients WHERE EXTRACT(MONTH from arrival_date) = 3;


--Daily Quesiton:
-- Calculate the average length of stay (in days) for each service, showing only services
-- where the average stay is more than 7 days. Also show the count of patients and order by average stay descending.
select * from patients;
-- select service, COUNT(patient_id) as count_of_patients, ROUND(AVG (departure_date - arrival_date),0)as AVG_length_of_stay  from patients 
-- GROUP BY service HAVING ROUND(AVG (departure_date - arrival_date),0) >7;
select service, COUNT(patient_id) as count_of_patients, ROUND(AVG (departure_date - arrival_date),0)as AVG_length_of_stay  from patients 
GROUP BY service HAVING ROUND(AVG (departure_date - arrival_date),0) >7 ORDER BY AVG_length_of_stay DESC ;
