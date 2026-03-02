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

INSERT INTO raw.recipients (recipient_id, hospital_id, name, age, blood_group, required_date, urgency, location) VALUES
(1, NULL, 'Alex Johnson', 45, 'A+', '2023-06-15', 'medium', 'Gatineau'),
(2, NULL, 'Maria Rodriguez', 37, 'O-', '2023-07-20', 'low', 'Longueuil'),
(3, 3, 'David Smith', 29, 'B+', '2023-05-11', 'high', 'Granby'),
(4, 4, 'Emma Wilson', 53, 'AB-', '2023-08-04', 'medium', 'Dollard-Des Ormeaux'),
(5, 5, 'Michael Brown', 62, 'A-', '2023-09-09', 'low', 'Repentigny'),
(6, 6, 'Sophia Davis', 26, 'O+', '2023-10-12', 'high', 'Dollard-Des Ormeaux'),
(7, 7, 'James Garcia', 34, 'B-', '2023-11-06', 'medium', 'Mascouche'),
(8, 8, 'Isabella Martinez', 47, 'AB+', '2023-04-21', 'low', 'Laval'),
(9, 9, 'William Anderson', 39, 'A+', '2023-03-15', 'high', 'Longueuil'),
(10, 10, 'Olivia Thomas', 55, 'O-', '2023-12-20', 'medium', 'Repentigny'),
(11, 11, 'Benjamin Lee', 43, 'B+', '2023-01-11', 'low', 'Mascouche'),
(12, 12, 'Charlotte Jones', 50, 'AB-', '2023-02-04', 'high', 'Gatineau'),
(13, 13, 'Lucas White', 28, 'A-', '2023-06-09', 'medium', 'Sherbrooke'),
(14, 14, 'Mia Harris', 31, 'O+', '2023-07-12', 'low', 'Saint-Jean-sur-Richelieu'),
(15, 15, 'Mason Clark', 36, 'B-', '2023-05-06', 'high', 'Dollard-Des Ormeaux'),
(16, 16, 'Amelia Young', 41, 'AB+', '2023-03-21', 'medium', 'Drummondville'),
(17, 17, 'Elijah Allen', 59, 'A+', '2023-11-15', 'low', 'Longueuil'),
(18, 18, 'Harper Walker', 24, 'O-', '2023-08-20', 'high', 'Côte-Saint-Luc'),
(19, 19, 'Ethan King', 38, 'B+', '2023-09-11', 'medium', 'Brossard'),
(20, 20, 'Ava Wright', 48, 'AB-', '2023-04-04', 'low', 'Brossard');