SELECT * FROM resources
WHERE 
    _tags::jsonb ->> 'app' = 'workshop'
    AND _tags::jsonb ->> 'environment' = 'dev'
