# Reporting

Stacklet has 3 main data-aggregation components: 

* AssetDB, which tracks every asset in the environment and its configuration over time
* Policy Executions, which evaluate the compliance and efficiency of assets
* Billing Connector, which aggregates billing data for each 

In Stacklet Console, you can review curated dashboards and queries based on the data collected. 
In addition, Stacklet offers a flexible querying interface that lets you create custom dashboards or query the data the way you want, and even add additional data sources to correlate Stacklet's data with other business inputs. 

## Stacklet Console

The console presents multiple dashboards presenting the current compliance of your environment against CIS 1.5, SOC2 and financial efficiency. 

You can find the links to these dashboards in the top level "overview" section. 

In addition, policies that are currently deployed in your environment appear in the `Overview > Deployed Policies` section. The `Resource Match Count` columns informs about the number of resources currently in violation.

You can then go into each of the policies and discover which resources are currently in violation in the `Resource Matches` tab

## Redash

To customize queries and run deeper analysis against the data, browse to `Stacklet Tools > AssetDB`. This will open a new tab with a querying interface. 

Browse to `Queries` then hit the `New` button. On the left hand side of the page, you will see all the tables available to you for queries. Take a moment to review

* Per provider, one table per resource type (example: aws_ec2)
* a `platform` schema, which all execution results and policy information
* some global tables
  * resources and resource_revisions are holistic of the resources
  * resource_tags tables have all the tags between all resources
  * resource_cost tables retain billing information for each resource

On the right hand pan, you can type a SQL query. Let's start with something simple: 

```sql
SELECT * FROM resources
WHERE 
    _tags::jsonb ->> 'app' = 'workshop'
    AND _tags::jsonb ->> 'environment' = 'dev'
```

You may have seen that the Terraform variables contained tag keys and values. Stacklet has seen the assets and ingested the tags, and you can now see all the different resources that have been deployed. 

It's also very often useful to understand the different types of assets that are part of an application, which you can do with 

```sql
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
```

You won't see the results just yet because these resources are too new, but you could also add a column with the cost data to understand how much does this application cost per service. You would need to run this again in 24h to 48h to get a first glance at numbers

```sql
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
```

To check compliance and policy evaluations for this group of resources, you can run

```sql
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
```

If you did deploy the terraform code knowing that there were policy violations, then you should see some results in this query. In that case, run 

```sql
SELECT 
    rr.*
FROM resource_revisions rr
WHERE 
    rr._tags::jsonb ->> 'app' = 'workshop'
    AND rr._tags::jsonb ->> 'environment' = 'dev'
    AND rr._id = '<ONE OF THE ARNS MATCHED FROM THE PREVIOUS QUERY'
ORDER BY rr.version_id desc
```

and check out the timeline of changes for that resource. 

