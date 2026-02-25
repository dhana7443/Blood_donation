{% snapshot recipients_snapshot%}
{{
    config(
            target_schema='snapshots',
            unique_key='recipient_id',
            strategy='check',
            check_cols=['name','blood_group','location']
        )
}}
select
    recipient_id,
    name,
    blood_group,
    location
from {{ref("stg_recipients")}}
    
{% endsnapshot %}