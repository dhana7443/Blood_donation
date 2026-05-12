{{
    config(
        materialized='incremental',
        unique_key='request_id',
        incremental_strategy='delete+insert',
        indexes=[
            {'columns': ['request_id'], 'unique': True}
        ]
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
        where
            stg_load_timestamp
            > (
                select
                    coalesce(
                        max({{ this }}.stg_load_timestamp),
                        '1900-01-01'
                    )
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
        s.request_status,
        s.stg_load_timestamp,
        case
            when s.request_id is not null then 1
            else 0
        end as units_required

    from snap as s

    left join {{ ref("dim_dates") }} as dd
        on s.required_date = dd.full_date

)

select * from final
