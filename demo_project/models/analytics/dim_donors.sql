with source as (
    select
        donor_id,
        name,
        gender,
        blood_group     as donor_blood_group,
        is_eligible,
        location,
        dbt_valid_from,
        dbt_valid_to
    from {{ ref('donors_snapshot') }}
),
final as(
    select
        *,
        case
            when dbt_valid_to is null then true
            else false
        end as is_current
    from source
)
select * from final