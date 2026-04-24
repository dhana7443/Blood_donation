select
    location,
    count(donor_id) as total_donors
from analytics.dim_donors
group by location
order by total_donors desc;