{{
  config(
    materialized='incremental',
    unique_key='task_id',
    incremental_strategy='delete+insert'
  )
}}
SELECT
  CAST(task_id AS BIGINT) AS task_id,
  TRIM(description)      AS description,
  {{ current_timestamp() }} AS stg_load_timestamp
  
FROM {{ source('raw', 'tasks') }}
