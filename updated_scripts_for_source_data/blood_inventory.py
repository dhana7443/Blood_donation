# ============================================================
# MOCK DATA GENERATION LOGIC – BLOOD INVENTORY
# ============================================================

# 1. Inventory depends on donations
# - Each inventory record is derived from donation data
# - Pending donations are excluded (only valid donations considered)

# 2. Controlled inflow into inventory
# - Not all donations reach inventory (~40% selected)
# - Simulates real-world loss, processing delays, or rejection

# 3. Blood group supply imbalance (business-driven)
# - High demand groups (A+, B+, O+) intentionally have reduced supply
# - Other groups have relatively higher supply
# - Ensures realistic "demand vs supply" imbalance for reporting

# 4. Volume and unit calculation
# - Available volume is slightly reduced from donation quantity (65–95%)
# - Units derived from volume (approx. 1 unit ≈ 60 ml)
# - Additional randomness added to avoid uniform patterns

# 5. Lifecycle consistency (no backward transitions)
# - Inventory status is derived from donation status
# - Ensures forward-only progression:
#   complete → stored/tested/discarded
#   tested → tested/distributed
#   distributed → remains distributed
# - Prevents unrealistic status changes

# 6. Quality rules
# - Distributed blood is always marked as 'Good'
# - Other records have small probability of contamination (~10%)

# 7. Expiry handling
# - Expired units are automatically marked as 'discarded'
# - Near-expiry units (<3 days) have reduced availability
# - Ensures realistic wastage and shelf-life behavior

# 8. Supply reduction after distribution
# - Distributed units reduce available inventory (simulates consumption)
# - Prevents overestimation of supply

# 9. Recipient assignment logic
# - Recipient is assigned ONLY for distributed records
# - Ensures business correctness (inventory is linked to requests only when used)
# - If missing, a valid recipient_id is assigned within known range (1–20000)

# 10. Data realism and constraints
# - Minimum 1 unit enforced for non-discarded records
# - Temperature fixed at 4°C (standard storage condition)
# - Dates follow logical sequence: donation → received → expiry

# 11. Performance optimization
# - Data is processed in chunks (100k rows) to handle large datasets efficiently
# - Prevents memory overflow and improves execution time

# 12. Goal of data generation
# - Create realistic supply patterns
# - Introduce controlled imbalance across blood groups
# - Support analytical use cases like:
#   • Demand vs Supply
#   • Shortage detection
#   • Inventory lifecycle analysis
# ============================================================


# import pandas as pd
# import random
# from datetime import timedelta

# # Load donations
# donations_df = pd.read_csv("donations.csv")

# NUM_RECORDS = len(donations_df)

# inventory_id = 1
# today = pd.Timestamp.today().date()

# # High demand groups → controlled shortage
# high_demand_groups = ['A+', 'B+', 'O+']

# CHUNK_SIZE = 100000
# file_name = "blood_inventory.csv"

# # Write header
# pd.DataFrame(columns=[
#     "inventory_id","donation_id","blood_group","units_available",
#     "quality","status","date_received","expiration_date",
#     "temperature","volume","recipient_id"
# ]).to_csv(file_name, index=False)

# for chunk_start in range(0, NUM_RECORDS, CHUNK_SIZE):

#     chunk = donations_df.iloc[chunk_start:chunk_start + CHUNK_SIZE]

#     chunk_data = []

#     for _, row in chunk.iterrows():

#         donation_status = row["status"]

#         # Skip pending donations
#         if donation_status == 'pending':
#             continue

#         #  Increased inflow (40% go to inventory)
#         if random.random() > 0.6:
#             continue

#         donation_id = int(row["donation_id"])
#         blood_group = row["blood_group"]
#         donation_date = pd.to_datetime(row["date"]).date()
#         donation_type = row["donation_type"]
#         donation_quantity = row["quantity"]
#         donation_expiry = row["expiration_date"]

#         # Date received
#         date_received = donation_date + timedelta(days=random.randint(0, 2))

