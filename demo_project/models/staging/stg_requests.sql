{{
  config(
    materialized='incremental',
    unique_key='request_id',
    incremental_strategy='delete+insert'
  )
}}

SELECT
    CAST(request_id AS BIGINT)            AS request_id,
    CAST(recipient_id AS BIGINT)          AS recipient_id,
    CAST(hospital_id AS BIGINT)           AS hospital_id,
    UPPER(TRIM(blood_group))              AS recipient_blood_group,
    CAST(required_date AS DATE)           AS required_date,
    LOWER(TRIM(urgency))                  AS urgency,
    CASE
        WHEN required_date >= CURRENT_DATE THEN 'active'
        ELSE 'completed'
    END AS request_status,
    {{ current_timestamp() }}             AS stg_load_timestamp

FROM {{ source('raw', 'requests') }}