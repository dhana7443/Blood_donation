with snap as (
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
ranked as (
    select
        *,
        row_number() over(partition by donor_id order by dbt_valid_from) as rn
    from snap
),
fixed as (
    select
        donor_id,
        name,
        gender,
        donor_blood_group,
        is_eligible,
        location,
        case
            when rn=1 then timestamp '2020-01-01'
            else dbt_valid_from
        end as dbt_valid_from,
        dbt_valid_to
    from ranked
),
final as(
    select
        {{ dbt_utils.generate_surrogate_key([
            'donor_id',
            'dbt_valid_from'
        ])}} as donor_sk,
        *,
        case
            when dbt_valid_to is null then true
            else false
        end as is_current
    from fixed
)
select * from final