with source as (
    select
        recipient_id,
        name ,
        blood_group       as recipient_blood_group,
        location  
    from {{ ref('stg_recipients') }}
)

select * from source
