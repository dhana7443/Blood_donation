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