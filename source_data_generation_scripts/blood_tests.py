import pandas as pd
import random
from faker import Faker

fake = Faker()

NUM_RECORDS = 80000   # slightly less than donations 

diseases = ['HIV', 'Hepatitis B', 'Hepatitis C', 'Malaria']

data = []

donors_df = pd.read_csv("donors.csv")
donor_blood_map = dict(zip(donors_df["donor_id"], donors_df["blood_group"]))

for i in range(1, NUM_RECORDS + 1):

    donor_ids = list(range(1, 20001))
    donor_id = random.choice(donor_ids)

    # Technician (nullable)
    technician_id = random.randint(1, 1000) if random.random() < 0.9 else None

    # Date (include some invalid)
    if random.random() < 0.02:
        test_date = "0000-00-00"
    else:
        test_date = fake.date_between(start_date='-3y', end_date='today')

    # Test type selection
    r = random.random()

    if r < 0.4:
        test_type = "Blood Typing"
        disease_tested = None
        result = "Positive"   # always positive (means valid type)
        blood_group = donor_blood_map.get(donor_id, "Unknown")
        comments = f"Blood group {blood_group} confirmed"

    elif r < 0.8:
        
        test_type = "Disease Screening"

        if random.random() < 0.08:
            disease_tested = None   # intentional bad data
        else:
            disease_tested = random.choice(diseases)

        result = "Negative" if random.random() < 0.85 else "Positive"

        if disease_tested is None:
            comments = "Test data incomplete"
        elif result == "Negative":
            comments = f"No {disease_tested} detected"
        else:
            comments = f"{disease_tested} detected, follow-up required"

    else:
        test_type = "General Health"
        disease_tested = None

        result = "Positive" if random.random() < 0.9 else "Negative"

        if result == "Positive":
            comments = "Donor is in good health condition"
        else:
            comments = "Minor health issues detected"

    data.append({
        "test_id": i,
        "donor_id": donor_id,
        "technician_id": technician_id,
        "date": test_date,
        "disease_tested": disease_tested,
        "result": result,
        "test_type": test_type,
        "comments": comments
    })

df = pd.DataFrame(data)

# Fix nullable integers
df["technician_id"] = df["technician_id"].astype("Int64")

df.to_csv("blood_tests.csv", index=False)

print("CSV generated: blood_tests.csv")