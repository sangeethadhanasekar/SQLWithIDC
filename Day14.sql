-- 1. Show all staff members and their schedule information (including those with no schedule entries).
select s.*,ss.* from staff s LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id;
-- 2. List all services from services_weekly and their corresponding staff (show services even if no staff assigned).
select ss.service,s.staff_id,s.staff_name,s.service as staff_service from services_weekly ss LEFT JOIN staff s  ON ss.service = s.service;
-- 3. Display all patients and their service's weekly statistics (if available).
select *  from services_weekly;
select p.patient_id,p.name as patient_name ,p.age,sw.week,sw.month,sw.staff_morale from patients p 
left join services_weekly sw on p.service=sw.service;

-- ### Daily Challenge:
-- **Question:** Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service)
-- and the count of weeks they were present (from staff_schedule). 
-- Include staff members even if they have no schedule records. Order by weeks present descending.
select * from staff_schedule;
select s.*,SUM (COALESCE(ss.present,0)) as weeks_present from staff s LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id 
GROUP BY s.staff_id ORDER BY weeks_present DESC;
