
with donations_per_day as (
    select 
		d.full_date,
		count(*) as total_donations
    from analytics.fact_blood_donations f
    join analytics.dim_dates d
      on f.donation_date_id = d.date_id
    
     where f.status in ('complete','tested','distributed')
	 group by d.date_id,d.full_date
)


select
	full_date,
    total_donations
    
from donations_per_day
order by full_date desc;