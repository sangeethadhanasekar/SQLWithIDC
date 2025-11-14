SELECT 
    service, 
    event, 
    COUNT(service) AS occurrences_combination
FROM 
    services_weekly
WHERE 
    event IS NOT NULL 
    AND event != 'none' 
GROUP BY 
    service, 
    event
ORDER BY 
    occurrences_combination DESC;
