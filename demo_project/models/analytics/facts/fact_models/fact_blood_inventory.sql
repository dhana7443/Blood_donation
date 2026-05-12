{{
    config(
        materialized = 'incremental',
        unique_key = 'inventory_id',
        incremental_strategy = 'delete+insert',
        indexes = [
            {'columns': ['inventory_id'], 'unique': True}
        ]
    )
}}

with src as (

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
        stg_load_timestamp

    from {{ ref("stg_blood_inventory") }}

    {% if is_incremental() %}
        where
            stg_load_timestamp
            > (
                select
                    coalesce(
                        max({{ this }}.stg_load_timestamp),
                        '1900-01-01'
                    )
                from {{ this }}
            )
    {% endif %}

),

dated as (

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
        s.stg_load_timestamp

    from src as s

    left join {{ ref("dim_dates") }} as d
        on s.date_received = d.full_date

    left join {{ ref("dim_dates") }} as de
        on s.expiration_date = de.full_date

)

select
    inventory_id,
    donation_id,
    blood_group,
    status,
    quality,
    date_received_id,
    expiration_date_id,
    units_available,
    volume,
    stg_load_timestamp

from dated
