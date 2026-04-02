{{
  config(
    materialized='incremental',
    unique_key='test_id',
    incremental_strategy='delete+insert'
  )
}}
SELECT
  CAST(test_id AS BIGINT)        AS test_id,
  CAST(donor_id AS BIGINT)       AS donor_id,
  CAST(technician_id AS BIGINT)  AS technician_id,
  CAST(NULLIF(date, '0000-00-00') AS DATE) AS test_date,
  NULLIF(INITCAP(TRIM(disease_tested)),'')          AS disease_tested,
  INITCAP(TRIM(result))                   AS result,
  INITCAP(TRIM(test_type))              AS test_type,
  comments                       AS comments,
  {{ current_timestamp() }}     AS stg_load_timestamp
  
FROM {{ source('raw', 'blood_tests') }}

WHERE NOT (
  test_type = 'Disease Screening' 
  AND disease_tested is NULL
)
