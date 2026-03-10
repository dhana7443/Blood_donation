SELECT
  CAST(history_id AS BIGINT)   AS history_id,
  CAST(donor_id AS BIGINT)     AS donor_id,
  CAST(donation_id AS BIGINT)  AS donation_id,
  LOWER(TRIM(reaction))        AS reaction,
  notes                        AS notes
 

FROM {{ source('raw', 'donor_history') }}