#         # Expiration logic
#         if pd.notna(donation_expiry):
#             expiration_date = pd.to_datetime(donation_expiry).date()
#         else:
#             if donation_type == 'whole_blood':
#                 expiry_days = 42
#             elif donation_type == 'platelets':
#                 expiry_days = 5
#             else:
#                 expiry_days = 365

#             expiration_date = date_received + timedelta(days=expiry_days)

#         # Volume
#         volume = int(donation_quantity * random.uniform(0.65, 0.95))

#         # Base units
#         units_available = int(volume / 60)

#         # Supply bias (balanced)
#         if blood_group in high_demand_groups:
#             units_available = int(units_available * 0.7)   # reduced but not too harsh
#         else:
#             units_available = int(units_available * 1.6)

#         # Optional realism tweak
#         units_available = int(units_available * random.uniform(1.0, 1.2))

#         if units_available < 1:
#             units_available = 1

#         # Lifecycle-based status (no backward movement)
#         if donation_status == 'distributed':
#             status = 'distributed'

#         elif donation_status == 'tested':
#             status = random.choices(
#                 ['tested', 'distributed'],
#                 weights=[0.6, 0.4]
#             )[0]

#         elif donation_status == 'complete':
#             status = random.choices(
#                 ['stored', 'tested', 'discarded'],
#                 weights=[0.6, 0.3, 0.1]
#             )[0]

#         else:
#             continue

#         # Quality logic
#         if status == 'distributed':
#             quality = 'Good'
#         else:
#             quality = 'Good' if random.random() < 0.9 else 'Contaminated'

#         temperature = 4.0

#         # Expiry handling
#         if expiration_date < today:
#             status = 'discarded'
#             units_available = 0
#         elif (expiration_date - today).days < 3:
#             units_available = int(units_available * 0.7)

#         # Distribution impact (reduced consumption)
#         if status == 'distributed':
#             units_available = int(units_available * 0.5)

#         if status == 'discarded':
#             units_available = 0

#         if units_available < 1 and status != 'discarded':
#             units_available = 1

#         # STRICT recipient logic
#         if status == 'distributed':
#             if pd.notna(row["recipient_id"]):
#                 recipient_id = int(row["recipient_id"])
#             else:
#                 recipient_id = random.randint(1, 20000)
#         else:
#             recipient_id = None

#         chunk_data.append([
#             inventory_id,
#             donation_id,
#             blood_group,
#             units_available,
#             quality,
#             status,
#             date_received,
#             expiration_date,
#             temperature,
#             volume,
#             recipient_id
#         ])

#         inventory_id += 1

#     chunk_df = pd.DataFrame(chunk_data, columns=[
#         "inventory_id","donation_id","blood_group","units_available",
#         "quality","status","date_received","expiration_date",
#         "temperature","volume","recipient_id"
#     ])

#     # Fix nullable integers
#     chunk_df["donation_id"] = chunk_df["donation_id"].astype("Int64")
#     chunk_df["recipient_id"] = chunk_df["recipient_id"].astype("Int64")

#     chunk_df.to_csv(file_name, mode='a', header=False, index=False)

#     print(f"Processed {inventory_id - 1} inventory rows")

# print("blood_inventory.csv generated successfully")

# ============================================================
# MOCK DATA GENERATION LOGIC – BLOOD INVENTORY (UPDATED)
# ============================================================

import pandas as pd
import random
from datetime import timedelta

# Load donations
donations_df = pd.read_csv("donations.csv")

# Load requests (for correct recipient mapping)
requests_df = pd.read_csv("requests.csv")

# Group requests by blood group
requests_grouped = {
    bg: group["recipient_id"].values
    for bg, group in requests_df.groupby("blood_group")
}

NUM_RECORDS = len(donations_df)

inventory_id = 1
today = pd.Timestamp.today().date()

# High demand groups → controlled shortage
high_demand_groups = ['A+', 'B+', 'O+']

CHUNK_SIZE = 100000
file_name = "blood_inventory.csv"

# Write header
pd.DataFrame(columns=[
    "inventory_id","donation_id","blood_group","units_available",
    "quality","status","date_received","expiration_date",
    "temperature","volume","recipient_id"
]).to_csv(file_name, index=False)

