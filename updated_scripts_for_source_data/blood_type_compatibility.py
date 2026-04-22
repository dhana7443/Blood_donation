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