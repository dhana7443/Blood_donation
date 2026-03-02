{{ 
  config(
    materialized = 'incremental',
    unique_key = 'donation_id',
    incremental_strategy = 'merge'
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
        md5(coalesce(status, '')) as row_hash

    from {{ ref('stg_donations') }}

),

with_dims as (

    select
        s.donation_id,
        ddonor.donor_sk,
        dh.hospital_sk,
        dr.recipient_sk,
        ddate.date_id as donation_date_id,
        s.status,
        s.donation_type,
        s.quantity,
        s.row_hash
    from src s
    join {{ ref("dim_dates") }} ddate
      on s.donation_date = ddate.full_date

    join {{ ref("dim_donors") }} ddonor
      on s.donor_id = ddonor.donor_id
     and s.donation_date >= ddonor.dbt_valid_from
     and s.donation_date < coalesce(ddonor.dbt_valid_to,'9999-12-31')

    left join {{ ref("dim_hospitals") }} dh
      on s.hospital_id = dh.hospital_id
     and s.donation_date >= dh.dbt_valid_from
     and s.donation_date < coalesce(dh.dbt_valid_to,'9999-12-31')

    left join {{ ref("dim_recipients") }} dr
      on s.recipient_id = dr.recipient_id
     and s.donation_date >= dr.dbt_valid_from
     and s.donation_date < coalesce(dr.dbt_valid_to,'9999-12-31')

),

final as (

    select w.*
    from with_dims w

    {% if is_incremental() %}
    left join {{ this }} t
      on w.donation_id = t.donation_id

    where
          t.donation_id is null     
       or w.row_hash <> t.row_hash  
    {% endif %}

)

select
    donation_id,
    donor_sk,
    hospital_sk,
    recipient_sk,
    donation_date_id,
    status,
    donation_type,
    quantity,
    row_hash
from final
order by donation_id