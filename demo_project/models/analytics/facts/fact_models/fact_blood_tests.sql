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
    where stg_load_timestamp > (select max(stg_load_timestamp) from {{ this }})
    {% endif %}

),

dims as (

    select
        s.test_id,
        ddonor.donor_sk,
        ddate.date_id as test_date_id,
        s.disease_tested,
        s.result,
        s.test_type,
        s.stg_load_timestamp

    from src s

    left join {{ ref("dim_dates") }} ddate
        on s.test_date = ddate.full_date

    left join {{ ref("dim_donors") }} ddonor
        on s.donor_id = ddonor.donor_id
        and (
            (
                s.test_date >= ddonor.dbt_valid_from
                and s.test_date < coalesce(ddonor.dbt_valid_to, '9999-12-31')
            )
            or
            (
                s.test_date is null
                and ddonor.dbt_valid_to is null
            )
        )

)

select * from dims