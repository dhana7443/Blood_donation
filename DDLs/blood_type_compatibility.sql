CREATE TABLE raw.blood_type_compatibility (
  donor_blood_type      TEXT,
  recipient_blood_type  TEXT
);

-- copy command to load data into the blood_type_compatibility table
\copy raw.blood_type_compatibility FROM 'C:\Users\Dhanalakshmi Karri\Downloads\blood_type_compatibility.csv' WITH(FORMAT csv,HEADER,NULL '');