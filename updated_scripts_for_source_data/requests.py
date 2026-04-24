# ============================================================
# MOCK DATA GENERATION LOGIC – BLOOD REQUESTS (FACT TABLE)
# ============================================================

# 1. Requests represent demand (fact table)
# - Each record represents a blood request raised for a recipient
# - Linked to dim_recipients via recipient_id
# - Acts as the primary source of demand in demand vs supply analysis

# 2. Separation of dimension and fact
# - Recipient attributes are NOT duplicated here
# - Only transactional data (request details) is stored
# - Ensures proper dimensional modeling

# 3. Controlled demand distribution (business-driven)
# - Blood groups assigned using weighted probabilities
# - High-demand groups (A+, O+, B+) appear more frequently
# - Rare groups have lower frequency
# - Helps create realistic imbalance scenarios in reporting

# 4. Recipient consistency
# - recipient_id is selected based on matching blood group
# - Ensures logical consistency between recipient and request

# 5. Urgency distribution
# - Requests categorized as low, medium, high urgency
# - Majority are medium urgency (~50%)
# - High urgency limited (~25%) to simulate critical cases

# 6. Time-based request behavior (active vs inactive)
# - ~70% requests are future-dated (active demand)
# - ~15% are for today (immediate demand)
# - ~15% are past-dated (inactive/fulfilled demand)
# - Enables filtering logic for active demand in reports

# 7. Urgency-driven timing
# - High urgency → near-term dates (0–2 days)
# - Medium urgency → short-term (2–10 days)
# - Low urgency → longer-term (5–25 days)
# - Ensures realistic prioritization of requests

# 8. Hospital association
# - Most requests (~90%) are linked to a hospital
# - Some records intentionally left null to simulate incomplete data

# 9. Large-scale data handling
# - Dataset generated in chunks (100k rows)
# - Supports scalable data generation without memory issues

# 10. Data integrity rules
# - request_id is unique
# - blood_group always aligns with selected recipient
# - No invalid or conflicting relationships

# 11. Purpose of dataset
# - Supports analysis such as:
#   • Demand vs supply comparison
#   • Urgency-based prioritization
#   • Active vs inactive demand tracking
#   • Blood group demand patterns

# 12. Design focus
# - Controlled randomness with business logic
# - Designed specifically to create meaningful analytical insights
# ============================================================


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
        hospital_id = random.randint(1, 500) if random.random() < 0.9 else None

        chunk_data.append([
            request_id,
            recipient_id,
            hospital_id,
            blood_group,
            required_date,
            urgency
        ])

        request_id += 1

    chunk_df = pd.DataFrame(chunk_data, columns=[
        "request_id","recipient_id","hospital_id",
        "blood_group","required_date","urgency"
    ])

    chunk_df["hospital_id"] = chunk_df["hospital_id"].astype("Int64")

    chunk_df.to_csv(file_name, mode='a', header=False, index=False)

    print(f"Processed {request_id - 1} requests")

print("requests.csv generated successfully")