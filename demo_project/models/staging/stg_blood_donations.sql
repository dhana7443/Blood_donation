{{
  config(
    materialized='incremental',
    unique_key='donation_id',
    incremental_strategy='delete+insert'
  )
}}

SELECT
  CAST(NULLIF(TRIM(donation_id),'') AS BIGINT)  AS donation_id,
  CAST(NULLIF(TRIM(donor_id),'') AS BIGINT)  AS donor_id,
  CAST(NULLIF(TRIM(hospital_id),'') AS BIGINT)  AS hospital_id,
  CAST(NULLIF(TRIM(recipient_id), '') AS NUMERIC)::BIGINT AS recipient_id,
  CAST(NULLIF(TRIM(collection_technician_id),'') AS BIGINT)   AS collection_technician_id,
  CAST(processed_by_technician_id AS BIGINT) AS processed_by_technician_id,
  CAST(test_result_id AS BIGINT)             AS test_result_id,
  CAST(NULLIF(date, '0000-00-00') AS DATE)            AS donation_date,
  CAST(quantity AS INT)                        AS quantity,
  UPPER(TRIM(blood_group))                     AS blood_group,
  NULLIF(LOWER(TRIM(status)), '')             AS status,
  NULLIF(TRIM(bag_serial_number),'')                      AS bag_serial_number,
  CAST(storage_temperature AS NUMERIC(10,0))   AS storage_temperature,
  CAST(NULLIF(expiration_date, '0000-00-00') AS DATE) AS expiration_date,
  LOWER(TRIM(donation_type))                   AS donation_type,
  {{ current_timestamp() }}                   AS stg_load_timestamp

FROM {{ source('raw', 'donations') }}
