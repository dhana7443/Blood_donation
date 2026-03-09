{{ 
    config(
        materialized='table'
    ) 
}}

with donations as (

    select
        donation_date_id,
        hospital_sk,
        status,
        quantity
    from {{ ref('fact_blood_donations') }}

    where status in ('complete','tested','distributed')

),

daily_summary as (

    select
        donation_date_id,
        hospital_sk,
        count(*) as total_donations,
        sum(quantity) as total_quantity
    from donations
    group by
        donation_date_id,
        hospital_sk

)

select *
from daily_summary
order by donation_date_id