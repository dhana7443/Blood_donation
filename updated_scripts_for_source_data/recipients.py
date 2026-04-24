# ============================================================
# MOCK DATA GENERATION LOGIC – RECIPIENTS (DIMENSION)
# ============================================================

# 1. Recipient master dataset (dimension table)
# - Each record represents a unique patient/recipient
# - Used as a reference for blood requests (fact table)

# 2. Realistic blood group distribution
# - Blood groups are assigned using weighted probabilities
# - Common groups (A+, O+, B+) have higher frequency
# - Rare groups (AB-, O-) have lower frequency
# - Helps create realistic demand patterns in analysis

# 3. Age distribution modeling
# - Age is generated across multiple ranges:
#     • Children (1–17)
#     • Young adults (18–40)
#     • Middle-aged (41–60)
#     • Seniors (61–90)
# - Supports demographic analysis

# 4. Geographic consistency
# - Majority (~80%) of recipients are from Quebec cities
# - Remaining records use random cities for variability
# - Enables location-based reporting

# 5. Data integrity rules
# - recipient_id is unique and acts as primary key
# - Each recipient has exactly one valid blood group
# - No conflicting or derived fields

# 6. Lightweight dimension design
# - Limited number of attributes to keep joins efficient
# - Suitable for large-scale fact tables

# 7. Purpose of dataset
# - Supports analysis such as:
#   • Demand segmentation by blood group
#   • Geographic demand patterns
#   • Age-based analysis of recipients

# 8. Design focus
# - Clean, stable, and reusable dimension
# - Optimized for performance and analytical clarity
# ============================================================


import pandas as pd
import random
from faker import Faker

fake = Faker()

NUM_RECIPIENTS = 20000   # dimension size

# Realistic blood group distribution
blood_groups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
blood_weights = [0.30, 0.08, 0.22, 0.07, 0.23, 0.04, 0.03, 0.03]

cities = [
    "Montreal", "Quebec City", "Laval", "Gatineau", "Longueuil",
    "Sherbrooke", "Trois-Rivières", "Drummondville", "Brossard",
    "Blainville", "Granby", "Repentigny", "Mascouche",
    "Dollard-Des Ormeaux", "Pointe-Claire", "Dorval",
    "Kirkland", "Beaconsfield"
]

data = []

for i in range(1, NUM_RECIPIENTS + 1):

    name = fake.name()

    # Better age distribution
    age = random.choice([
        random.randint(1, 17),
        random.randint(18, 40),
        random.randint(41, 60),
        random.randint(61, 90)
    ])

    # Location
    location = random.choice(cities) if random.random() < 0.8 else fake.city()

    # Blood group (important)
    blood_group = random.choices(blood_groups, weights=blood_weights)[0]

    row = {
        "recipient_id": i,   # PRIMARY KEY
        "name": name,
        "age": age,
        "blood_group": blood_group,
        "location": location
    }

    data.append(row)

df = pd.DataFrame(data)

# Save CSV
df.to_csv("recipients.csv", index=False)

print(f"dim_recipients generated: {len(df)} rows")