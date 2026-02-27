with snap as (
    select
        recipient_id,
        name ,
        blood_group       as recipient_blood_group,
        location ,
        dbt_valid_from,
        dbt_valid_to
    from {{ ref('recipients_snapshot') }}
),
ranked as (
    select
        *,
        row_number() over(partition by recipient_id order by dbt_valid_from) as rn
    from snap
),
fixed as(
    select
        recipient_id,
        name ,
        recipient_blood_group,
        location ,
        case
            when rn=1 then timestamp '2020-01-01'
            else dbt_valid_from
        end as dbt_valid_from,
        dbt_valid_to
    from ranked

),
final as(
    select
        {{
            dbt_utils.generate_surrogate_key([
                'recipient_id',
                'dbt_valid_from'
            ])
        }} as recipient_sk,
        *,
        case
            when dbt_valid_to is null then true
            else false
        end as is_current
    from fixed
)

select * from final
