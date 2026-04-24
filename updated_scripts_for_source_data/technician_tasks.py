# ============================================================
# MOCK DATA GENERATION LOGIC – TECHNICIAN TASK ASSIGNMENTS
# ============================================================

# 1. Bridge table (many-to-many relationship)
# - Links technicians with tasks
# - A technician can perform multiple tasks
# - A task can be performed by multiple technicians

# 2. Coverage of technicians
# - All technicians (1–10000) are included
# - Ensures every technician has assigned responsibilities

# 3. Controlled task assignment
# - Each technician is assigned 2–5 tasks
# - Prevents unrealistic extremes (no tasks or too many tasks)

# 4. Task selection
# - Tasks are randomly selected from predefined task list (1–50)
# - Ensures coverage across different operational activities

# 5. No duplicate assignments
# - Each (technician_id, task_id) pair is unique
# - Maintains data integrity and avoids redundancy

# 6. Balanced workload simulation
# - Distribution ensures technicians have varied but limited responsibilities
# - Reflects real-world role specialization

# 7. Lightweight relationship table
# - Only includes foreign keys (technician_id, task_id)
# - Optimized for joins with dim_technicians and dim_tasks

# 8. Supports operational analysis
# - Enables analysis such as:
#   • Task distribution across technicians
#   • Workload balancing
#   • Skill/task mapping
#   • Operational efficiency

# 9. No temporal attributes included
# - Assignments are static (no start/end dates)
# - Simplifies modeling while still enabling useful insights

# 10. Design focus
# - Represents real-world many-to-many relationships
# - Enhances completeness of the data model
# ============================================================


import pandas as pd
import random

NUM_TECHNICIANS = 10000   # from dim_technicians
NUM_TASKS = 50           # from dim_tasks

data = []
pairs = set()

for tech_id in range(1, NUM_TECHNICIANS + 1):

    # Each technician gets 2–5 tasks
    num_tasks = random.randint(2, 5)

    assigned_tasks = random.sample(range(1, NUM_TASKS + 1), num_tasks)

    for task_id in assigned_tasks:

        pair = (tech_id, task_id)

        # Avoid duplicates
        if pair not in pairs:
            pairs.add(pair)

            data.append({
                "technician_id": tech_id,
                "task_id": task_id
            })

df = pd.DataFrame(data)

df.to_csv("technician_tasks.csv", index=False)

print("CSV generated: technician_tasks.csv")