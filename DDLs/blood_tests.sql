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
INSERT INTO raw.blood_tests (test_id, donor_id, technician_id, date, disease_tested, result, test_type, comments) VALUES
(61, 1, 3, '2020-10-16', '', 'Positive', 'Blood Typing', 'Blood type A+'),
(62, 2, 4, '2021-01-21', 'HIV', 'Negative', 'Disease Screening', 'Clear of HIV'),
(63, 3, 3, '2021-02-19', '', 'Positive', 'Blood Typing', 'Blood type B+'),
(64, 4, 17, '2020-12-06', 'Hepatitis B', 'Negative', 'Disease Screening', 'No hepatitis B detected'),
(65, 5, 9, '2021-03-11', '', 'Positive', 'General Health', 'No health issues found'),
(66, 6, 6, '2020-09-23', 'HIV', 'Negative', 'Disease Screening', 'No HIV'),
(67, 7, 20, '2020-11-13', '', 'Positive', 'Blood Typing', 'Blood type O-'),
(68, 8, 9, '2021-01-31', 'Hepatitis B', 'Negative', 'Disease Screening', 'No issues detected'),
(69, 9, 16, '2020-08-20', '', 'Positive', 'General Health', 'Healthy donor'),
(70, 10, 11, '2021-03-06', 'HIV', 'Negative', 'Disease Screening', 'Negative result'),
(71, 11, 13, '2020-07-12', '', 'Positive', 'Blood Typing', 'Blood type AB+'),
(72, 12, 14, '2021-02-06', 'Hepatitis B', 'Negative', 'Disease Screening', 'Test is clear'),
(73, 13, 15, '2020-10-29', '', 'Positive', 'General Health', 'Good health'),
(74, 14, 5, '2021-04-10', 'HIV', 'Negative', 'Disease Screening', 'HIV test negative'),
(75, 15, 5, '2020-08-31', '', 'Positive', 'Blood Typing', 'Blood type A-'),
(76, 16, 7, '2021-01-16', 'Hepatitis B', 'Negative', 'Disease Screening', 'Negative for hepatitis B'),
(77, 17, 7, '2020-11-21', '', 'Positive', 'General Health', 'No health issues'),
(78, 18, 7, '2021-03-21', 'HIV', 'Negative', 'Disease Screening', 'All clear'),
(79, 19, 16, '2020-09-06', '', 'Positive', 'Blood Typing', 'Blood type O+'),
(80, 20, 16, '0000-00-00', 'Hepatitis B', 'Negative', 'Disease Screening', 'Hepatitis B not detected');