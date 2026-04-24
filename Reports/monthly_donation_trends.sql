select
    d.month,
    trim(d.month_name) as month_name,
    dd.donor_blood_group,
    count(f.donation_id) as total_donations,
	sum(quantity) as volume_collected
from analytics.fact_blood_donations f
left join analytics.dim_donors dd
	on dd.donor_id=f.donor_id

join analytics.dim_dates d
  on f.donation_date_id = d.date_id

where f.status in ('complete','tested','distributed') 

group by
    d.month,
    d.month_name,
    dd.donor_blood_group

order by
    d.month;