import pandas as pd
import random
from datetime import timedelta

# Load donations
donations_df = pd.read_csv("donations.csv")

data = []
inventory_id = 1
today = pd.Timestamp.today()

# Rare blood groups (intentionally constrained)
rare_groups = ['O-', 'AB-']

for _, row in donations_df.iterrows():

    #  FIX 1: Increase inflow (70% go to inventory)
    if random.random() > 0.9:
        continue

    donation_id = int(row["donation_id"])
    blood_group = row["blood_group"]
    donation_date = pd.to_datetime(row["date"])
    donation_type = row["donation_type"]
    donation_quantity = row["quantity"]
    donation_expiry = row["expiration_date"]
    donation_recipient = row["recipient_id"]

    # Date received
    date_received = donation_date + timedelta(days=random.randint(0, 2))

    # Expiration logic
    if pd.notna(donation_expiry):
        expiration_date = pd.to_datetime(donation_expiry)
    else:
        if donation_type == 'whole_blood':
            expiry_days = 42
        elif donation_type == 'platelets':
            expiry_days = 5
        else:
            expiry_days = 365

        expiration_date = date_received + timedelta(days=expiry_days)

    # Volume (slightly reduced)
    volume = int(donation_quantity * random.uniform(0.6, 0.9))

    #  FIX 2: Increase units
    units_available = max(2, int(volume / 70))

    # Status distribution
    r = random.random()
    if r < 0.3:
        status = 'stored'
    elif r < 0.6:
        status = 'tested'
    elif r < 0.85:
        status = 'distributed'
    else:
        status = 'discarded'

    # Quality
    quality = 'Good' if random.random() < 0.9 else 'Contaminated'

    temperature = 4.0

    # Expiry handling
    if expiration_date < today:
        status = 'discarded'
        units_available = 0
    elif (expiration_date - today).days < 3:
        units_available = int(units_available * 0.7)

    #  FIX 3: Reduce consumption impact
    if status == 'discarded':
        units_available = 0
    elif status == 'distributed':
        units_available = int(units_available * 0.5)

    #  FIX 4: Blood group bias
    if blood_group in rare_groups:
        units_available = int(units_available * 0.6)
    else:
        units_available = int(units_available * 1.8)

    # Prevent zero after scaling
    if units_available < 1 and status != 'discarded':
        units_available = 1

    # Recipient logic
    if pd.notna(donation_recipient):
        recipient_id = int(donation_recipient)
    elif status == 'distributed':
        recipient_id = random.randint(1, 100000)
    else:
        recipient_id = None

    data.append({
        "inventory_id": inventory_id,
        "donation_id": donation_id,
        "blood_group": blood_group,
        "units_available": units_available,
        "quality": quality,
        "status": status,
        "date_received": date_received.date(),
        "expiration_date": expiration_date.date(),
        "temperature": temperature,
        "volume": volume,
        "recipient_id": recipient_id
    })

    inventory_id += 1

df = pd.DataFrame(data)

# Fix nullable integers
df["donation_id"] = df["donation_id"].astype("Int64")
df["recipient_id"] = df["recipient_id"].astype("Int64")

df.to_csv("blood_inventory.csv", index=False)

print(f"CSV generated: {len(df)} inventory records")