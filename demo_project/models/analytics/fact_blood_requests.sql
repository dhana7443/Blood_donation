with src as (

    select
        recipient_id,
        hospital_id,
        urgency,
        required_date   
    from {{ ref('stg_recipients') }}

),
dated as(

    select
        {{ dbt_utils.generate_surrogate_key([
            'recipient_id',
            'hospital_id',
            'required_date',
            'urgency'
        ]) }} as request_id,
        s.recipient_id,
        s.hospital_id,
        s.urgency,
        d.date_id as required_date_id
    from src s
    join {{ ref('dim_dates') }} d
      on s.required_date = d.full_date
)
select * from dated