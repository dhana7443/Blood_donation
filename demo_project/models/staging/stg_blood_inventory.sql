SELECT
  CAST(inventory_id AS BIGINT)      AS inventory_id,
  CAST(donation_id AS BIGINT)       AS donation_id,
  TRIM(blood_group)                 AS blood_group,
  CAST(units_available AS INT)      AS units_available,
  TRIM(quality)                     AS quality,
  LOWER(TRIM(status))               AS status,
  CAST(date_received AS DATE)       AS date_received,
  CAST(expiration_date AS DATE)     AS expiration_date,
  CAST(temperature AS NUMERIC(3,1)) AS temperature,
  CAST(volume AS INT)               AS volume,
  CAST(recipient_id AS BIGINT)      AS recipient_id
FROM {{ source ('raw', 'blood_inventory') }}
