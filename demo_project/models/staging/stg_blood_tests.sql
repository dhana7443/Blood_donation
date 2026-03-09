SELECT
  CAST(test_id AS BIGINT)        AS test_id,
  CAST(donor_id AS BIGINT)       AS donor_id,
  CAST(technician_id AS BIGINT)  AS technician_id,
  CAST(NULLIF(date, '0000-00-00') AS DATE) AS test_date,
  INITCAP(TRIM(disease_tested))          AS disease_tested,
  INITCAP(TRIM(result))                   AS result,
  INITCAP(TRIM(test_type))              AS test_type,
  comments                       AS comments,
  load_timestamp as raw_load_timestamp
FROM {{ source('raw', 'blood_tests') }}
WHERE INITCAP(TRIM(disease_tested))<>''