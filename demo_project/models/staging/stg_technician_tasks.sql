{{
  config(
    materialized='incremental',
    unique_key='technician_id',
    incremental_strategy='delete+insert'
  )
}}
SELECT
  CAST(technician_id AS BIGINT) AS technician_id,
  CAST(task_id AS BIGINT)       AS task_id,
  {{ current_timestamp() }}     AS stg_load_timestamp
  
FROM {{ source('raw', 'technician_tasks') }}
