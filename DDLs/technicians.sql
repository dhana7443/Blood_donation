CREATE TABLE raw.technicians (
  technician_id         TEXT,  -- Unique identifier for each technician
  hospital_id           TEXT,  -- Identifier for the primary hospital where the technician works
  assigned_hospital_id  TEXT,  -- Identifier for the secondary hospital where the technician may be assigned
  name                  TEXT,  -- Full name of the technician
  qualification         TEXT,  -- Professional qualifications and certifications
  phone_number          TEXT,  -- Primary contact phone number
  email_address         TEXT   -- Primary contact email address
);
INSERT INTO raw.technicians (technician_id, hospital_id, assigned_hospital_id, name, qualification, phone_number, email_address) VALUES
(3, NULL, NULL, 'Alex Tremblay', 'Certified Phlebotomist', '514-111-2222', 'alext@example.com'),
(4, NULL, NULL, 'Jordan Beaupre', 'Medical Lab Technician', '418-333-4444', 'jordanb@example.com'),
(5, NULL, NULL, 'Samira Patel', 'Certified Phlebotomist', '514-000-0001', 'tech1@example.com'),
(6, NULL, NULL, 'Ethan Wong', 'Medical Lab Technician', '514-000-0002', 'tech2@example.com'),
(7, NULL, NULL, 'Nadia Morales', 'Clinical Laboratory Technologist', '514-000-0003', 'tech3@example.com'),
(8, NULL, NULL, 'Liam Nguyen', 'Biomedical Scientist', '514-000-0004', 'tech4@example.com'),
(9, NULL, NULL, 'Ava Chen', 'Blood Bank Specialist', '514-000-0005', 'tech5@example.com'),
(10, NULL, NULL, 'Mason Kim', 'Clinical Biochemist', '514-000-0006', 'tech6@example.com'),
(11, NULL, NULL, 'Olivia Sanchez', 'Hematology Technician', '514-000-0007', 'tech7@example.com'),
(12, NULL, NULL, 'Noah Schwartz', 'Immunology Technician', '514-000-0008', 'tech8@example.com'),
(13, NULL, NULL, 'Isabella Rossi', 'Laboratory Supervisor', '514-000-0009', 'tech9@example.com'),
(14, NULL, NULL, 'Jacob Cohen', 'Pathology Assistant', '514-000-0010', 'tech10@example.com'),
(15, NULL, NULL, 'Sophia Kaur', 'Phlebotomy Technician', '514-000-0011', 'tech11@example.com'),
(16, NULL, NULL, 'Lucas Garcia', 'Toxicology Technician', '514-000-0012', 'tech12@example.com'),
(17, NULL, NULL, 'Emma Johnson', 'Clinical Research Technician', '514-000-0013', 'tech13@example.com'),
(18, NULL, NULL, 'Logan Lee', 'Diagnostic Technician', '514-000-0014', 'tech14@example.com'),
(19, NULL, NULL, 'Amelia Brown', 'Blood Transfusion Officer', '514-000-0015', 'tech15@example.com'),
(20, NULL, NULL, 'Aiden Smith', 'Medical Laboratory Assistant', '514-000-0016', 'tech16@example.com'),
(21, NULL, NULL, 'Mia Martinez', 'Quality Control Analyst', '514-000-0017', 'tech17@example.com'),
(22, NULL, NULL, 'Benjamin Anderson', 'Serology Technician', '514-000-0018', 'tech18@example.com'),
(23, NULL, NULL, 'Charlotte Davis', 'Tissue Typing Specialist', '514-000-0019', 'tech19@example.com'),
(24, NULL, NULL, 'Jack Rodriguez', 'Clinical Trials Coordinator', '514-000-0020', 'tech20@example.com');