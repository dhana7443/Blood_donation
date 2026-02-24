SELECT
  CAST(recipient_id AS BIGINT) AS recipient_id,
  CAST(hospital_id AS BIGINT)  AS hospital_id,
  INITCAP(TRIM(name))          AS name,
  CAST(age AS INT)             AS age,
  UPPER(TRIM(blood_group))     AS blood_group,
  CAST(NULLIF(required_date, '0000-00-00') AS DATE) AS required_date,
  LOWER(TRIM(urgency))         AS urgency,
  INITCAP(TRIM(location))      AS location

FROM {{ source('raw', 'recipients') }}
