SELECT 
    r._account_id as account_id
    , r._region as region
    , r._type as resource_type
    , r._id as resource_id
    , rm.policy_name
    , age(now(), rm.first_event::date) as since
FROM resources r
JOIN platform.resource_match rm on rm.resource_key = r._id
WHERE 
    r._tags::jsonb ->> 'app' = 'workshop'
    AND r._tags::jsonb ->> 'environment' = 'dev'
    AND rm.current_match