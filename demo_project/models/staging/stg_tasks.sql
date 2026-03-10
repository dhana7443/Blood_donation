SELECT
  CAST(task_id AS BIGINT) AS task_id,
  TRIM(description)      AS description
  
FROM {{ source('raw', 'tasks') }}
