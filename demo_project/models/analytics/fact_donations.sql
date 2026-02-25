with src as (

    select
        donation_id,
        donor_id,
        hospital_id,
        recipient_id,
        donation_date,  
        status,
        donation_type,
        quantity
    from {{ ref('stg_donations') }}

),

dated as (

    select
        s.donation_id,
        s.donor_id,
        s.hospital_id,
        s.recipient_id,
        d.date_id as donation_date_id,  
        s.status,
        s.donation_type,
        s.quantity
    from src s
    join {{ ref('dim_dates') }} d
      on s.donation_date = d.full_date

)
select * from dated
order by donation_id