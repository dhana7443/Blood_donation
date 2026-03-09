SELECT
  CAST(technician_id AS BIGINT)        AS technician_id,
  CAST(hospital_id AS BIGINT)          AS hospital_id,
  CAST(assigned_hospital_id AS BIGINT) AS assigned_hospital_id,
  INITCAP(TRIM(name))                  AS name,
  INITCAP(TRIM(qualification))                AS qualification,
  TRIM(phone_number)                   AS phone_number,
  TRIM(email_address)                  AS email_address,
  load_timestamp as raw_load_timestamp

FROM {{ source('raw', 'technicians') }}
