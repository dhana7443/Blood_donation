{{
    config(
        materialized='incremental',
        unique_key='request_id',
        incremental_strategy='delete+insert'
    )
}}

with snap as (

    select
        recipient_id,
        hospital_id,
        required_date,
        urgency,
        dbt_valid_from,
        dbt_valid_to
        
    from {{ ref("recipient_requests_snapshot") }}

    {% if is_incremental() %}
    where
        dbt_valid_from >
        (
            select coalesce(max(dbt_valid_from),'1900-01-01')
            from {{ this }}
        )
        or
        coalesce(dbt_valid_to,'1900-01-01') > 
        (
            select coalesce(max(dbt_valid_to),'1900-01-01')
            from {{ this }}
        )
    {% endif %}
),

final as (

    select

        {{ dbt_utils.generate_surrogate_key([
            's.recipient_id',
            'dbt_valid_from'
        ]) }} as request_id,

        s.recipient_id,
        s.hospital_id,
        dr.recipient_blood_group,
        dd.date_id as required_date_id,
        s.urgency,
        s.dbt_valid_from,
        s.dbt_valid_to,

        case
            when s.dbt_valid_to is not null then 'closed'
            when s.required_date < current_date then 'expired'
            else 'active'
        end as request_status

    from snap s

    left join {{ ref("dim_dates") }} dd
        on dd.full_date = s.required_date
    
    left join {{ ref("dim_recipients") }} dr
        on s.recipient_id = dr.recipient_id
    

)

select * from final