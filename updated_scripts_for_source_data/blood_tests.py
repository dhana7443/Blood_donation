# ============================================================
# MOCK DATA GENERATION LOGIC – BLOOD TESTS
# ============================================================

# 1. Test records are linked to donors
# - Each test is associated with a donor_id
# - Donor blood group is referenced to ensure consistency in blood typing tests

# 2. Multiple test types simulated
# - Blood Typing → confirms donor blood group (always valid/positive)
# - Disease Screening → checks for infections (HIV, Hepatitis, Malaria, etc.)
# - General Health → evaluates donor fitness for donation
# - Mimics real-world testing pipeline before blood usage

# 3. Controlled data quality issues (intentional)
# - Small percentage of invalid dates (e.g., '0000-00-00')
# - Some records with missing disease_tested values
# - Helps test data validation and cleaning logic in downstream layers

# 4. Realistic result distribution
# - Disease tests are mostly 'Negative' (~85%) to reflect healthy donor base
# - Small percentage of 'Positive' results to simulate risk cases
# - General health tests mostly positive (fit donors)

# 5. Conditional logic between fields
# - Blood Typing → always has valid blood group confirmation
# - Disease Screening → disease_tested may be null (bad data simulation)
# - Comments generated based on test type and result
# - Ensures logical consistency across columns

# 6. Technician assignment
# - Most tests (~90%) have a technician_id
# - Some records intentionally left null to simulate operational gaps

# 7. Date distribution
# - Tests spread across past 3 years
# - Helps in trend analysis and time-based reporting

# 8. Data realism focus
# - Comments are context-aware (based on result and test type)
# - Mix of clean and imperfect data for robust analytics

# 9. Purpose of dataset
# - Support analysis such as:
#   • Donor health trends
#   • Disease detection rates
#   • Testing volume over time
#   • Data quality validation in staging layer
# ============================================================


import pandas as pd
import random
from datetime import datetime, timedelta

NUM_RECORDS = 500000   # scalable
CHUNK_SIZE = 100000

diseases = ['HIV', 'Hepatitis B', 'Hepatitis C', 'Malaria']

# Load donors
donors_df = pd.read_csv("donors.csv")
donor_blood_map = dict(zip(donors_df["donor_id"], donors_df["blood_group"]))
donor_ids = list(donor_blood_map.keys())

# Fast date generation
start_date = datetime.today() - timedelta(days=3*365)

file_name = "blood_tests.csv"

# Write header
pd.DataFrame(columns=[
    "test_id","donor_id","technician_id","date",
    "disease_tested","result","test_type","comments"
]).to_csv(file_name, index=False)

test_id = 1

for chunk_start in range(0, NUM_RECORDS, CHUNK_SIZE):

    chunk_data = []

    for _ in range(CHUNK_SIZE):

        donor_id = random.choice(donor_ids)

        # Technician
        technician_id = random.randint(1, 10000) if random.random() < 0.9 else None

        #  Fast date (with some invalids)
        if random.random() < 0.02:
            test_date = "0000-00-00"
        else:
            test_date = (start_date + timedelta(days=random.randint(0, 3*365))).date()

        # Test type
        r = random.random()

        #  Blood Typing
        if r < 0.4:
            test_type = "Blood Typing"
            disease_tested = None
            result = "Positive"

            blood_group = donor_blood_map.get(donor_id, "Unknown")
            comments = f"Blood group {blood_group} confirmed"

        #  Disease Screening
        elif r < 0.8:

            test_type = "Disease Screening"

            if random.random() < 0.08:
                disease_tested = None
            else:
                disease_tested = random.choice(diseases)

            result = "Negative" if random.random() < 0.85 else "Positive"

            if disease_tested is None:
                comments = "Test data incomplete"
            elif result == "Negative":
                comments = f"No {disease_tested} detected"
            else:
                comments = f"{disease_tested} detected, follow-up required"

        #  General Health
        else:
            test_type = "General Health"
            disease_tested = None

            result = "Positive" if random.random() < 0.9 else "Negative"

            if result == "Positive":
                comments = "Donor is in good health condition"
            else:
                comments = "Minor health issues detected"

        chunk_data.append([
            test_id,
            donor_id,
            technician_id,
            test_date,
            disease_tested,
            result,
            test_type,
            comments
        ])

        test_id += 1

    chunk_df = pd.DataFrame(chunk_data, columns=[
        "test_id","donor_id","technician_id","date",
        "disease_tested","result","test_type","comments"
    ])

    # Fix nullable ints
    chunk_df["technician_id"] = chunk_df["technician_id"].astype("Int64")

    chunk_df.to_csv(file_name, mode='a', header=False, index=False)

    print(f"Processed {test_id - 1} test records")

print("blood_tests.csv generated successfully")