import pandas as pd
import random

NUM_RECORDS = 200000   # scalable
CHUNK_SIZE = 50000

# Load only required columns (lighter)
donations_df = pd.read_csv("donations.csv", usecols=["donation_id", "donor_id"])

# Sample required records (NO shuffle needed)
sample_df = donations_df.sample(n=NUM_RECORDS, replace=False).reset_index(drop=True)

file_name = "donor_history.csv"

# Write header
pd.DataFrame(columns=[
    "history_id", "donor_id", "donation_id", "reaction", "notes"
]).to_csv(file_name, index=False)

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

history_id = 1

for start in range(0, NUM_RECORDS, CHUNK_SIZE):

    chunk = sample_df.iloc[start:start + CHUNK_SIZE]

    chunk_data = []

    for _, row in chunk.iterrows():

        donation_id = int(row["donation_id"])
        donor_id = int(row["donor_id"])

        reaction = get_reaction()

        chunk_data.append([
            history_id,
            donor_id,
            donation_id,
            reaction,
            get_notes(reaction)
        ])

        history_id += 1

    chunk_df = pd.DataFrame(chunk_data, columns=[
        "history_id", "donor_id", "donation_id", "reaction", "notes"
    ])

    chunk_df.to_csv(file_name, mode='a', header=False, index=False)

    print(f"Processed {history_id - 1} history records")

print("donor_history.csv generated successfully")