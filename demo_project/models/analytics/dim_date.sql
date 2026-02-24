with date_spine as(
    select generate_series(
        date '2020-01-01',
        date '2030-12-31',
        interval '1 day'
    )::date as full_date
),
final as(
    select
        to_char(full_date,'YYYYMMDD')::int as date_id,
        full_date,
        extract(day from full_date)::int as day,
        extract(month from full_date)::int as month,
        to_char(full_date,'Month') as month_name,
        extract(year from full_date)::int as year
    from date_spine
)
select * from final