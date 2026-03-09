{% snapshot recipient_requests_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='recipient_id',
        strategy='check',
        check_cols=['hospital_id','required_date','urgency']
    )
}}

select
    recipient_id,
    hospital_id,
    blood_group,
    required_date,
    urgency
from {{ ref("stg_recipients") }}

{% endsnapshot %}