CREATE TABLE raw.blood_type_compatibility (
  donor_blood_type      TEXT,
  recipient_blood_type  TEXT
);

INSERT INTO raw.blood_type_compatibility
(donor_blood_type, recipient_blood_type)
VALUES
-- A+
('A+', 'A+'),
('A+', 'AB+'),
 
-- A-
('A-', 'A+'),
('A-', 'A-'),
('A-', 'AB+'),
('A-', 'AB-'),
 
-- B+
('B+', 'B+'),
('B+', 'AB+'),
 
-- B-
('B-', 'B+'),
('B-', 'B-'),
('B-', 'AB+'),
('B-', 'AB-'),
 
-- AB+
('AB+', 'AB+'),
 
-- AB-
('AB-', 'AB+'),
('AB-', 'AB-'),
 
-- O+
('O+', 'A+'),
('O+', 'B+'),
('O+', 'O+'),
('O+', 'AB+'),
 
-- O-
('O-', 'A+'),
('O-', 'A-'),
('O-', 'B+'),
('O-', 'B-'),
('O-', 'AB+'),
('O-', 'AB-'),
('O-', 'O+'),
('O-', 'O-');