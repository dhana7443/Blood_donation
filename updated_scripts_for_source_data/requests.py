import pandas as pd
import random
from datetime import datetime, timedelta

NUM_REQUESTS = 400_000
CHUNK_SIZE = 100_000

# Load recipients
recipients_df = pd.read_csv("recipients.csv")

#  Balanced demand weights (FIXED)
demand_weights = {
    'A+': 0.20,
    'B+': 0.18,
    'O+': 0.20,
    'A-': 0.10,
    'B-': 0.08,
    'O-': 0.07,
    'AB+': 0.10,
    'AB-': 0.07
}

# Group recipients by blood group (FAST)
recipients_grouped = {
    bg: group["recipient_id"].values
    for bg, group in recipients_df.groupby("blood_group")
}

blood_groups = list(demand_weights.keys())
weights = list(demand_weights.values())

file_name = "requests.csv"

# Write header
pd.DataFrame(columns=[
    "request_id","recipient_id","hospital_id",
    "blood_group","required_date","urgency","units_required"
]).to_csv(file_name, index=False)

request_id = 1
today = datetime.today().date()

for chunk_start in range(0, NUM_REQUESTS, CHUNK_SIZE):

    chunk_data = []

    for _ in range(CHUNK_SIZE):

        # Select blood group
        blood_group = random.choices(blood_groups, weights=weights, k=1)[0]

        recipients = recipients_grouped.get(blood_group, [])
        if len(recipients) == 0:
            continue

        recipient_id = int(random.choice(recipients))

        #  Better urgency distribution
        urgency = random.choices(
            ['low', 'medium', 'high'],
            weights=[0.25, 0.50, 0.25]
        )[0]

        #  FIXED units (less aggressive)
        if urgency == 'low':
            units_required = 1
        elif urgency == 'medium':
            units_required = random.randint(1, 2)
        else:
            units_required = random.randint(2, 3)

        #  Improved active/inactive balance
        r = random.random()

        if r < 0.7:
            # ACTIVE (future)
            if urgency == 'high':
                required_date = today + timedelta(days=random.randint(0, 2))
            elif urgency == 'medium':
                required_date = today + timedelta(days=random.randint(2, 10))
            else:
                required_date = today + timedelta(days=random.randint(5, 25))

        elif r < 0.85:
            # TODAY (ACTIVE)
            required_date = today

        else:
            # INACTIVE (past)
            required_date = today - timedelta(days=random.randint(1, 15))

        # Hospital
        hospital_id = random.randint(1, 300) if random.random() < 0.9 else None

        chunk_data.append([
            request_id,
            recipient_id,
            hospital_id,
            blood_group,
            required_date,
            urgency,
            units_required
        ])

        request_id += 1

    chunk_df = pd.DataFrame(chunk_data, columns=[
        "request_id","recipient_id","hospital_id",
        "blood_group","required_date","urgency","units_required"
    ])

    chunk_df["hospital_id"] = chunk_df["hospital_id"].astype("Int64")

    chunk_df.to_csv(file_name, mode='a', header=False, index=False)

    print(f"Processed {request_id - 1} requests")

print("requests.csv generated successfully")