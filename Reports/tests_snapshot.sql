with tests_per_day as (
    select 
		d.full_date,
		count(*) as total_tests
    from analytics.fact_blood_tests t
    join analytics.dim_dates d
      on t.test_date_id = d.date_id
    group by d.date_id,d.full_date
)

select
	full_date,
	total_tests
from tests_per_day
order by 1 desc