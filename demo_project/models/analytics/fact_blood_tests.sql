with src as(
    select
        test_id,
        donor_id,
        test_date,
        disease_tested,
        result,
        test_type
    from {{ref("stg_blood_tests")}}
),
dated as(
    select
        s.test_id,
        s.donor_id,
        d.date_id as test_date_id,
        s.disease_tested,
        s.result,
        s.test_type
    from src s
    join {{ref("dim_dates")}} d
    on s.test_date=d.full_date
)

select * from dated