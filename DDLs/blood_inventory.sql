CREATE TABLE raw.blood_inventory (
  inventory_id      TEXT,   -- Unique identifier for inventory items (from source)
  donation_id       TEXT,   -- Reference to the donation from which this blood unit originated
  blood_group       TEXT,   -- Blood group category
  units_available   TEXT,   -- Number of units available
  quality           TEXT,   -- Quality status of the blood (Good, Contaminated, etc.)
  status            TEXT,   -- Current status (stored, tested, distributed, discarded, etc.)
  date_received     TEXT,   -- The date when the blood unit was received
  expiration_date   TEXT,   -- The expiration date for the blood unit
  temperature       TEXT,   -- Storage temperature in Celsius
  volume            TEXT,   -- Volume in milliliters (ml)
  recipient_id      TEXT    -- Recipient identifier
);

