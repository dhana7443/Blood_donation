# ============================================================
# MOCK DATA GENERATION LOGIC – TECHNICIANS (DIMENSION)
# ============================================================

# 1. Technician master dataset (dimension table)
# - Each record represents a healthcare/lab technician
# - Used across donations, tests, and operational workflows

# 2. Hospital association logic
# - Most technicians (~90%) are linked to a primary hospital
# - Some technicians have an additional assigned_hospital_id
# - Ensures technicians can work across multiple facilities
# - Assigned hospital is always different from primary hospital

# 3. Qualification-based roles
# - Each technician is assigned a realistic medical/lab qualification
# - Covers various specializations (phlebotomy, hematology, pathology, etc.)
# - Enables role-based analysis and task mapping

# 4. Clean and realistic contact details
# - Phone numbers follow structured Canadian format
# - Email usernames are cleaned to remove special characters
# - Ensures consistent and usable communication data

# 5. Optional relationships (real-world simulation)
# - hospital_id and assigned_hospital_id can be null
# - Simulates contractors, floating staff, or incomplete records

# 6. Data integrity rules
# - technician_id is unique
# - assigned_hospital_id ≠ hospital_id (no duplication)
# - No conflicting or invalid relationships

# 7. Lightweight dimension design
# - Contains only descriptive attributes (no transactional data)
# - Optimized for joins with fact tables and bridge tables

# 8. Integration with other datasets
# - Links with:
#     • fact_donations (collection/processing technicians)
#     • fact_tests (lab technicians)
#     • technician_tasks (bridge table for task assignments)

# 9. Purpose of dataset
# - Supports analysis such as:
#   • Workforce distribution across hospitals
#   • Skill/qualification-based analysis
#   • Task assignment and workload tracking
#   • Operational efficiency

# 10. Design focus
# - Combines structured attributes with controlled randomness
# - Ensures realistic and analytically useful data
# ============================================================


import pandas as pd
import random
from faker import Faker

fake = Faker()

NUM_RECORDS = 10000

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
    hospital_id = random.randint(1, 500) if random.random() < 0.9 else None

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