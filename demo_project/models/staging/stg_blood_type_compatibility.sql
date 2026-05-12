SELECT
    NULLIF(UPPER(TRIM(donor_blood_type)), '') AS donor_blood_type,
    NULLIF(UPPER(TRIM(recipient_blood_type)), '') AS recipient_blood_type,
    NOW() AS stg_load_timestamp

FROM {{ source('raw', 'blood_type_compatibility') }}
