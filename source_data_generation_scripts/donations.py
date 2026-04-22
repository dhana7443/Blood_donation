import pandas as pd
import random
from faker import Faker
from datetime import timedelta

fake = Faker()

NUM_RECORDS = 100000

donation_types = ['whole_blood', 'platelets', 'plasma']

# Load donors data
donors_df = pd.read_csv("donors.csv")

# Create mapping: donor_id → blood_group
donor_blood_map = dict(zip(donors_df["donor_id"], donors_df["blood_group"]))

data = []

for i in range(1, NUM_RECORDS + 1):

    # Select donor
    donor_id = random.randint(1, len(donor_blood_map))

    # Get correct blood group
    blood_group = donor_blood_map[donor_id]

    # Foreign keys
    hospital_id = random.randint(1, 300) if random.random() < 0.9 else None
    

    collection_tech = random.randint(1, 1000) if random.random() < 0.95 else None
    processed_tech = random.randint(1, 1000) if random.random() < 0.8 else None

    # Date
    donation_date = fake.date_between(start_date='-3y', end_date='today')

    # Donation type
    donation_type = random.choice(donation_types)

    # Quantity + expiry logic
    if donation_type == 'whole_blood':
        quantity = random.randint(450, 550)
        expiry_days = 42
    elif donation_type == 'platelets':
        quantity = random.randint(200, 300)
        expiry_days = 5
    else:
        quantity = random.randint(400, 600)
        expiry_days = 365

    expiration_date = donation_date + timedelta(days=expiry_days)

    # Status distribution
    r = random.random()
    if r < 0.1:
        status = 'pending'
    elif r < 0.3:
        status = 'tested'
    elif r < 0.8:
        status = 'complete'
    else:
        status = 'distributed'

    #  Assign recipient ONLY if distributed
    if status == 'distributed':
        recipient_id = random.randint(1, 10000)
    else:
        recipient_id = None

    # Temperature
    storage_temperature = 4 if random.random() < 0.9 else None

    # Bag serial number
    bag_serial = f"BAG{100000 + i}"

    row = {
        "donation_id": i,
        "donor_id": donor_id,
        "hospital_id": hospital_id,
        "recipient_id": recipient_id,
        "collection_technician_id": collection_tech,
        "processed_by_technician_id": processed_tech,
        "test_result_id": None,
        "date": donation_date,
        "quantity": quantity,
        "blood_group": blood_group,   
        "status": status,
        "bag_serial_number": bag_serial,
        "storage_temperature": storage_temperature,
        "expiration_date": expiration_date,
        "donation_type": donation_type
    }

    data.append(row)

df = pd.DataFrame(data)

# Fix nullable integers
int_cols = [
    "hospital_id",
    "recipient_id",
    "collection_technician_id",
    "processed_by_technician_id",
    "test_result_id"
]

for col in int_cols:
    df[col] = df[col].astype("Int64")

df.to_csv("donations.csv", index=False)

print("CSV generated: donations.csv")