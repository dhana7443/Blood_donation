CREATE TABLE raw.hospitals (
  hospital_id           TEXT,  -- Unique identifier for each hospital
  name                  TEXT,  -- Name of the hospital
  street_address        TEXT,  -- Street address
  city                  TEXT,  -- City or municipality
  province              TEXT,  -- Province or state
  postal_code           TEXT,  -- Postal or ZIP code
  country               TEXT,  -- Country
  phone_number          TEXT,  -- Primary contact phone number
  email_address         TEXT,  -- Primary contact email address
  hospital_type         TEXT,  -- Type of hospital
  operating_hours       TEXT,  -- Operating hours of the hospital
  accreditation_status  TEXT,  -- Accreditation status
  emergency_contact     TEXT   -- Emergency contact number
);

