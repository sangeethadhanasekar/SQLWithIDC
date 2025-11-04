-- 1. Find all patients who are older than 60 years.
SELECT column_name,data_type FROM information_schema.columns WHERE table_name = 'patients';
SELECT * FROM patients WHERE age>60;
SELECT COUNT(patient_id) FROM patients WHERE age>60; -- count =>338

--2. Retrieve all staff members who work in the 'Emergency' service.
SELECT * FROM staff WHERE service='emergency';
--WRONG:  SELECT * FROM staff AND COUNT(staff_id) WHERE service = 'emergency';
--WRONG:  SELECT * , COUNT(staff.staff_id) as total_count FROM staff GROUP BY staff.service = 'emergency';
--CORRECT:  SELECT S.*, (SELECT COUNT(staff_id) as total_count FROM staff WHERE service='emergency') FROM staff as S WHERE S.service='emergency'; --show records and add extracolumn =

--3. List all weeks where more than 100 patients requested admission in any service.
select * from services_weekly where patients_request>100;
--CORRECT:  select (select count(*) from services_weekly where patients_request>100), s.* from services_weekly as s where s.patients_request>100;

-- ### Daily Challenge:
-- **Question:** Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.
-- select * from patients;
select patient_id,name,age,satisfaction as satisfaction_score from patients where service='surgery' and satisfaction<70;

-- Question Corner--
