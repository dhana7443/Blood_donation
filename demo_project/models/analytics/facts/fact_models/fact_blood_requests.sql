{{
    config(
        materialized='incremental',
        unique_key='request_id',
        incremental_strategy='delete+insert'
    )
}}

with snap as (

    select
        request_id,
        recipient_id,
        hospital_id,
        required_date,
        urgency,
        request_status,
        stg_load_timestamp
        
        
    from {{ ref("stg_requests") }}

    {% if is_incremental() %}
    where stg_load_timestamp > (
        select coalesce(max(stg_load_timestamp), '1900-01-01')
        from {{ this }}
    )
    {% endif %}
),

final as (

    select

        s.request_id,
        s.recipient_id,
        s.hospital_id,
        dd.date_id as required_date_id,
        s.urgency,
        CASE
            WHEN request_id is not null THEN 1
            ELSE 0
        END AS units_required,
        s.request_status,
        s.stg_load_timestamp

    from snap s

    left join {{ ref("dim_dates") }} dd
        on dd.full_date = s.required_date
    

)

select * from final