for chunk_start in range(0, NUM_RECORDS, CHUNK_SIZE):

    chunk = donations_df.iloc[chunk_start:chunk_start + CHUNK_SIZE]
    chunk_data = []

    for _, row in chunk.iterrows():

        donation_status = row["status"]

        # Skip pending donations
        if donation_status == 'pending':
            continue

        # Controlled inflow (~40%)
        if random.random() > 0.6:
            continue

        donation_id = int(row["donation_id"])
        blood_group = row["blood_group"]
        donation_date = pd.to_datetime(row["date"]).date()
        donation_type = row["donation_type"]
        donation_quantity = row["quantity"]
        donation_expiry = row["expiration_date"]

        # Date received
        date_received = donation_date + timedelta(days=random.randint(0, 2))

        # Expiration logic
        if pd.notna(donation_expiry):
            expiration_date = pd.to_datetime(donation_expiry).date()
        else:
            if donation_type == 'whole_blood':
                expiry_days = 42
            elif donation_type == 'platelets':
                expiry_days = 5
            else:
                expiry_days = 365
            expiration_date = date_received + timedelta(days=expiry_days)

        # ==============================
        # FIX 1: Units & Volume consistency
        # ==============================

        # Base units from donation quantity
        base_units = int(donation_quantity / 60)

        # Supply bias
        if blood_group in high_demand_groups:
            base_units = int(base_units * 0.7)
        else:
            base_units = int(base_units * 1.6)

        # Add slight randomness
        units_available = int(base_units * random.uniform(1.0, 1.2))

        if units_available < 1:
            units_available = 1

        # Volume derived from units (consistent)
        volume = units_available * random.randint(55, 65)

        # ==============================
        # Status lifecycle (no backward)
        # ==============================

        if donation_status == 'distributed':
            status = 'distributed'

        elif donation_status == 'tested':
            status = random.choices(
                ['tested', 'distributed'],
                weights=[0.6, 0.4]
            )[0]

        elif donation_status == 'complete':
            status = random.choices(
                ['stored', 'tested', 'discarded'],
                weights=[0.6, 0.3, 0.1]
            )[0]

        else:
            continue

        # Quality logic
        if status == 'distributed':
            quality = 'Good'
        else:
            quality = 'Good' if random.random() < 0.9 else 'Contaminated'

        temperature = 4.0

        # ==============================
        # Expiry handling
        # ==============================

        if expiration_date < today:
            status = 'discarded'
            units_available = 0   # volume retained

        elif (expiration_date - today).days < 3:
            units_available = int(units_available * 0.7)

        # ==============================
        # Distribution impact
        # ==============================

        if status == 'distributed':
            units_available = int(units_available * 0.5)

        # ==============================
        # FIX 2: Discarded logic
        # ==============================

        if status == 'discarded':
            units_available = 0   # keep volume for wastage reporting

        if units_available < 1 and status != 'discarded':
            units_available = 1

        # ==============================
        # FIX 3: Recipient mapping
        # ==============================

        if status == 'distributed':
            if pd.notna(row["recipient_id"]):
                recipient_id = int(row["recipient_id"])
            else:
                recipients = requests_grouped.get(blood_group, [])
                if len(recipients) > 0:
                    recipient_id = int(random.choice(recipients))
                else:
                    recipient_id = None
        else:
            recipient_id = None

        chunk_data.append([
            inventory_id,
            donation_id,
            blood_group,
            units_available,
            quality,
            status,
            date_received,
            expiration_date,
            temperature,
            volume,
            recipient_id
        ])

        inventory_id += 1

    chunk_df = pd.DataFrame(chunk_data, columns=[
        "inventory_id","donation_id","blood_group","units_available",
        "quality","status","date_received","expiration_date",
        "temperature","volume","recipient_id"
    ])

    # Fix nullable integers
    chunk_df["donation_id"] = chunk_df["donation_id"].astype("Int64")
    chunk_df["recipient_id"] = chunk_df["recipient_id"].astype("Int64")

    chunk_df.to_csv(file_name, mode='a', header=False, index=False)

    print(f"Processed {inventory_id - 1} inventory rows")

print("blood_inventory.csv generated successfully")