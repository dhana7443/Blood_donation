{{
    config(
        materialized = 'table'
    )
}}

with src as (

    select
        donor_id,
        name,
        gender,
        blood_group as donor_blood_group,
        is_eligible,
        location

    from {{ ref('stg_donors') }}

),


final as (

    select
        *,
        true as is_current
    from src

)

select * from final