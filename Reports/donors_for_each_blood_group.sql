select
    donor_blood_group,
    count(donor_id) as total_donors
from analytics.dim_donors 
group by donor_blood_group
order by total_donors desc;

