{{
    config(
        materialized = 'table'
    )
}}

with src as (

    select
        recipient_id,
        name,
        blood_group,
        location

    from {{ ref('stg_recipients') }}

),

final as (

    select
        recipient_id,
        name,
        blood_group as recipient_blood_group,
        location,
        true as is_current
    from src

)

select * from final