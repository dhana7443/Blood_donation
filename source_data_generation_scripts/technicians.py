import pandas as pd
import random
from faker import Faker

fake = Faker()

NUM_RECORDS = 1000

qualifications = [
    "Certified Phlebotomist",
    "Medical Lab Technician",
    "Clinical Laboratory Technologist",
    "Biomedical Scientist",
    "Blood Bank Specialist",
    "Clinical Biochemist",
    "Hematology Technician",
    "Immunology Technician",
    "Laboratory Supervisor",
    "Pathology Assistant",
    "Toxicology Technician",
    "Clinical Research Technician",
    "Diagnostic Technician",
    "Blood Transfusion Officer",
    "Medical Laboratory Assistant",
    "Quality Control Analyst",
    "Serology Technician",
    "Tissue Typing Specialist",
    "Clinical Trials Coordinator"
]

domains = ["healthcare.com", "hospital.ca", "medcenter.ca", "labservices.ca"]

#  Clean phone generator
def generate_phone():
    area_codes = ['514', '438', '418', '450']
    area = random.choice(area_codes)
    num = ''.join([str(random.randint(0, 9)) for _ in range(7)])
    return f"{area}-{num[:3]}-{num[3:]}"

data = []

for i in range(1, NUM_RECORDS + 1):

    # Primary hospital (mostly present)
    hospital_id = random.randint(1, 300) if random.random() < 0.9 else None

    # Assigned hospital (optional and must be different)
    if random.random() < 0.4:
        assigned_hospital_id = random.randint(1, 300)

        # Ensure different from primary
        while assigned_hospital_id == hospital_id:
            assigned_hospital_id = random.randint(1, 300)
    else:
        assigned_hospital_id = None

    # Name
    name = fake.name()

    # Clean email username (remove special chars)
    username = ''.join(c for c in name.lower() if c.isalnum() or c == ' ').replace(" ", ".")
    domain = random.choice(domains)
    email = f"{username}@{domain}"

    row = {
        "technician_id": i,
        "hospital_id": hospital_id,
        "assigned_hospital_id": assigned_hospital_id,
        "name": name,
        "qualification": random.choice(qualifications),
        "phone_number": generate_phone(),   
        "email_address": email
    }

    data.append(row)

df = pd.DataFrame(data)

#  Fix float issue (VERY IMPORTANT)
df["hospital_id"] = df["hospital_id"].astype("Int64")
df["assigned_hospital_id"] = df["assigned_hospital_id"].astype("Int64")

# Save CSV
df.to_csv("technicians.csv", index=False)

print("CSV generated: technicians.csv")