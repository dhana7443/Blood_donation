# ============================================================
# MOCK DATA GENERATION LOGIC – BLOOD DONATIONS
# ============================================================

# 1. Donations are linked to donors and requests
# - Each donation is associated with a donor_id and inherits donor blood group
# - Distributed donations are mapped to matching recipient requests (same blood group)
# - Ensures consistency between supply (donations) and demand (requests)

# 2. Donor behavior segmentation (realistic activity modeling)
# - Donors are categorized into:
#     • Active (frequent donors)
#     • Semi-active (occasional donors)
#     • Inactive (rare donors)
# - Donation dates are generated based on this behavior
# - Helps simulate donor retention and engagement patterns

# 3. Time-based data distribution
# - Donations are spread across the last ~3 years
# - Recent donations are more likely from active donors
# - Enables trend analysis and retention insights

# 4. Status progression based on recency
# - New donations → pending / tested / complete
# - Mid-age donations → tested / complete / distributed
# - Older donations → mostly distributed
# - Ensures logical lifecycle progression (no unrealistic states)

# 5. Donation types and expiry logic
# - Supports multiple donation types:
#     • Whole blood (≈42 days expiry)
#     • Platelets (≈5 days expiry)
#     • Plasma (≈365 days expiry)
# - Expiration date derived from donation type and date

# 6. Quantity realism
# - Quantity varies based on donation type
# - Reflects real-world collection ranges

# 7. Recipient assignment rules
# - Recipient is assigned ONLY for distributed donations
# - Ensures business correctness (blood is linked to a request only when used)
# - Matching is done based on blood group for consistency

# 8. Operational realism
# - Hospital and technician assignments are mostly present but can be null
# - Simulates real-world missing or incomplete operational data

# 9. Storage conditions
# - Storage temperature is typically 4°C (standard for blood storage)
# - Occasionally left null to simulate data gaps

# 10. Data volume and performance
# - Large-scale dataset (1M records) generated in chunks (100k)
# - Ensures efficient memory usage and faster execution

# 11. Data consistency rules
# - Blood group always matches donor
# - Status and dates are aligned logically
# - No backward lifecycle transitions

# 12. Purpose of dataset
# - Supports analysis such as:
#   • Donation trends over time
#   • Donor retention analysis
#   • Supply generation for inventory
#   • Demand vs supply matching
# ============================================================


import pandas as pd
import random
from datetime import datetime, timedelta

NUM_RECORDS = 1_000_000
CHUNK_SIZE = 100_000

donation_types = ['whole_blood', 'platelets', 'plasma']

# Load donors
donors_df = pd.read_csv("donors.csv")
donor_blood_map = dict(zip(donors_df["donor_id"], donors_df["blood_group"]))
donor_ids = list(donor_blood_map.keys())

# Load requests
requests_df = pd.read_csv("requests.csv")

#  Group requests by blood group (fast lookup)
requests_grouped = {
    bg: group["recipient_id"].values
    for bg, group in requests_df.groupby("blood_group")
}

#  Donor behavior segmentation (CRITICAL FIX)
donor_behavior = {}

for donor_id in donor_ids:
    r = random.random()

    if r < 0.5:
        donor_behavior[donor_id] = "active"
    elif r < 0.8:
        donor_behavior[donor_id] = "semi_active"
    else:
        donor_behavior[donor_id] = "inactive"

# Date base
today = datetime.today()
start_date = today - timedelta(days=3*365)

file_name = "donations.csv"

# Write header
pd.DataFrame(columns=[
    "donation_id","donor_id","hospital_id","recipient_id",
    "collection_technician_id","processed_by_technician_id",
    "test_result_id","date","quantity","blood_group","status",
    "bag_serial_number","storage_temperature","expiration_date","donation_type"
]).to_csv(file_name, index=False)

donation_id = 1

for chunk_start in range(0, NUM_RECORDS, CHUNK_SIZE):

    chunk_data = []

    for _ in range(CHUNK_SIZE):

        # Donor
        donor_id_val = random.choice(donor_ids)
        blood_group = donor_blood_map[donor_id_val]
        behavior = donor_behavior[donor_id_val]

        # Hospital
        hospital_id = random.randint(1, 500) if random.random() < 0.9 else None

        # Technicians
        collection_tech = random.randint(1, 10000) if random.random() < 0.95 else None
        processed_tech = random.randint(1, 10000) if random.random() < 0.8 else None

        #  Behavior-based donation date (FIXED)
        if behavior == "active":
            donation_date = today - timedelta(days=random.randint(0, 90))

        elif behavior == "semi_active":
            donation_date = today - timedelta(days=random.randint(90, 180))

        else:  # inactive
            donation_date = today - timedelta(days=random.randint(180, 900))

        donation_date = donation_date.date()

        # Donation type
        donation_type = random.choice(donation_types)

        # Quantity + expiry
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

        #  Status aligned with recency (IMPORTANT)
        days_old = (today.date() - donation_date).days

        if days_old < 10:
            status = random.choices(
                ['pending', 'tested', 'complete'],
                weights=[0.2, 0.3, 0.5]
            )[0]

        elif days_old < 40:
            status = random.choices(
                ['tested', 'complete', 'distributed'],
                weights=[0.2, 0.4, 0.4]
            )[0]

        else:
            status = 'distributed'

        #  Recipient assignment (correct)
        if status == 'distributed':
            recipients = requests_grouped.get(blood_group, [])
            if len(recipients) > 0:
                recipient_id = int(random.choice(recipients))
            else:
                recipient_id = None
        else:
            recipient_id = None

        # Storage temp
        storage_temperature = 4 if random.random() < 0.9 else None

        # Serial
        bag_serial = f"BAG{100000 + donation_id}"

        chunk_data.append([
            donation_id,
            donor_id_val,
            hospital_id,
            recipient_id,
            collection_tech,
            processed_tech,
            None,
            donation_date,
            quantity,
            blood_group,
            status,
            bag_serial,
            storage_temperature,
            expiration_date,
            donation_type
        ])

        donation_id += 1

    chunk_df = pd.DataFrame(chunk_data, columns=[
        "donation_id","donor_id","hospital_id","recipient_id",
        "collection_technician_id","processed_by_technician_id",
        "test_result_id","date","quantity","blood_group","status",
        "bag_serial_number","storage_temperature","expiration_date","donation_type"
    ])

    # Fix nullable integers
    for col in ["hospital_id","recipient_id","collection_technician_id","processed_by_technician_id"]:
        chunk_df[col] = chunk_df[col].astype("Int64")

    chunk_df.to_csv(file_name, mode='a', header=False, index=False)

    print(f"Processed {donation_id - 1} rows")

print("donations.csv generated successfully")