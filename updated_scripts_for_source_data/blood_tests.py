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
        technician_id = random.randint(1, 1000) if random.random() < 0.9 else None

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