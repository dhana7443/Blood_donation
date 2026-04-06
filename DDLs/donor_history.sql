CREATE TABLE raw.donor_history (
  history_id   TEXT,  -- Unique identifier for each donor history record
  donor_id     TEXT,  -- Identifier for the donor
  donation_id  TEXT,  -- Identifier for the donation associated with this donor history
  reaction     TEXT,  -- Type of reaction (none, mild, severe, etc.)
  notes        TEXT   -- Additional notes or details about the donor’s history
);

-- copy command to load data into the donor_history table
\copy raw.donor_history FROM 'C:\Users\Dhanalakshmi Karri\Downloads\donor_history.csv' WITH(FORMAT csv,HEADER,NULL '');