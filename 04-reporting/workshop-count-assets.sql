SELECT 
    _account_id as account_id
    , _region as region
    , _type as resource_type
    , count(*) as resource_count
FROM resources
WHERE 
    _tags::jsonb ->> 'app' = 'workshop'
    AND _tags::jsonb ->> 'environment' = 'dev'
GROUP BY _account_id, _region, _type
ORDER BY resource_count desc
