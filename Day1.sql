--select * from patients count at patient_id as total_number;
select count( patient_id ) as total_number from patients;

--Retrieve all columns from the patients table.
select * from patients;
select * from patients limit 5;

--Select only the patient_id, name, and age columns from the patients table.
select patient_id as id, name as patient_name, age as patient_age from patients;

--Display the first 10 records from the services_weekly table.
select * from services_weekly LIMIT 10;

-- ### Daily Challenge:
-- **Question:** List all unique hospital services available in the hospital
select DISTINCT service as unique_hospital_services from services_weekly;
select DISTINCT service as unique_hospital_services_from_patients_table from patients;
select DISTINCT service as unique_hospital_services_from_staff_table from staff;
select DISTINCT service as unique_hospital_services_from_staff_schedule from staff_schedule;







