{% snapshot donors_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='donor_id',
        strategy='check',
        check_cols=['name','gender','blood_group','is_eligible','location'],
        
    )
}}

select
    donor_id,
    name,
    gender,
    blood_group,
    is_eligible,
    location
from {{ref("stg_donors")}}

{% endsnapshot%}