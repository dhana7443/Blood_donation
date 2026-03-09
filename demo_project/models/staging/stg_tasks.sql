SELECT
  CAST(task_id AS BIGINT) AS task_id,
  TRIM(description)      AS description,
  load_timestamp as raw_load_timestamp
FROM {{ source('raw', 'tasks') }}
