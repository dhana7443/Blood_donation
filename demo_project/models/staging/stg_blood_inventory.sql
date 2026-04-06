{{
  config(
    materialized='incremental',
    unique_key='inventory_id',
    incremental_strategy='delete+insert'
  )
}}

SELECT
  CAST(inventory_id AS BIGINT)      AS inventory_id,
  CAST(donation_id AS BIGINT)       AS donation_id,
  UPPER(TRIM(blood_group))              AS blood_group,
  CAST(units_available AS INT)      AS units_available,
  INITCAP(TRIM(quality))                  AS quality,
  LOWER(TRIM(status))               AS status,
  CAST(NULLIF(date_received,'0000-00-00') AS DATE)       AS date_received,
  CAST(NULLIF(expiration_date,'0000-00-00') AS DATE)     AS expiration_date,
  CAST(temperature AS NUMERIC(3,1)) AS temperature,
  CAST(volume AS INT)               AS volume,
  CAST(NULLIF(recipient_id,'') AS NUMERIC)::BIGINT AS recipient_id,
  {{ current_timestamp() }}         AS stg_load_timestamp
  
FROM {{ source('raw', 'blood_inventory') }}
