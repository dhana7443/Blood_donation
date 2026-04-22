import pandas as pd
import random

NUM_RECORDS = 50000

# Load donations
donations_df = pd.read_csv("donations.csv")

# Mapping: donation_id → donor_id
donation_donor_map = dict(zip(donations_df["donation_id"], donations_df["donor_id"]))

# Get donation IDs
donation_ids = list(donation_donor_map.keys())
random.shuffle(donation_ids)

# Select subset
selected_donations = donation_ids[:NUM_RECORDS]

def get_reaction():
    r = random.random()
    if r < 0.7:
        return 'none'
    elif r < 0.95:
        return 'mild'
    else:
        return 'severe'

def get_notes(reaction):
    if reaction == 'none':
        return random.choice([
            "No reaction, donor felt fine",
            "Everything normal",
            "No issues reported",
            "Donor in good condition",
            "No adverse reactions"
        ])
    elif reaction == 'mild':
        return random.choice([
            "Mild dizziness after donation",
            "Mild fatigue",
            "Light-headedness",
            "Slight nausea",
            "Mild arm pain"
        ])
    else:
        return random.choice([
            "Severe nausea post-donation",
            "Fainted, required medical attention",
            "Severe dizziness observed",
            "Admitted for observation"
        ])

data = []

for i, donation_id in enumerate(selected_donations):

    #  Get correct donor_id from mapping
    donor_id = donation_donor_map[donation_id]

    reaction = get_reaction()

    data.append({
        "history_id": i + 1,
        "donor_id": donor_id,
        "donation_id": donation_id,
        "reaction": reaction,
        "notes": get_notes(reaction)
    })

df = pd.DataFrame(data)

df.to_csv("donor_history.csv", index=False)

print("CSV generated: donor_history.csv")