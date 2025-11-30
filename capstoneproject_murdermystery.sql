select * from employees;
select * from keycard_logs;
select * from calls ;
select * from alibis;
select * from evidence;

------------------alaysis done by me ------------------------------
select k.*,e.* from keycard_logs k join employees e on k.employee_id = e.employee_id ;--David kumar engineering dept devops enginner entered server room(8am -9am) and ceo office(9.50pm to 11pm)

select k.*,e.* from keycard_logs k join employees e on k.employee_id = e.employee_id where e.role='DevOps Engineer';


select * from keycard_logs where entry_time >'2025-10-15 19:50:00' ; --20.50 someone entered CEO room and david called around 20.55
select c.*,e.employee_id,e.name,e.role,c.caller_id,c.receiver_id,ee.name,ee.role from calls c inner join employees e ON c.caller_id = e.employee_id inner join employees ee ON c.receiver_id =ee.employee_id
where c.call_time > '2025-10-15 20:00:00'; -- which person called whome  --David kumar called CFO and Enginner around 9.40pm and 9.55pm

select a.*,e.name,k.room,k.employee_id,k.entry_time,k.exit_time from alibis a join employees e on a.employee_id = e.employee_id join keycard_logs k on a.claim_time = k.entry_time where a.employee_id = k.employee_id;
-- here it is clear that Davidkumar alibis as server room at 20.50.00pm but log entry show he is in CEO office at 20.50.00
select e.*, k.* from evidence e join keycard_logs k on e.room = k.room;
--clear that david kumar enter ceo office and only fingerprint on desk is found (physical evidence found)
----------------------------------------------------------------------------


-- CRIME Happened at CEO OFFICE at 9pm
-- Identify where and when the crime happened	WHERE, filtering
WITH where_and_When_crime_happened as (
select employee_id,room,entry_time,exit_time 
from keycard_logs 
where room = 'CEO Office'
AND entry_time BETWEEN '2025-10-15 20:00:00' AND '2025-10-15 21:00:00'
),

-- Analyze who accessed critical areas at the time	JOIN, BETWEEN
who_accessed_critical_areas as (
select e.name,k.employee_id,k.room,k.entry_time,k.exit_time 
from keycard_logs k 
join employees e ON k.employee_id=e.employee_id
where entry_time BETWEEN '2025-10-15 20:00:00' and '2025-10-15 23:00:00'),

-- Cross-check alibis with actual logs	JOIN, subqueries
cross_check_with_actual_logs as (
select alibis_record.*, k.employee_id as keycardlogs_id,k.room as keycardlogs_room, k.entry_time as keycardlogs_entrytime from (
select a.alibi_id,a.employee_id,e.name as employee_name,e.role as emp_role,e.department as emp_dept, a.claimed_location,a.claim_time 
from alibis a 
JOIN employees e ON a.employee_id=e.employee_id ) 
as alibis_record 
JOIN keycard_logs k ON k.entry_time = alibis_record.claim_time
where alibis_record.employee_id = k.employee_id ),

-- Investigate suspicious calls made around the time	JOIN, filtering
suspicious_call as (
select c.call_time,c.call_id,c.caller_id,e.employee_id,e.name as caller_name ,e.role,c.receiver_id,ee.employee_id  ,ee.name as receiver_name,ee.role from calls c inner join employees e ON c.caller_id = e.employee_id inner join employees ee ON c.receiver_id =ee.employee_id
where c.call_time between '2025-10-15 20:50:00' and '2025-10-15 21:00:00'),


-- Match evidence with movements and claims	JOIN, WHERE
evidence_with_movements_and_claims as (
select k.employee_id as keycardlogs_emp_id ,k.room as keycardlogs_room ,k.entry_time as keycardlogs_entrytime
,e.evidence_id,e.room,e.description,e.found_time 
from evidence e 
join keycard_logs k 
on e.room=k.room 
where k.entry_time between '2025-10-15 20:00:00' and '2025-10-15 21:00:00')

-- Combine all findings to identify the killer	INTERSECT, multiple JOINs
-- select * from where_and_When_crime_happened;who_accessed_critical_areas,cross_check_with_actual_logs,suspicious_call,evidence_with_movements_and_claims
-- select * from suspicious_call;
select distinct e.name as killer from (
select t2.room as crime_happened_room, t2.entry_time as crime_happened_time, t1.entry_time as accessed_time , t1.employee_id as accessed_by ,t3.employee_name,t3.claimed_location,t3.claimed_location,t3.keycardlogs_room as actual_room,t3.keycardlogs_entrytime as actual_entrytime,t4.call_id,t4.caller_id, t4.caller_name as who_Called,t4.call_time as sus_call_time,t4.receiver_name,t5.evidence_id,t5.room as evidence_room, t5.description ,t5.found_time as evidence_foundtime
from  where_and_When_crime_happened t1 
join who_accessed_critical_areas t2 on t1.employee_id = t2.employee_id 
join  cross_check_with_actual_logs t3 on t1.employee_id = t3.employee_id
join suspicious_call t4 on t1.employee_id=t4.caller_id 
join evidence_with_movements_and_claims t5 on t1.employee_id = t5.keycardlogs_emp_id
) as findings join employees  e on e.employee_id  = findings.accessed_by

-- FINDINGS:
-- killer: David Kumar (DevOps Engineer):
-- Claimed alibi: server room at 20:50
-- Keycard log: CEO office at 20:50 → Alibi broken
-- Evidence: fingerprint on CEO desk → physically at the scene
-- Suspicious calls: CFO & Engineer around the same time → coordinating or covering tracks






-----AI ANSWER (optimised) --> to ensure my query is correct or not

-- Step 1: Crime scene entries
WITH crime_scene_entries AS (
    SELECT employee_id, room, entry_time, exit_time
    FROM keycard_logs
    WHERE room = 'CEO Office'
      AND entry_time BETWEEN '2025-10-15 20:00:00' AND '2025-10-15 21:00:00'
),

-- Step 2: Broken alibis
broken_alibis AS (
    SELECT a.employee_id, a.claimed_location, a.claim_time, k.room AS actual_room, k.entry_time AS actual_time
    FROM alibis a
    JOIN keycard_logs k
      ON a.employee_id = k.employee_id
     AND a.claim_time = k.entry_time
    WHERE a.claimed_location <> k.room
),

-- Step 3: Evidence found in CEO Office
evidence_in_crime_room AS (
    SELECT e.evidence_id, e.room, e.found_time, k.employee_id
    FROM evidence e
    JOIN keycard_logs k
      ON e.room = k.room
     AND k.entry_time BETWEEN '2025-10-15 20:00:00' AND '2025-10-15 21:00:00'
    WHERE e.room = 'CEO Office'
)

-- Step 4: Combine to identify the killer
SELECT DISTINCT emp.name AS killer
FROM employees emp
JOIN crime_scene_entries cse ON emp.employee_id = cse.employee_id
JOIN broken_alibis ba ON emp.employee_id = ba.employee_id
JOIN evidence_in_crime_room ev ON emp.employee_id = ev.employee_id;
