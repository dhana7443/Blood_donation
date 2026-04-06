CREATE TABLE raw.blood_tests (
  test_id        TEXT,  -- Unique identifier for each blood test
  donor_id       TEXT,  -- References the donor's unique identifier
  technician_id  TEXT,  -- References the technician responsible for the test
  date           TEXT,  -- Date the test was performed
  disease_tested TEXT,  -- Name of the disease tested
  result         TEXT,  -- Result of the test (Positive, Negative, etc.)
  test_type      TEXT,  -- The type of test performed
  comments       TEXT   -- Additional observations or notes
);

-- copy command to load data into the blood_tests table
\copy raw.blood_tests FROM 'C:\Users\Dhanalakshmi Karri\Downloads\blood_tests.csv' WITH(FORMAT csv,HEADER,NULL '');