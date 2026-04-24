# ============================================================
# MOCK DATA GENERATION LOGIC – BLOOD TYPE COMPATIBILITY
# ============================================================

# 1. Purpose of the dataset
# - Defines compatibility rules between donor and recipient blood groups
# - Used to validate whether a donation can fulfill a request
# - Acts as a reference/lookup table in analytics

# 2. Domain-driven logic (not random data)
# - Data is based on real-world blood transfusion compatibility rules
# - Ensures medically valid relationships between donor and recipient

# 3. One-to-many relationships
# - A single donor blood group can donate to multiple recipient groups
#   Example:
#     O- → universal donor (can donate to all groups)
#     AB+ → universal recipient (can receive from all compatible donors)

# 4. Static reference table
# - This dataset is small and does not change frequently
# - Suitable to be used as a dimension/lookup table in the warehouse

# 5. Supports business logic
# - Enables analysis such as:
#   • Matching supply with compatible demand
#   • Identifying substitution possibilities (e.g., O- used for shortages)
#   • Improving demand vs supply insights beyond exact matches

# 6. No randomness involved
# - Unlike other datasets, this is deterministic and rule-based
# - Ensures consistency across all runs

# ============================================================


import pandas as pd

data = [
    ("A+","A+"), ("A+","AB+"),
    ("A-","A+"), ("A-","A-"), ("A-","AB+"), ("A-","AB-"),
    ("B+","B+"), ("B+","AB+"),
    ("B-","B+"), ("B-","B-"), ("B-","AB+"), ("B-","AB-"),
    ("AB+","AB+"),
    ("AB-","AB+"), ("AB-","AB-"),
    ("O+","A+"), ("O+","B+"), ("O+","O+"), ("O+","AB+"),
    ("O-","A+"), ("O-","A-"), ("O-","B+"), ("O-","B-"),
    ("O-","AB+"), ("O-","AB-"), ("O-","O+"), ("O-","O-")
]

df = pd.DataFrame(data, columns=["donor_blood_type", "recipient_blood_type"])
df.to_csv("blood_type_compatibility.csv", index=False)

print("CSV generated: blood_type_compatibility.csv")