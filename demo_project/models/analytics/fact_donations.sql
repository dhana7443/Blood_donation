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

with_dims as (

    select
        s.donation_id,
        ddonor.donor_sk,
        s.hospital_id,
        s.recipient_id,
        ddate.date_id as donation_date_id,
        s.status,
        s.donation_type,
        s.quantity
    from src s
    join {{ ref("dim_dates") }} ddate
      on s.donation_date = ddate.full_date

    join {{ ref("dim_donors") }} ddonor
    on s.donor_id=ddonor.donor_id
    and s.donation_date>=ddonor.dbt_valid_from
    and s.donation_date<coalesce(ddonor.dbt_valid_to,'9999-12-31')

    join {{ ref("dim_hospitals") }} dh
    on s.hospital_id=dh.hospital_id
    and s.donation_date>=dh.dbt_valid_from
    and s.donation_date<coalesce(dh.dbt_valid_to,'9999-12-31')

    join {{ ref("dim_recipients") }} dr
    on s.recipient_id=dr.recipient_id
    and s.donation_date>=dr.dbt_valid_from
    and s.donation_date<coalesce(dr.dbt_valid_to,'9999-12-31')

)

select * from with_dims