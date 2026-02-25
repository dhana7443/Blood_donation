with src as(
    select
        inventory_id,
        donation_id,
        blood_group,
        status,
        quality,
        date_received,
        expiration_date,
        units_available,
        volume
    from {{ ref("stg_blood_inventory")}}
),
dated as(
    select 
        s.inventory_id,
        s.donation_id,
        s.blood_group,
        s.status,
        s.quality,
        d.date_id as date_received_id,
        de.date_id as expiration_date_id,
        s.units_available,
        s.volume
    from src s
    join {{ref("dim_dates")}} d
    on s.date_received=d.full_date
    join {{ref("dim_dates")}} de
    on s.expiration_date=de.full_date
)
select * from dated