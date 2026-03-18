{{
    config(
        materialized ='incremental',
        unique_key = 'inventory_id',
        incremental_strategy='merge'
    )
}}

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
        volume,
        md5(
            concat_ws(
                '|',
                coalesce(status,''),
                coalesce(quality,''),
                coalesce(blood_group,''),
                coalesce(cast(units_available as varchar),''),
                coalesce(cast(volume as varchar),''),
                coalesce(cast(date_received as varchar),''),
                coalesce(cast(expiration_date as varchar),'')
            )
        ) as row_hash
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
        s.volume,
        s.row_hash
    from src s
    left join {{ ref("dim_dates")}} d
    on d.full_date=s.date_received

    left join {{ ref("dim_dates")}} de
    on de.full_date=s.expiration_date
),
final as(
    select w.*
    from dated w

    {% if is_incremental() %}
    left join {{ this }} t
        on w.inventory_id=t.inventory_id

    where
        t.inventory_id is null
        or w.row_hash <> t.row_hash
    {% endif %}
)

select * from final
