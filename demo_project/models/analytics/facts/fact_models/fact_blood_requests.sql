{{
    config(
        materialized='incremental',
        unique_key='request_id',
        incremental_strategy='merge'
    )
}}

with snap as (

    select
        recipient_id,
        hospital_id,
        blood_group,
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

dims as (

    select

        {{ dbt_utils.generate_surrogate_key([
            's.recipient_id',
            's.dbt_valid_from'
        ]) }} as request_id,
        dr.recipient_sk,
        dh.hospital_sk,
        s.blood_group,
        dd.date_id as required_date_id,
        s.required_date,
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
        and s.required_date >= dr.dbt_valid_from
        and s.required_date < coalesce(dr.dbt_valid_to,'9999-12-31')

    left join {{ ref("dim_hospitals") }} dh
        on s.hospital_id = dh.hospital_id
        and s.required_date >= dh.dbt_valid_from
        and s.required_date < coalesce(dh.dbt_valid_to,'9999-12-31')

)

select * from dims