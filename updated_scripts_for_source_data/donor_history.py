# ============================================================
# MOCK DATA GENERATION LOGIC – DONOR HISTORY
# ============================================================

# 1. Donor history derived from donations
# - Each history record is linked to an existing donation_id and donor_id
# - Ensures consistency between donation events and donor reactions

# 2. Subset selection (not all donations included)
# - Only a sample (200k) of total donations is used
# - Reflects real-world scenario where not every donation has recorded feedback

# 3. Reaction distribution (realistic behavior)
# - Majority (~70%) → no reaction
# - Some (~25%) → mild reaction
# - Very few (~5%) → severe reaction
# - Mimics real-world post-donation outcomes

# 4. Reaction-dependent notes
# - Notes are generated based on reaction severity
# - Ensures logical consistency between reaction and description
# - Avoids random or contradictory data

# 5. One-to-one mapping with donation
# - Each selected donation gets one history record
# - Maintains clear relationship between donation and donor experience

# 6. No additional randomness in relationships
# - donor_id is always derived from donation data (not randomly assigned)
# - Prevents data integrity issues

# 7. Chunk-based processing for performance
# - Data generated in chunks (50k rows)
# - Efficient for large-scale data generation and avoids memory issues

# 8. No temporal attributes included
# - History is tied to donation events rather than separate timestamps
# - Simplifies analysis while still providing useful behavioral insights

# 9. Purpose of dataset
# - Supports analysis such as:
#   • Donor experience and safety monitoring
#   • Reaction rate analysis
#   • Identifying high-risk donors
#   • Enhancing donor retention strategies

# 10. Data realism focus
# - Distribution and notes designed to resemble real-world medical observations
# - Includes both normal and adverse scenarios for meaningful analytics
# ============================================================


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