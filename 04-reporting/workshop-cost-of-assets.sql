SELECT 
    r._account_id as account_id
    , r._region as region
    , r._type as resource_type
    , count(r.*) as resource_count
    , sum(rc.unblended_cost) as total_cost_since_first_seen
    , sum(rcs.daily_unblended_cost) as average_daily_cost
FROM resources r
JOIN resource_cost rc on rc.resource_id = r._id
JOIN resource_cost_summaries rcs on rcs.resource_id = r._id
WHERE 
    r._tags::jsonb ->> 'app' = 'workshop'
    AND r._tags::jsonb ->> 'environment' = 'dev'
GROUP BY r._account_id, r._region, r._type
ORDER BY total_cost_since_first_seen desc