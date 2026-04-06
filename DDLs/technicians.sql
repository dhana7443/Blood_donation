CREATE TABLE raw.technicians (
  technician_id         TEXT,  -- Unique identifier for each technician
  hospital_id           TEXT,  -- Identifier for the primary hospital where the technician works
  assigned_hospital_id  TEXT,  -- Identifier for the secondary hospital where the technician may be assigned
  name                  TEXT,  -- Full name of the technician
  qualification         TEXT,  -- Professional qualifications and certifications
  phone_number          TEXT,  -- Primary contact phone number
  email_address         TEXT   -- Primary contact email address
);

-- copy command to load data into the technicians table

\copy raw.technicians FROM 'C:\Users\Dhanalakshmi Karri\Downloads\technicians.csv' WITH(FORMAT csv,HEADER,NULL '');