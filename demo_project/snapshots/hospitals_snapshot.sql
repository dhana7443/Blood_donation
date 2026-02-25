{% snapshot hospitals_snapshot%}

{{
    config(
        target_schema='snapshots',
        unique_key='hospital_id',
        strategy='check',
        check_cols=['name','city','country','hospital_type','accreditation_status']
    )
}}

select
        hospital_id,
        name,
        city,
        country,
        hospital_type,
        accreditation_status
    from {{ ref('stg_hospitals') }}

{% endsnapshot %}