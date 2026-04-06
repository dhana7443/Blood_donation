CREATE TABLE raw.recipients (
  recipient_id   TEXT,  -- Unique identifier for each recipient
  hospital_id    TEXT,  -- Unique identifier for each hospital
  name           TEXT,  -- Full name of the blood recipient
  age            TEXT,  -- Age of the recipient
  blood_group    TEXT,  -- Blood group of the recipient
  required_date  TEXT,  -- Date when the blood is required
  urgency        TEXT,  -- Urgency level (low, medium, high, etc.)
  location       TEXT   -- Location of the recipient
);

-- copy command to load data into the recipients table
\copy raw.recipients FROM 'C:\Users\Dhanalakshmi Karri\Downloads\recipients.csv' WITH(FORMAT csv,HEADER,NULL '');