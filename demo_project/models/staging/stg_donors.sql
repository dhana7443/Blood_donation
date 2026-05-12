{{
  config(
    materialized='incremental',
    unique_key='donor_id',
    incremental_strategy='delete+insert',
  )
}}
SELECT
    notes,
    CAST(donor_id AS BIGINT) AS donor_id,
    CAST(registered_by_staff_id AS BIGINT) AS registered_by_staff_id,
    CAST(primary_contact_id AS BIGINT) AS primary_contact_id,
    INITCAP(TRIM(name)) AS donor_name,
    CAST(age AS INT) AS age,
    INITCAP(TRIM(gender)) AS gender,
    CAST(weight AS NUMERIC(5, 2)) AS weight,
    UPPER(TRIM(blood_group)) AS blood_group,
    CAST(NULLIF(last_donation_date, '0000-00-00') AS DATE)
        AS last_donation_date,
    CAST(is_eligible AS BOOLEAN) AS is_eligible,
    CAST(donations_count AS INT) AS donations_count,
    LOWER(TRIM(contact_method_type)) AS contact_method_type,
    TRIM(contact_detail) AS contact_detail,
    LOWER(TRIM(donor_type)) AS donor_type,
    CAST(NULLIF(last_health_check_date, '0000-00-00') AS DATE)
        AS last_health_check_date,
    CAST(donation_frequency_allowed AS INT) AS donation_frequency_allowed,
    INITCAP(TRIM(location)) AS donor_location,
    CAST(days_since_last_donation AS INT) AS days_since_last_donation,
    CAST(blood_group_a_plus AS BOOLEAN) AS blood_group_a_plus,
    CAST(blood_group_o_minus AS BOOLEAN) AS blood_group_o_minus,
    CAST(blood_group_b_plus AS BOOLEAN) AS blood_group_b_plus,
    CAST(blood_group_ab_minus AS BOOLEAN) AS blood_group_ab_minus,
    CAST(blood_group_a_minus AS BOOLEAN) AS blood_group_a_minus,
    CAST(blood_group_b_minus AS BOOLEAN) AS blood_group_b_minus,
    CAST(blood_group_o_plus AS BOOLEAN) AS blood_group_o_plus,
    CAST(blood_group_ab_plus AS BOOLEAN) AS blood_group_ab_plus,
    NOW() AS stg_load_timestamp

FROM {{ source('raw', 'donors') }}
