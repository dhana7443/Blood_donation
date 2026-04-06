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
        blood_group,
        status,
        donation_type,
        quantity,
        stg_load_timestamp

    from {{ ref('stg_blood_donations') }}

    {% if is_incremental() %}
    where stg_load_timestamp > (select max(stg_load_timestamp) from {{ this }})
    {% endif %}

),

with_dims as (

    select
        s.donation_id,
        ddonor.donor_sk,
        dh.hospital_sk,
        dr.recipient_sk,
        ddate.date_id as donation_date_id,
        s.status,
        s.blood_group,
        s.donation_type,
        s.quantity,
        s.stg_load_timestamp

    from src s

    left join {{ ref("dim_dates") }} ddate
      on s.donation_date = ddate.full_date

    left join {{ ref("dim_donors") }} ddonor
      on s.donor_id = ddonor.donor_id
     and s.donation_date >= ddonor.dbt_valid_from
     and s.donation_date < coalesce(ddonor.dbt_valid_to, '9999-12-31')

    left join {{ ref("dim_hospitals") }} dh
      on s.hospital_id = dh.hospital_id
     and s.donation_date >= dh.dbt_valid_from
     and s.donation_date < coalesce(dh.dbt_valid_to, '9999-12-31')

    left join {{ ref("dim_recipients") }} dr
      on s.recipient_id = dr.recipient_id
     and s.donation_date >= dr.dbt_valid_from
     and s.donation_date < coalesce(dr.dbt_valid_to, '9999-12-31')

)

select
    donation_id,
    donor_sk,
    hospital_sk,
    recipient_sk,
    donation_date_id,
    status,
    blood_group,
    donation_type,
    quantity,
    stg_load_timestamp

from with_dims