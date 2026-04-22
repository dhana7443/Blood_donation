import pandas as pd
import random
from faker import Faker

fake = Faker()

NUM_RECORDS = 500

hospital_types = ['General', 'Clinic', 'Specialized']
accreditation_statuses = ['Accredited', 'Certified', 'Pending']
operating_hours_options = [
    '24/7',
    '8 AM - 6 PM',
    '9 AM - 5 PM',
    '7 AM - 7 PM',
    '10 AM - 8 PM'
]

cities = [
    "Montreal", "Quebec City", "Laval", "Gatineau", "Longueuil",
    "Sherbrooke", "Trois-Rivières", "Drummondville", "Brossard",
    "Blainville", "Granby", "Repentigny", "Mascouche",
    "Dollard-Des Ormeaux", "Pointe-Claire", "Dorval",
    "Kirkland", "Beaconsfield"
]

domains = ["healthcare.com", "hospital.ca", "medcenter.ca", "clinic.ca"]

#  Clean phone generator
def generate_phone():
    area_codes = ['514', '438', '418', '450']
    area = random.choice(area_codes)
    num = ''.join([str(random.randint(0, 9)) for _ in range(7)])
    return f"{area}-{num[:3]}-{num[3:]}"

#  Canadian postal code format
def generate_postal_code():
    letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    return f"{random.choice(letters)}{random.randint(0,9)}{random.choice(letters)} {random.randint(0,9)}{random.choice(letters)}{random.randint(0,9)}"

data = []

for i in range(1, NUM_RECORDS + 1):

    city = random.choice(cities)

    # Clean hospital name
    name = fake.company()
    hospital_name = name + " Hospital"

    # Clean email (remove special chars)
    username = ''.join(e for e in name.lower() if e.isalnum())
    domain = random.choice(domains)
    email = f"{username}@{domain}"

    row = {
        "hospital_id": i,
        "name": hospital_name,
        "street_address": fake.street_address(),
        "city": city,
        "province": "Quebec",
        "postal_code": generate_postal_code(),
        "country": "Canada",
        "phone_number": generate_phone(),                     
        "email_address": email,
        "hospital_type": random.choice(hospital_types),
        "operating_hours": random.choice(operating_hours_options),
        "accreditation_status": random.choice(accreditation_statuses),
        "emergency_contact": generate_phone() if random.random() < 0.8 else None  
    }

    data.append(row)

df = pd.DataFrame(data)

df.to_csv("hospitals.csv", index=False)

print("CSV generated: hospitals.csv")