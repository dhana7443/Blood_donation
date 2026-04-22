import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta

fake = Faker()

NUM_RECORDS = 50000   #  increased demand

blood_groups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']

#  NEW WEIGHTS → create realistic shortages
blood_weights = [
    0.30,  # A+ (high demand)
    0.08,  # A-
    0.22,  # B+ (high demand)
    0.07,  # B-
    0.23,  # O+ (high demand)
    0.04,  # O-
    0.03,  # AB+
    0.03   # AB-
]

data = []

for i in range(1, NUM_RECORDS + 1):

    blood_group = random.choices(blood_groups, weights=blood_weights)[0]

    urgency = random.choices(
        ['low', 'medium', 'high'],
        weights=[0.15, 0.50, 0.35]  
    )[0]

    #  Spread requests across time (important for realism)
    required_date = datetime.today().date() + timedelta(days=random.randint(-20, 40))

    row = {
        "recipient_id": i,   # acts like request_id
        "hospital_id": random.randint(1, 300) if random.random() < 0.9 else None,
        "name": fake.name(),
        "age": random.randint(1, 90),
        "blood_group": blood_group,
        "required_date": required_date,
        "urgency": urgency,
        "location": fake.city()
    }

    data.append(row)

df = pd.DataFrame(data)

# Fix nullable integer
df["hospital_id"] = df["hospital_id"].astype("Int64")

df.to_csv("recipients.csv", index=False)

print(f"CSV generated: {len(df)} requests")