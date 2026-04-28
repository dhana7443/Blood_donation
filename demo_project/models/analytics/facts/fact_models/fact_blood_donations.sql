{{ 
  config(
    materialized = 'incremental',
    unique_key = 'donation_id',
    incremental_strategy = 'delete+insert'
  ) 
}}

with src as (

    select
        donation_id,
        donor_id,
        hospital_id,
        recipient_id,
        donation_date,
        status,
        donation_type,
        quantity,
        stg_load_timestamp

    from {{ ref('stg_blood_donations') }}

    {% if is_incremental() %}
    where stg_load_timestamp > (select coalesce(max(stg_load_timestamp), '1900-01-01') from {{ this }})
    {% endif %}

),

with_dims as (

    select
        s.donation_id,
        s.donor_id,
        s.hospital_id,
        s.recipient_id,
        ddate.date_id as donation_date_id,
        s.status,
        s.donation_type,
        s.quantity,
        s.stg_load_timestamp

    from src s

    left join {{ ref("dim_dates") }} ddate
      on s.donation_date = ddate.full_date


)

select
    donation_id,
    donor_id,
    hospital_id,
    recipient_id,
    donation_date_id,
    status,
    donation_type,
    quantity,
    stg_load_timestamp

from with_dims