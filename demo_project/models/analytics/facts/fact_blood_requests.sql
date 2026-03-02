{{
    config(
        materialized='incremental',
        unique_key='request_id',
        incremental_strategy='merge'
    )
}}

with snap as(
    select
        recipient_id,
        hospital_id,
        required_date,
        urgency,
        dbt_valid_from,
        dbt_valid_to
    from {{ ref("recipient_requests_snapshot") }}
),
ranked as (
    select
        *,
        row_number() over(partition by recipient_id order by dbt_valid_from) as rnk
    from snap
),
fixed as(
    select
        recipient_id,
        hospital_id,
        required_date,
        urgency,
        case
            when rnk=1 then timestamp '2020-01-01'
            else dbt_valid_from
        end as dbt_valid_from,
        dbt_valid_to
    from ranked
),
dims as (
    select
        {{ dbt_utils.generate_surrogate_key ([
            's.recipient_id',
            's.hospital_id',
            's.required_date',
            's.urgency'
        ]) }} as request_id,
        dr.recipient_sk,
        dh.hospital_sk,
        dd.date_id as required_date_id,
        s.urgency
    from fixed s

    join {{ ref("dim_dates") }} dd
        on dd.full_date=s.required_date

    join {{ ref("dim_recipients") }} dr
        on s.recipient_id=dr.recipient_id
        and s.required_date >= dr.dbt_valid_from
        and s.required_date < coalesce(dr.dbt_valid_to,'9999-12-31')

    left join {{ ref("dim_hospitals")}} dh
        on s.hospital_id=dh.hospital_id
        and s.required_date >= dh.dbt_valid_from
        and s.required_date < coalesce(dh.dbt_valid_to,'9999-12-31')

),
final as (
    select f.*
    from dims f

    {% if is_incremental() %}
    left join {{ this }} t
        on f.request_id=t.request_id
    
    where t.request_id is null
    {% endif %}
)
select * from final