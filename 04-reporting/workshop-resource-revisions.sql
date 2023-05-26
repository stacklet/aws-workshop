SELECT 
    rr.*
FROM resource_revisions rr
WHERE 
    rr._tags::jsonb ->> 'app' = 'workshop'
    AND rr._tags::jsonb ->> 'environment' = 'dev'
    AND rr._id = '<ONE OF THE ARNS MATCHED FROM THE PREVIOUS QUERY'
ORDER BY rr.version_id desc
