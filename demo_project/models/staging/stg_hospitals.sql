SELECT
  CAST(hospital_id AS BIGINT) AS hospital_id,
  INITCAP(TRIM(name))           AS name,
  INITCAP(TRIM(street_address)) AS street_address,
  INITCAP(TRIM(city))           AS city,
  INITCAP(TRIM(province))       AS province,
  INITCAP(TRIM(country))        AS country,
  TRIM(postal_code)             AS postal_code,
  TRIM(phone_number)            AS phone_number,
  TRIM(email_address)           AS email_address,
  INITCAP(TRIM(hospital_type))        AS hospital_type,
  TRIM(operating_hours)               AS operating_hours,
  INITCAP(TRIM(accreditation_status)) AS accreditation_status,
  TRIM(emergency_contact)             AS emergency_contact,
  load_timestamp as raw_load_timestamp
FROM {{ source('raw', 'hospitals') }}
