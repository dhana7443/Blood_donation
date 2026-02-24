SELECT
  CAST(technician_id AS BIGINT) AS technician_id,
  CAST(task_id AS BIGINT)       AS task_id
FROM {{ source('raw', 'technician_tasks') }}
