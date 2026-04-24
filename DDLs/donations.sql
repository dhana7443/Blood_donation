CREATE TABLE raw.donations (
  donation_id                TEXT,  -- Unique identifier for each donation
  donor_id                   TEXT,  -- Identifier of the donor who made this donation
  hospital_id                TEXT,  -- Identifier of the hospital where this donation took place
  recipient_id               TEXT,  -- Identifier of the recipient for this donation
  collection_technician_id   TEXT,  -- Identifier of the technician who collected this donation
  processed_by_technician_id TEXT,  -- Identifier of the technician who processed this donation
  test_result_id             TEXT,  -- Identifier of the test result associated with this donation
  date                        TEXT,  -- Date of the donation
  quantity                    TEXT,  -- Quantity of blood donated
  blood_group                 TEXT,  -- Blood group of the donated blood
  status                      TEXT,  -- Status (pending, complete, tested, distributed, etc.)
  bag_serial_number           TEXT,  -- Bag serial number
  storage_temperature         TEXT,  -- Temperature at which the blood was stored
  expiration_date             TEXT,  -- Expiration date
  donation_type               TEXT   -- Type of donation (whole_blood, platelets, plasma, etc.)
)

