{{
    config(
        materialized='incremental',
        unique_key='test_id',
        incremental_strategy='delete+insert'
    )
}}

with src as (

    select
        test_id,
        donor_id,
        test_date,
        disease_tested,
        result,
        test_type,
        stg_load_timestamp

    from {{ ref("stg_blood_tests") }}

    {% if is_incremental() %}
    where stg_load_timestamp > (
        select coalesce(max(stg_load_timestamp), '1900-01-01')
        from {{ this }}
    )
    {% endif %}

),

final as (

    select
        s.test_id,
        s.donor_id,
        ddate.date_id as test_date_id,
        s.disease_tested,
        s.result,
        s.test_type,
        s.stg_load_timestamp

    from src s

    left join {{ ref("dim_dates") }} ddate
        on s.test_date = ddate.full_date

)

select * from final