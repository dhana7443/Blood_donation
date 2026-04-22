CREATE TABLE raw.requests (
    request_id INT,
    recipient_id INT,
    hospital_id INT,
    blood_group VARCHAR(3),
    required_date DATE,
    urgency VARCHAR(10),
    units_required INT
);