{{
    config(
        materialized = 'table'
    )
}}

with src as (

    select
        hospital_id,
        name,
        city,
        country,
        hospital_type,
        accreditation_status

    from {{ ref('stg_hospitals') }}

),

final as (

    select
        *,
        true as is_current
    from src

)

select * from final