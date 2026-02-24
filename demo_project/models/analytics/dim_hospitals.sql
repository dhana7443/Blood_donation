with source as (

    select
        hospital_id,
        name,
        city,
        country,
        hospital_type,
        accreditation_status
    from {{ ref('stg_hospitals') }}

)
select * from source