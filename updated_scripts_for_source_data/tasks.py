# ============================================================
# MOCK DATA GENERATION LOGIC – TASKS (REFERENCE DIMENSION)
# ============================================================

# 1. Task reference dataset
# - Each record represents a predefined operational task
# - Acts as a lookup/dimension table for operational or workforce-related analysis

# 2. Domain-driven task list (not random)
# - Tasks are manually curated based on real-world blood bank operations
# - Covers end-to-end processes:
#     • Collection (Blood collection, Donor screening)
#     • Testing (Blood typing, Cross-matching)
#     • Storage (Cold chain monitoring, Inventory management)
#     • Logistics (Transport, Shipment coordination)
#     • Compliance (Regulatory checks, Audits)
#     • Support activities (Training, Awareness campaigns)

# 3. Unique task identification
# - Each task is assigned a unique task_id
# - Ensures consistency and easy referencing in downstream systems

# 4. No duplication or ambiguity
# - Each task description is distinct and clearly defined
# - Avoids overlapping or redundant task definitions

# 5. Static reference table
# - Dataset is small and does not change frequently
# - Suitable to be used as a dimension/lookup table in the warehouse

# 6. Supports operational analytics
# - Can be used for:
#   • Task assignment tracking
#   • Workforce or technician activity analysis
#   • Process-level monitoring
#   • Compliance and audit reporting

# 7. Simplified structure
# - Only includes task_id and description
# - Keeps the table lightweight and easy to join

# 8. No randomness involved
# - Fully deterministic dataset
# - Ensures consistency across runs

# 9. Design focus
# - Provides structured representation of operational workflows
# - Enhances analytical depth beyond core fact tables

# ============================================================


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