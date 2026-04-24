# ============================================================
# MOCK DATA GENERATION LOGIC – DONORS
# ============================================================

# 1. Donor master dataset (core dimension)
# - Each record represents a unique donor with demographic and health attributes
# - Acts as a primary reference table for donations, tests, and history

# 2. Demographic realism
# - Includes attributes like age, gender, weight, and location
# - Age restricted to realistic donor range (18–65)
# - Gender includes inclusive categories (Male, Female, Other)

# 3. Blood group assignment
# - Each donor is assigned one valid blood group
# - Additional binary flags created for each blood group (for flexible filtering/reporting)

# 4. Donation history tracking
# - last_donation_date generated within past 3 years
# - days_since_last_donation calculated for analytical use
# - Some donors (~10%) have no prior donations (new donors)

# 5. Eligibility logic (business rule)
# - Donor is eligible if:
#     • No previous donation OR
#     • Last donation was more than 90 days ago
# - Reflects standard donation eligibility guidelines

# 6. Donation behavior
# - donations_count simulates past donation activity (0–5)
# - Helps in identifying frequent vs occasional donors

# 7. Contact information handling
# - Contact method randomly chosen (phone/email)
# - Phone numbers follow structured format
# - Ensures realistic communication data

# 8. Optional/nullable operational fields
# - registered_by_staff_id and primary_contact_id are partially populated
# - Simulates real-world incomplete operational data

# 9. Health monitoring
# - last_health_check_date available for most donors (~80%)
# - Supports health-based eligibility and analysis

# 10. Donation constraints
# - donation_frequency_allowed defines how often a donor can donate
# - Includes null values to simulate missing or undefined rules

# 11. Notes and qualitative data
# - Notes added for a subset (~30%) of donors
# - Provides contextual information such as health history or donor behavior

# 12. Data consistency and integrity
# - days_since_last_donation derived from last_donation_date
# - Blood group flags aligned with assigned blood group
# - Ensures no conflicting or unrealistic data

# 13. Purpose of dataset
# - Supports analysis such as:
#   • Donor demographics and segmentation
#   • Eligibility tracking
#   • Donor retention and activity patterns
#   • Health and risk analysis

# 14. Design focus
# - Combination of structured attributes and controlled randomness
# - Ensures dataset is both realistic and analytically useful
# ============================================================


import pandas as pd
import random
from faker import Faker
from datetime import datetime

fake = Faker()

NUM_RECORDS = 20000

blood_groups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
genders = ['Male', 'Female', 'Other']
contact_methods = ['phone', 'email']
donor_types = ['individual', 'corporation', 'anonymous']

# Meaningful notes
notes_options = [
    "Regular donor with consistent history",
    "First-time donor, no prior records",
    "Eligible donor with good health condition",
    "Donor deferred previously due to low hemoglobin",
    "Frequent donor with strong eligibility history",
    "Donor requires periodic health monitoring"
]

#  Clean phone generator (Canada-style)
def generate_phone():
    area_codes = ['514', '438', '418', '450']
    area = random.choice(area_codes)
    num = ''.join([str(random.randint(0, 9)) for _ in range(7)])
    return f"{area}-{num[:3]}-{num[3:]}"

data = []

for i in range(1, NUM_RECORDS + 1):

    gender = random.choice(genders)
    blood_group = random.choice(blood_groups)

    # Last donation date
    if random.random() < 0.1:
        last_donation_date = None
        days_since = None
    else:
        last_donation_date = fake.date_between(start_date='-3y', end_date='today')
        days_since = (datetime.today().date() - last_donation_date).days

    # Eligibility logic
    is_eligible = 1 if (days_since is None or days_since > 90) else 0

    # Donations count
    donations_count = random.randint(0, 5)

    # Contact method
    contact_method = random.choice(contact_methods)
    contact_detail = generate_phone() if contact_method == 'phone' else fake.free_email()

    # Optional fields
    registered_by_staff_id = random.randint(1, 500) if random.random() < 0.7 else None
    primary_contact_id = random.randint(1, 500) if random.random() < 0.6 else None

    # Health check
    last_health_check_date = fake.date_between(start_date='-2y', end_date='today') if random.random() < 0.8 else None

    donation_frequency_allowed = random.choice([1, 2, 3, None])

    weight = round(random.uniform(50, 100), 2)
    age = random.randint(18, 65)

    # Notes
    notes = random.choice(notes_options) if random.random() < 0.3 else None

    location = fake.city()

    # Blood group flags
    bg_flags = {bg: 0 for bg in blood_groups}
    bg_flags[blood_group] = 1

    row = {
        "donor_id": i,
        "registered_by_staff_id": registered_by_staff_id,
        "primary_contact_id": primary_contact_id,
        "name": fake.name(),
        "age": age,
        "gender": gender,
        "weight": weight,
        "blood_group": blood_group,
        "last_donation_date": last_donation_date,
        "is_eligible": is_eligible,
        "donations_count": donations_count,
        "contact_method_type": contact_method,
        "contact_detail": contact_detail,
        "donor_type": random.choice(donor_types),
        "notes": notes,
        "last_health_check_date": last_health_check_date,
        "donation_frequency_allowed": donation_frequency_allowed,
        "location": location,
        "days_since_last_donation": days_since,
        "blood_group_A_plus": bg_flags['A+'],
        "blood_group_O_minus": bg_flags['O-'],
        "blood_group_B_plus": bg_flags['B+'],
        "blood_group_AB_minus": bg_flags['AB-'],
        "blood_group_A_minus": bg_flags['A-'],
        "blood_group_B_minus": bg_flags['B-'],
        "blood_group_O_plus": bg_flags['O+'],
        "blood_group_AB_plus": bg_flags['AB+']
    }

    data.append(row)

df = pd.DataFrame(data)

# Fix integer columns (avoid .0 issue)
int_columns = [
    "registered_by_staff_id",
    "primary_contact_id",
    "donation_frequency_allowed",
    "days_since_last_donation"
]

for col in int_columns:
    df[col] = df[col].astype("Int64")

# Save CSV
df.to_csv("donors.csv", index=False)

print("CSV generated: donors.csv")