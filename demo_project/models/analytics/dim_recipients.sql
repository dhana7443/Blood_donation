with source as (
    select
        recipient_id,
        name ,
        blood_group       as recipient_blood_group,
        location ,
        dbt_valid_from,
        dbt_valid_to
    from {{ ref('recipients_snapshot') }}
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
    from source
)

select * from final
