with last_donation as (

    select
        f.donor_id,
        max(dd.full_date) as last_donation_date
    from analytics.fact_blood_donations f
    join analytics.dim_dates dd
        on f.donation_date_id = dd.date_id
    where f.status in ('complete','tested','distributed')
    group by f.donor_id

),

current_donors as (

    select
        donor_id,
        donor_blood_group,
        is_eligible
    from analytics.dim_donors

),

at_risk as (

    select
        cd.donor_id,
        cd.donor_blood_group,
        ld.last_donation_date,
        current_date - ld.last_donation_date as days_since_last_donation
    from current_donors cd
    left join last_donation ld
        on cd.donor_id = ld.donor_id
    where
          cd.is_eligible = true
      and (
            ld.last_donation_date is null
            or current_date - ld.last_donation_date > 180
          )

)
select donor_blood_group,count(*) as donors_at_risk from at_risk
group by donor_blood_group
order by donors_at_risk  desc
