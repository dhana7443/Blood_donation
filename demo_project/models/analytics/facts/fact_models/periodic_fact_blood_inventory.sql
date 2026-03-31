{{
    config(
        materialized='incremental',
        unique_key='snapshot_key',
        incremental_strategy='delete+insert'
    )
}}

with calendar as (

    select
        date_id,
        full_date
    from {{ ref('dim_dates') }}

    {% if is_incremental() %}
         where full_date >= current_date - interval '7 days'
    {% endif %}

),

inventory as (

    select
        inventory_id,
        blood_group,
        units_available,
        volume,
        date_received_id,
        expiration_date_id,
        status,
        quality
    from {{ ref('fact_blood_inventory') }}

),

expanded as (

    select
        c.date_id as snapshot_date_id,
        c.full_date as snapshot_date,
        i.blood_group,
        i.units_available,
        i.volume
    from calendar c
    join inventory i
        on c.date_id >= i.date_received_id
       and c.date_id <= i.expiration_date_id
       and i.status in ('stored','tested')
       and i.quality = 'Good'

),

aggregated as (

    select
        snapshot_date_id,
        snapshot_date,
        blood_group,
        sum(units_available) as total_units_available,
        sum(volume) as total_volume_available
    from expanded
    group by 1,2,3

)

select
    md5(concat(snapshot_date_id,'|',blood_group)) as snapshot_key,
    snapshot_date_id,
    snapshot_date,
    blood_group,
    total_units_available,
    total_volume_available
from aggregated