
with base as (
    select
       	dr.recipient_blood_group,
        fr.urgency,
		request_status
    from analytics.fact_blood_requests fr
	join analytics.dim_recipients dr
		on dr.recipient_id=fr.recipient_id
    
)

select
    recipient_blood_group,
    count(*) as total_requests,
    sum(case when urgency = 'high' then 1 else 0 end) as high_urgency_requests,
    round(
        100.0 * sum(case when urgency = 'high' then 1 else 0 end)
        / count(*),
        2
    ) as high_urgency_percentage
from base
where request_status='active'
group by recipient_blood_group
order by high_urgency_percentage desc;