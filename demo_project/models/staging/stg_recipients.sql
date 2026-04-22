{{
  config(
    materialized='incremental',
    unique_key='recipient_id',
    incremental_strategy='delete+insert'
  )
}}

SELECT
  CAST(recipient_id AS BIGINT) AS recipient_id,
  INITCAP(TRIM(name))          AS name,
  CAST(age AS INT)             AS age,
  UPPER(TRIM(blood_group))     AS blood_group,
  INITCAP(TRIM(location))      AS location,
  {{ current_timestamp() }}    AS stg_load_timestamp
  

FROM {{ source('raw', 'recipients') }}
