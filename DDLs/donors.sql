CREATE TABLE raw.donors (
  donor_id                    TEXT,  -- Unique identifier for each donor
  registered_by_staff_id      TEXT,  -- Identifier for the staff member who registered this donor
  primary_contact_id          TEXT,  -- Identifier for the primary contact of this donor
  name                        TEXT,  -- Full name of the donor
  age                         TEXT,  -- Age of the donor
  gender                      TEXT,  -- Gender of the donor
  weight                      TEXT,  -- Weight of the donor in kilograms
  blood_group                 TEXT,  -- Blood group of the donor
  last_donation_date          TEXT,  -- The last date the donor donated blood
  is_eligible                 TEXT,  -- Whether the donor is currently eligible to donate
  donations_count             TEXT,  -- Total number of donations made by the donor
  contact_method_type         TEXT,  -- Preferred contact method of the donor
  contact_detail              TEXT,  -- Contact detail corresponding to the selected contact method
  donor_type                  TEXT,  -- Type of donor
  notes                       TEXT,  -- Additional notes about the donor
  last_health_check_date      TEXT,  -- Date of the last health check for the donor
  donation_frequency_allowed  TEXT,  -- Frequency of donations allowed per year
  location                    TEXT,  -- Geographical location of the donor
  days_since_last_donation    TEXT,  -- Calculated days since the last donation
  blood_group_A_plus          TEXT,
  blood_group_O_minus         TEXT,
  blood_group_B_plus          TEXT,
  blood_group_AB_minus        TEXT,
  blood_group_A_minus         TEXT,
  blood_group_B_minus         TEXT,
  blood_group_O_plus          TEXT,
  blood_group_AB_plus         TEXT
);

