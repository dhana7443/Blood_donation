with source as (
    select
        donor_id,
        name,
        gender,
        blood_group     as donor_blood_group,
        is_eligible,
        location
    from {{ ref('stg_donors') }}
)
select * from source