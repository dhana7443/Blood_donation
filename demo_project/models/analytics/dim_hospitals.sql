with source as (

    select
        hospital_id,
        name,
        city,
        country,
        hospital_type,
        accreditation_status,
        dbt_valid_from,
        dbt_valid_to
    from {{ ref('hospitals_snapshot') }}


),
final as (
    select 
        *,
        case
            when dbt_valid_to is null then true
            else false
        end as is_current
    from source
)
select * from final