CREATE TABLE raw.donations (
  donation_id                TEXT,  -- Unique identifier for each donation
  donor_id                   TEXT,  -- Identifier of the donor who made this donation
  hospital_id                TEXT,  -- Identifier of the hospital where this donation took place
  recipient_id               TEXT,  -- Identifier of the recipient for this donation
  collection_technician_id   TEXT,  -- Identifier of the technician who collected this donation
  processed_by_technician_id TEXT,  -- Identifier of the technician who processed this donation
  test_result_id             TEXT,  -- Identifier of the test result associated with this donation
  date                        TEXT,  -- Date of the donation
  quantity                    TEXT,  -- Quantity of blood donated
  blood_group                 TEXT,  -- Blood group of the donated blood
  status                      TEXT,  -- Status (pending, complete, tested, distributed, etc.)
  bag_serial_number           TEXT,  -- Bag serial number
  storage_temperature         TEXT,  -- Temperature at which the blood was stored
  expiration_date             TEXT,  -- Expiration date
  donation_type               TEXT   -- Type of donation (whole_blood, platelets, plasma, etc.)
)

INSERT INTO raw.donations (donation_id, donor_id, hospital_id, recipient_id, collection_technician_id, processed_by_technician_id, test_result_id, date, quantity, blood_group, status, bag_serial_number, storage_temperature, expiration_date, donation_type) VALUES
(1, 1, NULL, NULL, NULL, 3, NULL, '2020-10-15', 500, 'A+', 'complete', 'BAG1001', 4, '2021-04-15', 'whole_blood'),
(2, 2, NULL, NULL, NULL, 3, NULL, '2021-01-20', 450, 'O-', 'complete', 'BAG1002', 4, '2021-07-20', 'whole_blood'),
(3, 3, NULL, NULL, NULL, 3, NULL, '2021-02-18', 480, 'B+', 'complete', 'BAG1003', 4, '2021-08-18', 'plasma'),
(4, 4, NULL, NULL, NULL, 3, NULL, '2020-12-05', 470, 'AB-', 'complete', 'BAG1004', 4, '2021-06-05', 'platelets'),
(5, 5, NULL, NULL, NULL, 5, NULL, '2021-03-10', 510, 'A-', 'complete', 'BAG1005', 4, '2021-09-10', 'whole_blood'),
(6, 6, NULL, NULL, NULL, 5, NULL, '2020-09-22', 500, 'B-', 'complete', 'BAG1006', 4, '2021-03-22', 'whole_blood'),
(7, 7, NULL, NULL, NULL, 5, NULL, '2020-11-12', 480, 'O+', 'complete', 'BAG1007', 4, '2021-05-12', 'plasma'),
(8, 8, NULL, NULL, NULL, 5, NULL, '2021-01-30', 470, 'AB+', 'complete', 'BAG1008', 4, '2021-07-30', 'platelets'),
(9, 9, NULL, NULL, NULL, 3, NULL, '2020-08-19', 510, 'A+', 'complete', 'BAG1009', 0, '2021-02-19', 'whole_blood'),
(10, 10, NULL, NULL, NULL, 3, NULL, '2021-03-05', 500, 'B+', 'complete', 'BAG1010', 4, '2021-09-05', 'whole_blood'),
(11, 11, NULL, NULL, NULL, 3, NULL, '2020-07-11', 480, 'O-', 'complete', 'BAG1011', 4, '2021-01-11', 'plasma'),
(12, 12, NULL, NULL, NULL, 3, NULL, '2021-02-05', 470, 'A-', 'complete', 'BAG1012', 4, '2021-08-05', 'platelets'),
(13, 13, NULL, NULL, NULL, 3, NULL, '2020-10-28', 510, 'AB-', 'complete', 'BAG1013', 4, '2021-04-28', 'whole_blood'),
(14, 14, NULL, NULL, NULL, 3, NULL, '2021-04-09', 500, 'B-', 'complete', 'BAG1014', 4, '2021-10-09', 'whole_blood'),
(15, 15, NULL, NULL, NULL, 3, NULL, '2020-08-30', 480, 'O+', 'complete', 'BAG1015', 4, '2021-02-28', 'plasma'),
(16, 16, NULL, NULL, NULL, 3, NULL, '2021-01-15', 470, 'A+', 'complete', 'BAG1016', 4, '2021-07-15', 'platelets'),
(17, 17, NULL, NULL, NULL, 3, NULL, '2020-11-20', 510, 'AB+', 'complete', 'BAG1017', 4, '2021-05-20', 'whole_blood'),
(18, 18, NULL, NULL, NULL, 3, NULL, '2021-03-20', 500, 'B+', 'complete', 'BAG1018', 4, '2021-09-20', 'whole_blood'),
(19, 19, NULL, NULL, NULL, 3, NULL, '2020-09-05', 480, 'O-', 'complete', 'BAG1019', 4, '2021-03-05', 'plasma'),
(20, 20, NULL, NULL, NULL, 3, NULL, '2021-02-25', 470, 'A-', 'complete', 'BAG1020', 4, '2021-08-25', 'platelets'),
(21, 1, NULL, NULL, NULL, 4, NULL, '2024-02-10', 500, 'A+', '', NULL, NULL, '0000-00-00', NULL),
(22, 2, NULL, NULL, NULL, 4, NULL, '2024-02-20', 450, 'O-', '', NULL, NULL, '0000-00-00', NULL),
(23, 3, 3, NULL, NULL, 4, NULL, '2024-02-15', 480, 'B+', '', NULL, NULL, '0000-00-00', NULL),
(24, 1, NULL, NULL, NULL, 4, NULL, '2024-02-10', 500, 'A+', '', NULL, NULL, '2024-03-13', NULL),
(25, 2, NULL, NULL, NULL, 4, NULL, '2024-02-20', 450, 'O-', '', NULL, NULL, '2024-03-13', NULL),
(26, 3, 3, NULL, NULL, 4, NULL, '2024-02-15', 480, 'B+', '', NULL, NULL, '2024-03-13', NULL),
(27, 4, 4, NULL, NULL, 4, NULL, '2024-02-05', 470, 'AB-', '', NULL, NULL, '2024-03-13', NULL),
(28, 5, 5, NULL, NULL, 4, NULL, '2024-02-12', 500, 'A-', '', NULL, NULL, '2024-03-13', NULL),
(29, 6, NULL, NULL, NULL, 4, NULL, '2024-02-07', 450, 'B-', '', NULL, NULL, '2024-03-13', NULL),
(30, 7, NULL, NULL, NULL, 4, NULL, '2024-02-14', 480, 'O+', '', NULL, NULL, '2024-03-13', NULL),
(31, 8, 3, NULL, NULL, 4, NULL, '2024-02-21', 500, 'AB+', '', NULL, NULL, '2024-03-13', NULL),
(32, 9, 4, NULL, NULL, 4, NULL, '2024-02-18', 470, 'A+', '', NULL, NULL, '2024-03-13', NULL),
(33, 10, 5, NULL, NULL, 4, NULL, '2024-02-25', 450, 'O-', '', NULL, NULL, '2024-03-13', NULL),
(34, 11, NULL, NULL, NULL, 4, NULL, '2024-02-28', 480, 'B+', '', NULL, NULL, '2024-03-13', NULL),
(35, 12, NULL, NULL, NULL, 4, NULL, '2024-02-03', 500, 'AB-', '', NULL, NULL, '2024-03-13', NULL),
(36, 13, 3, NULL, NULL, 4, NULL, '2024-02-11', 450, 'A-', '', NULL, NULL, '2024-03-13', NULL),
(37, 14, 4, NULL, NULL, 4, NULL, '2024-02-17', 480, 'B-', '', NULL, NULL, '2024-03-13', NULL),
(38, 15, 5, NULL, NULL, 4, NULL, '2024-02-22', 500, 'O+', '', NULL, NULL, '2024-03-13', NULL),
(39, 16, NULL, NULL, NULL, 4, NULL, '2024-02-26', 470, 'AB+', '', NULL, NULL, '2024-03-13', NULL),
(40, 17, NULL, NULL, NULL, 4, NULL, '2024-02-08', 450, 'A+', '', NULL, NULL, '2024-03-13', NULL),
(41, 18, 3, NULL, NULL, 5, NULL, '2024-02-16', 480, 'O-', '', NULL, NULL, '2024-03-13', NULL),
(42, 19, 4, NULL, NULL, 5, NULL, '2024-02-19', 500, 'B+', '', NULL, NULL, '2024-03-13', NULL),
(43, 20, 5, NULL, NULL, 5, NULL, '2024-02-23', 470, 'AB-', '', NULL, NULL, '2024-03-13', NULL);