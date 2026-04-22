import pandas as pd

# Base task list (your existing + extended)
tasks = [
    "Blood collection",
    "Equipment maintenance",
    "Data entry",
    "Lab equipment calibration",
    "Blood typing and testing",
    "Inventory management",
    "Donor screening",
    "Quality control",
    "Regulatory compliance",
    "Patient data recording",
    "Staff training",
    "Blood storage management",
    "Donation appointment scheduling",
    "Public awareness campaign",
    "Emergency response planning",
    "Medical record keeping",
    "Facility cleaning and sterilization",
    "Supply chain coordination",
    "Health and safety audit",
    "Volunteer coordination",
    "Cold chain monitoring",
    "Blood bag labeling",
    "Cross-matching procedures",
    "Sample collection",
    "Testing equipment validation",
    "Waste disposal management",
    "Donor follow-up",
    "Adverse reaction monitoring",
    "Inventory auditing",
    "Shipment coordination",
    "Blood transport logistics",
    "Laboratory documentation",
    "Donor eligibility verification",
    "Consent form processing",
    "Emergency blood request handling",
    "Stock replenishment planning",
    "Quality assurance checks",
    "Lab result validation",
    "Patient matching verification",
    "Cold storage inspection",
    "Equipment sterilization",
    "Test sample tracking",
    "Donor registration",
    "Appointment reminders",
    "Blood unit tracking",
    "Compliance reporting",
    "Audit preparation",
    "Clinical data review",
    "Inventory reconciliation",
    "Safety protocol enforcement"
]

data = []

for i, task in enumerate(tasks, start=1):
    data.append({
        "task_id": i,
        "description": task
    })

df = pd.DataFrame(data)

df.to_csv("tasks.csv", index=False)

print("CSV generated: tasks.csv")