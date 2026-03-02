CREATE TABLE raw.donors (
  donor_id                    TEXT,  -- Unique identifier for each donor
  registered_by_staff_id      TEXT,  -- Identifier for the staff member who registered this donor
  primary_contact_id          TEXT,  -- Identifier for the primary contact of this donor
  name                        TEXT,  -- Full name of the donor
  age                         TEXT,  -- Age of the donor
  gender                      TEXT,  -- Gender of the donor
  weight                      TEXT,  -- Weight of the donor in kilograms
  blood_group                 TEXT,  -- Blood group of the donor
  last_donation_date          TEXT,  -- The last date the donor donated blood
  is_eligible                 TEXT,  -- Whether the donor is currently eligible to donate
  donations_count             TEXT,  -- Total number of donations made by the donor
  contact_method_type         TEXT,  -- Preferred contact method of the donor
  contact_detail              TEXT,  -- Contact detail corresponding to the selected contact method
  donor_type                  TEXT,  -- Type of donor
  notes                       TEXT,  -- Additional notes about the donor
  last_health_check_date      TEXT,  -- Date of the last health check for the donor
  donation_frequency_allowed  TEXT,  -- Frequency of donations allowed per year
  location                    TEXT,  -- Geographical location of the donor
  days_since_last_donation    TEXT,  -- Calculated days since the last donation
  blood_group_A_plus          TEXT,
  blood_group_O_minus         TEXT,
  blood_group_B_plus          TEXT,
  blood_group_AB_minus        TEXT,
  blood_group_A_minus         TEXT,
  blood_group_B_minus         TEXT,
  blood_group_O_plus          TEXT,
  blood_group_AB_plus         TEXT
);
INSERT INTO raw.donors (donor_id, registered_by_staff_id, primary_contact_id, name, age, gender, weight, blood_group, last_donation_date, is_eligible, donations_count, contact_method_type, contact_detail, donor_type, notes, last_health_check_date, donation_frequency_allowed, location, days_since_last_donation, blood_group_A_plus, blood_group_O_minus, blood_group_B_plus, blood_group_AB_minus, blood_group_A_minus, blood_group_B_minus, blood_group_O_plus, blood_group_AB_plus) VALUES
(1, NULL, NULL, 'John Doe', 35, 'Male', 70.50, 'A+', '2020-10-15', 1, 5, 'phone', '514-123-4567', 'individual', 'Regular donor', '2020-10-01', 2, 'Montreal', 1209, 1, 0, 0, 0, 0, 0, 0, 0),
(2, NULL, NULL, 'Jane Smith', 29, 'Female', 65.20, 'O-', '2021-01-20', 1, 3, 'email', 'jane.smith@email.com', 'individual', 'New donor', '2021-01-10', 1, 'Quebec City', 1112, 0, 1, 0, 0, 0, 0, 0, 0),
(3, NULL, NULL, 'Alice Johnson', 42, 'Female', 58.30, 'B+', '2021-02-18', 1, 4, 'email', 'alice.johnson@email.com', 'individual', 'Frequent donor', '2021-02-01', 2, 'Laval', 1083, 0, 0, 1, 0, 0, 0, 0, 0),
(4, NULL, NULL, 'Michael Brown', 31, 'Male', 80.70, 'AB-', '2020-12-05', 1, 2, 'phone', '514-234-5678', 'individual', 'Occasional donor', '2020-11-20', 1, 'Sherbrooke', 1158, 0, 0, 0, 1, 0, 0, 0, 0),
(5, NULL, NULL, 'Emily Wilson', 26, 'Female', 54.10, 'A-', '2021-03-10', 1, 1, 'phone', '514-345-6789', 'individual', 'First-time donor', '2021-03-01', 1, 'Gatineau', 1063, 0, 0, 0, 0, 1, 0, 0, 0),
(6, NULL, NULL, 'Chris Green', 38, 'Male', 77.40, 'B-', '2020-09-22', 1, 4, 'email', 'chris.green@email.com', 'individual', 'Regular donor', '2020-09-10', 2, 'Longueuil', 1232, 0, 0, 0, 0, 0, 1, 0, 0),
(7, NULL, NULL, 'Olivia Harris', 33, 'Female', 60.60, 'O+', '2020-11-12', 1, 2, 'phone', '514-456-7890', 'individual', 'Occasional donor', '2020-11-01', 1, 'Trois-Rivières', 1181, 0, 0, 0, 0, 0, 0, 1, 0),
(8, NULL, NULL, 'Daniel White', 45, 'Male', 85.50, 'AB+', '2021-01-30', 1, 6, 'phone', '514-567-8901', 'individual', 'Frequent donor', '2021-01-15', 2, 'Drummondville', 1102, 0, 0, 0, 0, 0, 0, 0, 1),
(9, NULL, NULL, 'Sophia Martinez', 37, 'Female', 68.00, 'A+', '2020-08-19', 1, 3, 'email', 'sophia.martinez@email.com', 'individual', 'Regular donor', '2020-08-05', 1, 'Brossard', 1266, 1, 0, 0, 0, 0, 0, 0, 0),
(10, NULL, NULL, 'David Taylor', 50, 'Male', 90.30, 'B+', '2021-03-05', 1, 5, 'email', 'david.taylor@email.com', 'individual', 'Frequent donor', '2021-02-20', 2, 'Blainville', 1068, 0, 0, 1, 0, 0, 0, 0, 0),
(11, NULL, NULL, 'Linda Scott', 27, 'Female', 62.80, 'O-', '2020-07-11', 1, 1, 'phone', '514-678-9012', 'individual', 'New donor', '2020-06-30', 1, 'Saint-Jean-sur-Richelieu', 1305, 0, 1, 0, 0, 0, 0, 0, 0),
(12, NULL, NULL, 'Robert King', 39, 'Male', 75.40, 'A-', '2021-02-05', 1, 2, 'email', 'robert.king@email.com', 'individual', 'Occasional donor', '2021-01-22', 1, 'Granby', 1096, 0, 0, 0, 0, 1, 0, 0, 0),
(13, NULL, NULL, 'Maria Garcia', 34, 'Female', 59.70, 'AB-', '2020-10-28', 1, 3, 'phone', '514-789-0123', 'individual', 'Regular donor', '2020-10-15', 1, 'Repentigny', 1196, 0, 0, 0, 1, 0, 0, 0, 0),
(14, NULL, NULL, 'James Wilson', 48, 'Male', 82.60, 'B-', '2021-04-09', 1, 4, 'email', 'james.wilson@email.com', 'individual', 'Frequent donor', '2021-03-25', 2, 'Mascouche', 1033, 0, 0, 0, 0, 0, 1, 0, 0),
(15, NULL, NULL, 'Patricia Davis', 30, 'Female', 57.90, 'A+', '2020-08-30', 1, 1, 'phone', '514-890-1234', 'individual', 'First-time donor', '2020-08-15', 1, 'Côte-Saint-Luc', 1255, 1, 0, 0, 0, 0, 0, 0, 0),
(16, NULL, NULL, 'Charles Miller', 52, 'Male', 88.10, 'O+', '2021-01-15', 1, 3, 'email', 'charles.miller@email.com', 'individual', 'Occasional donor', '2020-12-31', 1, 'Dollard-Des Ormeaux', 1117, 0, 0, 0, 0, 0, 0, 1, 0),
(17, NULL, NULL, 'Jennifer Lee', 46, 'Female', 66.40, 'AB+', '2020-11-20', 1, 2, 'phone', '514-901-2345', 'individual', 'Regular donor', '2020-11-05', 1, 'Pointe-Claire', 1173, 0, 0, 0, 0, 0, 0, 0, 1),
(18, NULL, NULL, 'Kevin Harris', 41, 'Male', 78.50, 'B+', '2021-03-20', 1, 4, 'email', 'kevin.harris@email.com', 'individual', 'Frequent donor', '2021-03-05', 2, 'Dorval', 1053, 0, 0, 1, 0, 0, 0, 0, 0),
(19, NULL, NULL, 'Laura Moore', 28, 'Female', 63.30, 'A-', '2020-09-05', 1, 1, 'phone', '514-012-3456', 'individual', 'New donor', '2020-08-20', 1, 'Kirkland', 1249, 0, 0, 0, 0, 1, 0, 0, 0),
(20, NULL, NULL, 'Brian Jackson', 36, 'Male', 76.20, 'O-', '2021-02-25', 1, 5, 'email', 'brian.jackson@email.com', 'individual', 'Occasional donor', '2021-02-10', 1, 'Beaconsfield', 1076, 0, 1, 0, 0, 0, 0, 0, 0),
(21, NULL, NULL, 'Alex Tremblay', 32, 'Male', 78.30, 'A-', '2023-01-15', 1, 2, 'email', 'alex.tremblay@email.com', 'individual', 'Occasional donor', '2023-01-05', 2, 'Montreal', 22, 0, 0, 0, 0, 1, 0, 0, 0),
(22, NULL, NULL, 'Marie-Claire Séguin', 27, 'Female', 65.10, 'O+', '2023-02-20', 1, 4, 'phone', '514-658-2145', 'individual', 'New donor', '2023-02-10', 1, 'Quebec City', 17, 0, 0, 0, 0, 0, 0, 1, 0),
(23, NULL, NULL, 'Étienne Gagnon', 46, 'Male', 84.50, 'B+', '2022-11-25', 1, 5, 'email', 'etienne.gagnon@email.com', 'individual', 'Regular donor', '2022-11-15', 2, 'Laval', 73, 0, 0, 1, 0, 0, 0, 0, 0),
(24, NULL, NULL, 'Sophie Lavoie', 39, 'Female', 59.70, 'AB-', '2023-01-29', 1, 3, 'phone', '418-965-7894', 'individual', 'Frequent donor', '2023-01-19', 1, 'Sherbrooke', 39, 0, 0, 0, 1, 0, 0, 0, 0),
(25, NULL, NULL, 'Lucas Dupont', 31, 'Male', 76.20, 'O-', '2023-03-05', 1, 6, 'email', 'lucas.dupont@email.com', 'individual', 'First-time donor', '2023-02-23', 2, 'Gatineau', 5, 0, 1, 0, 0, 0, 0, 0, 0),
(26, NULL, NULL, 'Gabrielle Mercier', 34, 'Female', 62.40, 'A+', '2022-12-15', 1, 7, 'phone', '514-234-5678', 'individual', 'Active donor', '2022-12-05', 2, 'Longueuil', 53, 1, 0, 0, 0, 0, 0, 0, 0),
(27, NULL, NULL, 'Jean-Francois Morin', 29, 'Male', 82.30, 'B-', '2023-02-28', 1, 3, 'email', 'jf.morin@email.com', 'individual', 'First-time donor', '2023-02-18', 1, 'Trois-Rivières', 9, 0, 0, 0, 0, 0, 1, 0, 0),
(28, NULL, NULL, 'Charlotte Giroux', 37, 'Female', 67.50, 'AB+', '2022-10-30', 1, 6, 'phone', '514-789-0123', 'individual', 'Occasional donor', '2022-10-20', 2, 'Drummondville', 99, 0, 0, 0, 0, 0, 0, 0, 1),
(29, NULL, NULL, 'Olivier Roy', 41, 'Male', 90.10, 'A+', '2022-12-10', 1, 2, 'email', 'olivier.roy@email.com', 'individual', 'Regular donor', '2022-11-30', 1, 'Brossard', 58, 1, 0, 0, 0, 0, 0, 0, 0),
(30, NULL, NULL, 'Isabelle Simard', 25, 'Female', 54.20, 'O-', '2023-01-12', 1, 4, 'phone', '418-324-5678', 'individual', 'New donor', '2023-01-02', 1, 'Blainville', 25, 0, 1, 0, 0, 0, 0, 0, 0),
(31, NULL, NULL, 'Marc-Andre Fortin', 33, 'Male', 77.80, 'B+', '2023-03-10', 1, 7, 'email', 'ma.fortin@email.com', 'individual', 'Active donor', '2023-02-28', 2, 'Saint-Jean-sur-Richelieu', 1, 0, 0, 1, 0, 0, 0, 0, 0),
(32, NULL, NULL, 'Julie Tremblay', 30, 'Female', 63.00, 'A-', '2022-11-20', 1, 5, 'phone', '514-123-4567', 'individual', 'Frequent donor', '2022-11-10', 2, 'Granby', 78, 0, 0, 0, 0, 1, 0, 0, 0),
(33, NULL, NULL, 'Francois Lévesque', 48, 'Male', 85.40, 'AB-', '2022-09-15', 1, 1, 'email', 'francois.levesque@email.com', 'individual', 'Long-time donor', '2022-09-05', 1, 'Repentigny', 144, 0, 0, 0, 1, 0, 0, 0, 0),
(34, NULL, NULL, 'Anne-Marie Côté', 42, 'Female', 70.60, 'O+', '2023-02-05', 1, 3, 'phone', '418-567-8901', 'individual', 'Dedicated donor', '2023-01-26', 1, 'Mascouche', 32, 0, 0, 0, 0, 0, 0, 1, 0),
(35, NULL, NULL, 'Rémi Bouchard', 36, 'Male', 73.20, 'B-', '2023-01-08', 1, 2, 'email', 'remi.bouchard@email.com', 'individual', 'Occasional donor', '2022-12-29', 2, 'Côte-Saint-Luc', 59, 0, 0, 0, 0, 0, 1, 0, 0),
(36, NULL, NULL, 'Catherine Leclerc', 28, 'Female', 61.90, 'A+', '2022-10-22', 1, 4, 'phone', '514-234-7890', 'individual', 'First-time donor', '2022-10-12', 1, 'Dollard-Des Ormeaux', 137, 1, 0, 0, 0, 0, 0, 0, 0),
(37, NULL, NULL, 'Guillaume Prévost', 45, 'Male', 88.70, 'AB+', '2022-12-30', 1, 6, 'email', 'guillaume.prevost@email.com', 'individual', 'Regular donor', '2022-12-20', 2, 'Pointe-Claire', 38, 0, 0, 0, 0, 0, 0, 0, 1),
(38, NULL, NULL, 'Nathalie Dion', 34, 'Female', 58.40, 'O-', '2023-03-15', 1, 7, 'phone', '418-345-6789', 'individual', 'Active donor', '2023-03-05', 1, 'Dorval', 0, 0, 1, 0, 0, 0, 0, 0, 0),
(39, NULL, NULL, 'Sébastien Gauthier', 31, 'Male', 75.50, 'B+', '2022-11-05', 1, 5, 'email', 'sebastien.gauthier@email.com', 'individual', 'Frequent donor', '2022-10-26', 2, 'Kirkland', 86, 0, 0, 1, 0, 0, 0, 0, 0),
(40, NULL, NULL, 'Mélanie Rochon', 26, 'Female', 64.70, 'A-', '2023-02-12', 1, 3, 'phone', '514-456-7891', 'individual', 'New donor', '2023-02-02', 1, 'Beaconsfield', 23, 0, 0, 0, 0, 1, 0, 0, 0),
(41, NULL, NULL, 'Vincent Lajoie', 37, 'Male', 82.90, 'O+', '2023-01-25', 1, 4, 'email', 'vincent.lajoie@email.com', 'individual', 'Occasional donor', '2023-01-15', 1, 'Montreal', 42, 0, 0, 0, 0, 0, 0, 1, 0),
(42, NULL, NULL, 'Amélie Poirier', 32, 'Female', 69.80, 'AB-', '2022-10-05', 1, 2, 'phone', '418-654-3210', 'individual', 'Regular donor', '2022-09-25', 2, 'Quebec City', 154, 0, 0, 0, 1, 0, 0, 0, 0),
(43, NULL, NULL, 'Tristan Fournier', 29, 'Male', 76.10, 'B-', '2023-02-18', 1, 5, 'email', 'tristan.fournier@email.com', 'individual', 'First-time donor', '2023-02-08', 1, 'Laval', 17, 0, 0, 0, 0, 0, 1, 0, 0),
(44, NULL, NULL, 'Léa Pelletier', 43, 'Female', 62.20, 'A+', '2022-12-20', 1, 7, 'phone', '514-765-4321', 'individual', 'Dedicated donor', '2022-12-10', 2, 'Sherbrooke', 48, 1, 0, 0, 0, 0, 0, 0, 0),
(45, NULL, NULL, 'Mathieu Bélanger', 38, 'Male', 83.60, 'AB+', '2023-01-10', 1, 3, 'email', 'mathieu.belanger@email.com', 'individual', 'Occasional donor', '2023-01-01', 1, 'Gatineau', 57, 0, 0, 0, 0, 0, 0, 0, 1),
(46, NULL, NULL, 'Isaac Thibault', 25, 'Male', 70.30, 'O-', '2023-03-21', 1, 4, 'phone', '418-876-5432', 'individual', 'New donor', '2023-03-11', 1, 'Longueuil', 0, 0, 1, 0, 0, 0, 0, 0, 0),
(47, NULL, NULL, 'Olivia Martin', 28, 'Female', 65.20, 'A-', '2023-02-25', 1, 3, 'email', 'olivia.martin@email.com', 'individual', 'First-time donor', '2023-02-15', 2, 'Trois-Rivières', 12, 0, 0, 0, 0, 1, 0, 0, 0),
(48, NULL, NULL, 'Noah Thompson', 31, 'Male', 81.60, 'B+', '2022-12-12', 1, 7, 'phone', '514-321-6543', 'individual', 'Regular donor', '2022-12-02', 1, 'Drummondville', 56, 0, 0, 1, 0, 0, 0, 0, 0),
(49, NULL, NULL, 'Emma Clark', 35, 'Female', 60.80, 'O+', '2023-01-18', 1, 5, 'email', 'emma.clark@email.com', 'individual', 'Dedicated donor', '2023-01-08', 1, 'Brossard', 49, 0, 0, 0, 0, 0, 0, 1, 0),
(50, NULL, NULL, 'Liam Johnson', 42, 'Male', 88.40, 'AB-', '2023-03-01', 1, 2, 'phone', '418-987-6543', 'individual', 'Active donor', '2023-02-19', 2, 'Blainville', 5, 0, 0, 0, 1, 0, 0, 0, 0);
