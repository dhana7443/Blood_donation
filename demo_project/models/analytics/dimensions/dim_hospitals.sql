with snap as (

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
ranked as(
    select
        *,
        row_number() over(partition by hospital_id order by dbt_valid_from) as rn
    from snap
),
fixed as(
    select
        hospital_id,
        name,
        city,
        country,
        hospital_type,
        accreditation_status,
        case
            when rn=1 then timestamp '2020-01-01'
            else dbt_valid_from
        end as dbt_valid_from,
        dbt_valid_to
    from ranked
),
final as (
    select 
        {{ 
            dbt_utils.generate_surrogate_key([
                'hospital_id',
                'dbt_valid_from'
            ])
        }} as hospital_sk,
        *,
        case
            when dbt_valid_to is null then true
            else false
        end as is_current
    from fixed
)
select * from final