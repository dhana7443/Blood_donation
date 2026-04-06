{{
    config(
        materialized='incremental',
        unique_key='snapshot_key',
        incremental_strategy='delete+insert'
    )
}}

with inventory as (

    select
        inventory_id,
        blood_group,
        units_available,
        volume,
        date_received_id,
        expiration_date_id,
        status,
        quality,
        stg_load_timestamp
    from {{ ref('fact_blood_inventory') }}

    {% if is_incremental() %}
    where stg_load_timestamp > (select max(stg_load_timestamp) from {{ this }})
    {% endif %}

),

expanded as (

    select
        c.date_id as snapshot_date_id,
        c.full_date as snapshot_date,
        i.blood_group,
        i.units_available,
        i.volume,
        i.stg_load_timestamp
    from inventory i
    join {{ ref('dim_dates') }} c
        on c.date_id >= i.date_received_id
       and c.date_id <= i.expiration_date_id
       and i.status in ('stored', 'tested')
       and i.quality = 'Good'

),

aggregated as (

    select
        snapshot_date_id,
        snapshot_date,
        blood_group,
        sum(units_available) as total_units_available,
        sum(volume) as total_volume_available,
        max(stg_load_timestamp) as stg_load_timestamp
    from expanded
    group by 1, 2, 3

)

select
    md5(concat(snapshot_date_id, '|', blood_group)) as snapshot_key,
    snapshot_date_id,
    snapshot_date,
    blood_group,
    total_units_available,
    total_volume_available,
    stg_load_timestamp
from aggregated