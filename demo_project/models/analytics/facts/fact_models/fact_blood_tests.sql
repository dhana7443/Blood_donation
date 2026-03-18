{{
    config(
        materialized='incremental',
        unique_key='test_id',
        incremental_strategy='merge'
    )
}}

with src as(
    select
        test_id,
        donor_id,
        test_date,
        disease_tested,
        result,
        test_type,
        md5(
            concat_ws(
                '|',
                coalesce(result, ''),
                coalesce(disease_tested, ''),
                coalesce(test_type, '')
            )
        ) as row_hash
    from {{ref("stg_blood_tests")}}
),
dims as(
    select
        s.test_id,
        ddonor.donor_sk,
        ddate.date_id as test_date_id,
        s.disease_tested,
        s.result,
        s.test_type,
        s.row_hash
    from src s
    left join {{ref("dim_dates")}} ddate
    on s.test_date=ddate.full_date

    left join {{ ref("dim_donors") }} ddonor
    on s.donor_id = ddonor.donor_id
    and (
        (
            s.test_date >= ddonor.dbt_valid_from
            and s.test_date < coalesce(ddonor.dbt_valid_to,'9999-12-31')
        )
        or
        (
            s.test_date is null
            and ddonor.dbt_valid_to is null  
        )
    )

),
final as(
    select w.*
    from dims w

    {% if is_incremental() %}
    left join {{ this }} t
        on w.test_id=t.test_id
    
    where t.test_id is null
    or w.row_hash <> t.row_hash

    {% endif %}
)

select * from final
