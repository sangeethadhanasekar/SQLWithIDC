-- ## Practice Questions:
-- 1. Find all weeks in services_weekly where no special event occurred.
select * from services_weekly;
select week,service,event from services_weekly WHERE event='none';

-- 2. Count how many records have null or empty event values.
-- select COUNT(*) as total_record,se COUNT(event) as empty_value from services_weekly group by event;
select count(event) as NULL_EVENT_COUNT from services_weekly where event IS NULL or event ='none';

-- 3. List all services that had at least one week with a special event.
select DIStiNCT service from services_weekly WHERE event IS NOT NULL and event!='none';

-- ## Daily Challenge:
-- **Question:** Analyze the event impact by comparing weeks with events vs weeks without events. 
-- Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale.
-- Order by average patient satisfaction descending.
select * from services_weekly;

select 
CASE WHEN event != 'none' and event IS NOT NULL and event !='' THEN 'With Event'
ELSE 'No Event' END as event_status,COUNT(DISTINCT week) as count_of_weeks,AVG(patient_satisfaction)as AVG_patient_satisfaction,AVG(staff_morale) 
from  services_weekly GROUP BY event_status  Order BY AVG_patient_satisfaction DESC;
